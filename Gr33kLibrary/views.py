from django.shortcuts import render,HttpResponseRedirect,render_to_response
from django.http import JsonResponse,FileResponse,StreamingHttpResponse
from Gr33kLibrary.models import *
import hashlib,base64
import json
import markdown
from Gr33kLibrary.func import *
import datetime
from zslibrary.settings import BASE_DIR
import time
import html
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
import threading
import queue
import re
import requests
from django.db.models import Q
# Create your views here.



def about_me(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        current_user = None
    context = {
        'current_user': current_user,
    }
    return render(request,'about_me.html',context=context)


def page_main(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        current_user = None
    if request.method == "GET":
        last_update_logs = Update_log.objects.all().order_by('-create_time')[:5]
        update_logs = []
        for last_update_log in last_update_logs:
            last_update_log.content = markdown.markdown(last_update_log.content.replace('<','&lt;').replace('>','&gt;'), extensions=[
                'markdown.extensions.extra',
                'markdown.extensions.codehilite',
                'markdown.extensions.toc',
            ])
            update_logs.append(last_update_log)
        all_article = Article.objects.filter(state=3)
        new_top10_articles = all_article.order_by('-create_time')[:10]
        read_max_articles = all_article.order_by('-read_num')[:10]
        for new_top10_article in new_top10_articles:
            if new_top10_article.title.__len__() > 20:
                new_top10_article.title = new_top10_article.title[:20] + '...'

        for read_max_article in read_max_articles:
            if read_max_article.title.__len__() > 20:
                read_max_article.title = read_max_article.title[:20] + '...'

        all_author = User.objects.all()
        for author in all_author:
            author.article_num = Article.objects.filter(state=3).filter(author=author).count()
            author.save()
        top10_authors = User.objects.all().order_by('-article_num')[:10]
        context = {
            'current_user':current_user,
            'last_update_logs':update_logs,
            'new_top10_articles':new_top10_articles,
            'read_max_articles':read_max_articles,
            'top10_authors':top10_authors,
        }
        return render(request,'main.html',context=context)

def login(request):
    if request.method == "GET":
        return render(request,'login.html')
    else:
        username = request.POST.get('username')
        password = request.POST.get('password')
        m = hashlib.md5(password.encode())
        encry_password = m.hexdigest()
        try:
            user = User.objects.get(username=username)
            if user.password == encry_password:
                if not user.is_lock:
                    request.session['user'] = user.id
                    user.login_fail = 0
                    user.save()
                    request.session.set_expiry(36000)
                    return HttpResponseRedirect('/Gr33kLibrary/main/')
                else:
                    context = {
                        'info': '账号已被锁定,请联系管理员解锁'
                    }
                    return render(request, 'login.html', context=context)
            else:
                if user.login_fail < 5:
                    user.login_fail += 1
                    user.save()
                    context = {
                        'info':'账号或密码错误'
                    }
                else:
                    user.is_lock = True
                    user.save()
                    context = {
                        'info': '账号已被锁定,请联系管理员解锁'
                    }
                return render(request,'login.html',context=context)
        except:
            context = {
                'info': '账号或密码错误'
            }
            return render(request, 'login.html', context=context)

def user_manage(request,page_num):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        page_num = int(page_num) - 1
        if current_user.username == "Gr33k":
            all_user = User.objects.all().order_by('create_time')
            user10 = all_user[page_num*10:page_num*10 + 10]
            page_sum = int(all_user.count() / 10) + 1
            if page_num < 0 or page_num >= page_sum:
                context = {
                    'current_user': current_user,
                    'info': '页码有误'
                }
                return render(request, 'show_info.html', context=context)
            new_all_user = []
            for user in user10:
                article_num = Article.objects.filter(author=user).count()
                new_all_user.append(
                    Author(
                        author=user,
                        article_num=article_num,
                        invitation_user=user.invitation_user
                    )
                )
            context = {
                'current_user':current_user,
                'all_user':new_all_user,
                'page_num':page_num + 1,
                'page_sum':page_sum,
                'pre_num':page_num,
                'next_num':page_num + 2,
            }
            return render(request,'user_manage.html',context=context)
        else:
            context = {
                'current_user': current_user,
                'info':'您没有权限访问该功能'
            }
            return render(request,'show_info.html',context=context)

def add_user(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username == "Gr33k":
        if request.method == "GET":
            context={
                'current_user':current_user
            }
            return render(request,'add_user.html',context=context)
        else:
            username = request.POST.get('username')
            name = request.POST.get('name')
            password = request.POST.get('password')
            email = request.POST.get('email')
            invitation_code = request.POST.get('invitation_code')
            m = hashlib.md5(password.encode())
            encry_password =m.hexdigest()
            try:
                if User.objects.filter(username=username).count() > 0 or User.objects.filter(invitation_code=invitation_code).count() > 0:
                    context = {
                        'current_user': current_user,
                        'info': '添加异常，请检查输入的用户名和邀请码是否重复'
                    }
                    return render(request, 'add_user.html', context=context)
                user = User.objects.create(
                    username=username,
                    name=name,
                    email=email,
                    password=encry_password,
                    invitation_code=invitation_code,
                    create_time=datetime.datetime.now()
                )
                return HttpResponseRedirect('/Gr33kLibrary/user_manage/1/')
            except:
                context = {
                    'current_user': current_user,
                    'info':'添加异常，请检查输入或者换个用户名'
                }
                return render(request,'add_user.html',context=context)
    else:
        context = {
            'current_user': current_user,
            'info': '您没有权限访问该功能'
        }
        return render(request, 'show_info.html', context=context)

def edite_user(request,user_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username == "Gr33k":
        if request.method == "GET":
            try:
                user = User.objects.get(id=int(user_id))
                context = {
                    'current_user': current_user,
                    'user':user
                }
                return render(request,'edite_user.html',context=context)
            except:
                context = {
                    'current_user': current_user,
                    'info':'用户不存在'
                }
                return render(request,'edite_user.html',context=context)
        else:
            username = request.POST.get('username')
            name = request.POST.get('name')
            email = request.POST.get('email')
            user = User.objects.get(id=int(user_id))
            user.username = username
            user.name = name
            user.email = email
            user.save()
            return HttpResponseRedirect('/Gr33kLibrary/user_manage/1/')
    else:
        context = {
            'current_user': current_user,
            'info': '您没有权限访问该功能'
        }
        return render(request, 'show_info.html', context=context)

def delete_user(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username == "Gr33k":
        if request.method == "POST":
            user_id = request.POST.get('user_id')
            try:
                user = User.objects.get(id=int(user_id))
                user.delete()
                context = {
                    'info':'ok'
                }
                context = json.dumps(context)
                return JsonResponse(context,safe=False)
            except:
                all_user = User.objects.all()
                context = {
                    'current_user': current_user,
                    'all_user':all_user,
                    'info':'用户不存在'
                }
                return render(request, 'user_manage.html', context=context)
        else:
            context = {
                'current_user': current_user,
                'info': '您没有权限访问该功能'
            }
            return render(request, 'show_info.html', context=context)

def classify_manage(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        all_classify = Classify.objects.all().order_by('create_time')
        new_all_classify = []
        for classify in all_classify:
            new_all_classify.append(
                Classify_temp(
                    classify=classify,
                    article_num=Article.objects.filter(state=3).filter(classify=classify).count()
                )
            )
        all_tag = Tag.objects.all().order_by('create_time')
        new_all_tag = []
        for tag in all_tag:
            new_all_tag.append(
                Tag_temp(
                    tag=tag,
                    article_num=get_tag_article(tag.id)
                )
            )
        context = {
            'current_user': current_user,
            'all_classify':new_all_classify,
            'all_tag':new_all_tag,
        }
        return render(request,'classify_manage.html',context=context)

def add_classify(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        context = {
            'current_user': current_user,
        }
        return render(request,'add_classify.html',context=context)
    else:
        classify_name = request.POST.get('classify_name')
        try:
            Classify.objects.create(
                name=classify_name
            )
            return HttpResponseRedirect('/Gr33kLibrary/classify_manage/')
        except:
            context = {
                'current_user': current_user,
                'info':'检查您输入的名称，注意不可重复'
            }
            return render(request,'add_classify.html',context=context)

def delete_classify(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        classify_id = request.POST.get('classify_id')
        classify = Classify.objects.get(id=int(classify_id))
        classify.delete()
        context = {
            'info':'ok'
        }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)


def add_tag(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        context = {
            'current_user': current_user,
        }
        return render(request,'add_tag.html',context=context)
    else:
        tag_name = request.POST.get('tag_name')
        try:
            Tag.objects.create(
                name=tag_name
            )
            return HttpResponseRedirect('/Gr33kLibrary/classify_manage/')
        except:
            context = {
                'current_user': current_user,
                'info':'检查您输入的名称，注意不可重复'
            }
            return render(request,'add_tag.html',context=context)


def delete_tag(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        tag_id = request.POST.get('tag_id')
        tag = Tag.objects.get(id=int(tag_id))
        tag.delete()
        context = {
            'info':'ok'
        }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)


def update_log_index(request):
    return HttpResponseRedirect('/Gr33kLibrary/update_log/1/')


def update_log(request,page_num):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        all_update_log = Update_log.objects.all().order_by('-create_time')
        new_all_update_log = []

        page_sum = int(all_update_log.count() / 10) + 1
        page_num = int(page_num) - 1
        if page_num < 0 or page_num >= page_sum:
            context = {
                'current_user': current_user,
                'info': '页码有误'
            }
            return render(request, 'show_info.html', context=context)

        all_update_log = all_update_log[page_num*10:page_num*10 + 10]

        for update_log in all_update_log:
            update_log.content = markdown.markdown(update_log.content.replace('<','&lt;').replace('>','&gt;'), extensions=[
                'markdown.extensions.extra',
                'markdown.extensions.codehilite',
                'markdown.extensions.toc',
            ])
            new_all_update_log.append(update_log)
        context = {
            'current_user': current_user,
            'all_update_log':new_all_update_log,
            'page_num': page_num + 1,
            'page_sum': page_sum,
            'pre_num': page_num,
            'next_num': page_num + 2,
        }
        return render(request,'update_log_manage.html',context=context)


def add_update_log(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        content = request.POST.get('content')
        Update_log.objects.create(content=content)
        return HttpResponseRedirect('/Gr33kLibrary/update_log/')

def delete_update_log(request,update_log_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        update_log = Update_log.objects.get(id=int(update_log_id))
        update_log.delete()
        return HttpResponseRedirect('/Gr33kLibrary/update_log/')

def myarticle(request,page_num):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        if current_user.username == "Gr33k":
            my_articles = Article.objects.all().order_by('-update_time')
        else:
            my_articles = Article.objects.filter(author=current_user).order_by('-update_time')
        page_sum = int(my_articles.count() / 10) + 1
        page_num = int(page_num) - 1
        if page_num < 0 or page_num >= page_sum:
            context = {
                'current_user': current_user,
                'info': '页码有误'
            }
            return render(request, 'show_info.html', context=context)
        my_articles = my_articles[page_num*10:page_num*10 + 10]
        new_articles = []
        for article in my_articles:
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except Exception as e:
                tags = []
            new_articles.append(
                Article_temp(
                    article,
                    tags
                )
            )
        context = {
            'current_user': current_user,
            'my_articles':new_articles,
            'page_num': page_num + 1,
            'page_sum': page_sum,
            'pre_num': page_num,
            'next_num': page_num + 2,
        }
        return render(request,'myarticle.html',context=context)


def create_article(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        all_classify = Classify.objects.all()
        all_tag = Tag.objects.all()
        context = {
            'current_user': current_user,
            'all_classify':all_classify,
            'all_tag':all_tag
        }
        return render(request,'create_article.html',context=context)
    else:
        title = request.POST.get('title')
        classify = Classify.objects.get(id=int(request.POST.get('classify')))
        tags = request.POST.getlist('tag')
        content = request.POST.get('content')
        action = request.POST.get('action')
        article_type = request.POST.get('article_type')
        article_link = request.POST.get('article_link')
        if action == "save":
            Article.objects.create(
                author=current_user,
                title=title,
                classify=classify,
                tags=list2str(tags),
                content=content,
                create_time=datetime.datetime.now(),
                state=1,
                type=int(article_type),
                article_link=article_link,
                update_time=datetime.datetime.now()
            )
        else:
            Article.objects.create(
                author=current_user,
                title=title,
                classify=classify,
                tags=list2str(tags),
                content=content,
                create_time=datetime.datetime.now(),
                state=2,
                type=int(article_type),
                article_link=article_link,
                update_time=datetime.datetime.now()
            )
        return HttpResponseRedirect('/Gr33kLibrary/myarticle/1/')


def edite_article(request,article_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        article = Article.objects.get(id=int(article_id))
        if current_user == article.author or current_user.username == "Gr33k":
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except:
                tags = []
            new_tags = []
            for tag in tags:
                new_tags.append(int(tag))
            context = {
                'current_user': current_user,
                'article':article,
                'tags':new_tags,
                'all_tags':Tag.objects.all(),
                'all_classify':Classify.objects.all(),
            }
            return render(request,'edite_article.html',context=context)
        else:
            context = {
                'current_user': current_user,
                'info':'您无权操作该文章'
            }
            return render(request,'show_info.html',context=context)
    else:
        article =Article.objects.get(id=int(article_id))
        title = request.POST.get('title')
        classify = Classify.objects.get(id=int(request.POST.get('classify')))
        tags = request.POST.getlist('tag')
        content = request.POST.get('content')
        action = request.POST.get('action')
        article_type = request.POST.get('article_type')
        article_link = request.POST.get('article_link')
        if current_user == article.author or current_user.username == "Gr33k":
            article.title = title
            article.classify = classify
            article.tags = list2str(tags)
            article.content = content
            article.type = int(article_type)
            article.article_link = article_link
            article.update_time = datetime.datetime.now()
            if action == "save":
                article.state = 1
            else:
                article.state = 2
            article.save()
            tags = article.tags.split(',')
            if '' in tags:
                tags.remove('')
            new_tags = []
            for tag in tags:
                new_tags.append(int(tag))
            context = {
                'current_user': current_user,
                'article': article,
                'tags': new_tags,
                'all_tags': Tag.objects.all(),
                'all_classify': Classify.objects.all(),
                'info':'<script>alert("保存成功")</script>',
            }
            return render(request,'edite_article.html',context=context)
        else:
            context = {
                'current_user': current_user,
                'info': '您无权操作该文章'
            }
            return render(request, 'show_info.html', context=context)

def delete_article(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        article_id = request.POST.get('article_id')
        try:
            article = Article.objects.get(id=int(article_id))
            if article.author == current_user or current_user.username == "Gr33k":
                article.delete()
                context = {
                    'info':'ok'
                }
            else:
                context = {
                    'info': 'error'
                }
        except:
            context = {
                'info':'error'
            }
        context = json.dumps(context)
        return JsonResponse(context, safe=False)

def tools_manage_index(request):
    return HttpResponseRedirect('/Gr33kLibrary/tools_manage/1/')


def tools_manage(request,page_num):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        all_tools = Tool.objects.all().order_by('-create_time')
        page_sum = int(all_tools.count() / 10) + 1
        page_num = int(page_num) - 1
        if page_num < 0 or page_num >= page_sum:
            context = {
                'current_user': current_user,
                'info': '页码有误'
            }
            return render(request, 'show_info.html', context=context)
        my_tools = all_tools[page_num*10:page_num*10 + 10]
        context = {
            'current_user': current_user,
            'all_tools':my_tools,
            'page_num': page_num + 1,
            'page_sum': page_sum,
            'pre_num': page_num,
            'next_num': page_num + 2,
        }
        return render(request,'tools_manage.html',context=context)

def search_tools(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        keytext = request.POST.get('keytext')
        search_tools = Tool.objects.filter(name__icontains=keytext)
        context = {
            'current_user':current_user,
            'all_tools':search_tools,
        }
        return render(request,'tools_manage.html',context=context)


def upload_tool(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        context = {
            'current_user': current_user,
        }
        return render(request,'upload_tool.html',context=context)
    else:
        file = request.FILES.get('file')
        tool_name = request.POST.get('tool_name')
        path = BASE_DIR + '/tools/'
        file_size = file.size
        filename_old = file.name
        filename_new = str(time.time() * 1000000) + '.' + filename_old.split('.')[-1]
        if not os.path.exists(path):
            os.makedirs(path)
            wrire_file(file, path, filename_new)
        else:
            wrire_file(file, path, filename_new)
        Tool.objects.create(
            name=tool_name,
            path=BASE_DIR + '/tools/' + filename_new,
            file_size=convertBytes(file_size),
            upload_user=current_user,
        )
        return HttpResponseRedirect('/Gr33kLibrary/tools_manage/')

def delete_tool(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        tool_id = request.POST.get('tool_id')
        try:
            tool = Tool.objects.get(id=int(tool_id))
            if tool.upload_user == current_user or current_user.username == "Gr33k":
                os.system('rm -rf ' + tool.path)
                tool.delete()
                context = {
                    'info':'ok'
                }
            else:
                context = {
                    'info': 'error'
                }
        except:
            context = {
                'info': 'error'
            }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)

def article_detail(request,article_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        article = Article.objects.get(id=int(article_id))
        article.read_num += 1
        article.save()
        if article.state == 3:
            article.content = markdown.markdown(article.content, extensions=[
                'markdown.extensions.extra',
                'markdown.extensions.codehilite',
                'markdown.extensions.toc',
            ])
            article.content = article.content.replace('<img alt=', '<img style="width: 50%" alt=')
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except:
                tags = []
            article_temp = Article_temp(
                article=article,
                tags=tags
            )
            collecs = Collect.objects.filter(article=article)
            collec_num = collecs.count()
            if collecs.filter(user=current_user).count() > 0:
                current_user_collect_state = 1
            else:
                current_user_collect_state = 0
            context = {
                'current_user': current_user,
                'article':article_temp,
                'collec_num':collec_num,
                'current_user_collect_state':current_user_collect_state
            }
            return render(request,'article_detail.html',context=context)
        else:
            context = {
                'current_user': current_user,
                'info': '没有找到这篇文章'
            }
            return render(request,'show_info.html',context=context)

def search_result(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    keytext = request.POST.get('keytext')
    all_article = Article.objects.filter(Q(state=3) & (Q(title__icontains=keytext) | Q(content__icontains=keytext))).order_by('-update_time')

    all_article_temps = []
    for article in all_article:
        article.content = article.content[:60] + '...'
        try:
            tags = article.tags.split(',')
            if '' in tags:
                tags.remove('')
        except:
            tags = []
        all_article_temps.append(
            Article_temp(
                article=article,
                tags=tags
            )
        )
    context = {
        'current_user': current_user,
        'all_article':all_article_temps,
        'keytext':keytext
    }

    return render(request,'search_result.html',context=context)

def logout(request):
    request.session.clear()
    return HttpResponseRedirect('/Gr33kLibrary/login/')

def my_setting(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        name = current_user.name
        email = current_user.email
        invitation_code = current_user.invitation_code
        context = {
            'current_user':current_user,
            'name':name,
            'email':email,
            'invitation_code':invitation_code,
        }
        return render(request,'my_setting.html',context=context)
    else:
        name = request.POST.get('name')
        email = request.POST.get('email')
        current_user.name = name
        current_user.email = email
        current_user.save()
        context = {
            'current_user': current_user,
            'info':'保存成功',
            'name': name,
            'email': email,
            'invitation_code': current_user.invitation_code,
        }
        return render(request,'my_setting.html',context=context)

def change_user_state(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        if current_user.username == "Gr33k":
            user_id = request.POST.get('user_id')
            user = User.objects.get(id=int(user_id))
            user.is_lock = not user.is_lock
            user.save()
            context = {
                'info':'ok'
            }
            context = json.dumps(context)
            return JsonResponse(context,safe=False)

def reset_password(request,user_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        if current_user.username == "Gr33k":
            password = request.POST.get('password')
            m = hashlib.md5(password.encode())
            encry_password = m.hexdigest()
            user = User.objects.get(id=int(user_id))
            user.password = encry_password
            user.save()
            context = {
                'user':user,
                'reset_password_info':'重制成功'
            }
            return render(request,'edite_user.html',context=context)
        else:
            context = {
                'current_user':current_user,
                'info':'您无权访问该功能'
            }
            return render(request,'show_info.html',context=context)


def download_tool(request,tool_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        try:

            def file_iterator(file_name, chunk_size=2048):
                with open(file_name,'rb') as f:
                    while True:
                        c = f.read(chunk_size)
                        if c:
                            yield c
                        else:
                            break

            tool = Tool.objects.get(id=int(tool_id))
            response = StreamingHttpResponse(file_iterator(BASE_DIR + tool.path.split('/zslibrary')[-1]))
            response['Content-Type'] = 'application/octet-stream'
            response['Content-Disposition'] = 'attachment;filename="' + tool.path.split('/')[-1].encode("utf-8").decode("ISO-8859-1") + '"'
            return response
        except:
            context = {
                'current_user':current_user,
                'info':'该文件已删除'
            }
            return render(request,'show_info.html',context=context)

def invitation_code_manage(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        invitation_code = current_user.invitation_code
        users = User.objects.filter(invitation_user=current_user.id)
        context = {
            'current_user':current_user,
            'invitation_code':invitation_code,
            'all_user':users
        }
        return render(request,'invitation_code_manage.html',context=context)


def register(request):
    if request.method == "GET":
        return render(request,'register.html')
    else:
        username = request.POST.get('username')
        name = request.POST.get('name')
        password = request.POST.get('password')
        re_password = request.POST.get('password')
        email = request.POST.get('email')
        invitation_code = request.POST.get('invitation_code')
        try:
            invitation_user = User.objects.get(invitation_code=invitation_code)
            if invitation_user.invitation_num > 4:
                context = {
                    'username': username,
                    'name': name,
                    'email': email,
                    'password': password,
                    're_password': re_password,
                    'invitation_code': invitation_code,
                    'info': '邀请码无效'
                }
                return render(request, 'register.html', context=context)
        except:
            context = {
                'username': username,
                'name': name,
                'email': email,
                'password': password,
                're_password': re_password,
                'invitation_code': invitation_code,
                'info':'邀请码无效'
            }
            return render(request,'register.html',context=context)
        if password == re_password:
            m = hashlib.md5(password.encode())
            encry_password = m.hexdigest()
            try:
                if User.objects.filter(username=username).count() > 0:
                    context = {
                        'username': username,
                        'name': name,
                        'email': email,
                        'password': password,
                        're_password': re_password,
                        'invitation_code': invitation_code,
                        'info': '注册失败,该用户名已被使用'
                    }
                    return render(request,'register.html',context=context)
                user = User.objects.create(
                    username=username,
                    name=name,
                    email=email,
                    password=encry_password,
                    invitation_user=invitation_user.id,
                    create_time=datetime.datetime.now()
                )
                invitation_user.invitation_num += 1
                invitation_user.save()
                context = {
                    'info':'注册成功,请登录'
                }
                return render(request,'login.html',context=context)
            except Exception as e:
                print(e)
                context = {
                    'username':username,
                    'name':name,
                    'email':email,
                    'password':password,
                    're_password':re_password,
                    'invitation_code':invitation_code,
                    'info': '注册失败,请换个用户名或者检查输入'
                }
                return render(request, 'register.html', context=context)

def preview(request,article_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        try:
            article = Article.objects.get(id=int(article_id))
        except:
            context = {
                'current_user':current_user,
                'info':'您无权限访问'
            }
            return render(request,'show_info.html',context=context)
        try:
            tags = article.tags.split(',')
            if '' in tags:
                tags.remove('')
        except:
            tags = []
        article_temp = Article_temp(
            article=article,
            tags=tags
        )
        if article.state == 1 and article.author == current_user or current_user.username == "Gr33k":
            article.content = markdown.markdown(article.content, extensions=[
                'markdown.extensions.extra',
                'markdown.extensions.codehilite',
                'markdown.extensions.toc',
            ])
            article.content = article.content.replace('<img alt=', '<img style="width: 50%" alt=').replace('(','（').replace(')','）')
            context = {
                'current_user': current_user,
                'article': article_temp
            }
            return render(request, 'article_detail.html', context=context)
        else:
            context = {
                'current_user': current_user,
                'info':'预览不存在'
            }
            return render(request,'show_info.html',context=context)


def change_password(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        context = {
            'current_user':current_user
        }
        return render(request,'change_password.html',context=context)
    else:
        password = request.POST.get('password')
        new_password = request.POST.get('new_password')
        re_new_password = request.POST.get('re_new_password')
        if new_password == re_new_password:
            m = hashlib.md5(password.encode())
            encry_password = m.hexdigest()
            if current_user.password == encry_password:
                m = hashlib.md5(new_password.encode())
                new_encry_password = m.hexdigest()
                current_user.password = new_encry_password
                current_user.save()
                context = {
                    'current_user': current_user,
                    'info':'修改成功'
                }
            else:
                context = {
                    'current_user': current_user,
                    'info': '原密码错误'
                }
        else:
            context = {
                'current_user': current_user,
                'info': '两次密码输入不一致'
            }
        return render(request, 'change_password.html', context=context)

def verify(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username != "Gr33k":
        context = {
            'current_user':current_user,
            'info':'您无权访问该功能'
        }
        return render(request,'show_info.html',context=context)
    if request.method == "GET":
        verify_articles = Article.objects.filter(state=2)
        new_articles = []
        for article in verify_articles:
            if article.title.__len__() > 20:
                article.title = article.title[:20] + '...'
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except:
                tags = []
            new_articles.append(
                Article_temp(
                    article,
                    tags
                )
            )
        context = {
            'current_user':current_user,
            'my_articles':new_articles,
        }
        return render(request,'verify.html',context=context)


def back_article(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username != "Gr33k":
        context = {
            'current_user':current_user,
            'info':'您无权访问该功能'
        }
        return render(request,'show_info.html',context=context)
    if request.method == "POST":
        article_id = request.POST.get('article_id')
        back_info = request.POST.get('back_info')
        article = Article.objects.get(id=int(article_id))
        article.state = 4
        article.back_info = back_info
        article.save()
        context = {
            'info': 'ok'
        }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)

def verify_article(request,article_id):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if current_user.username != "Gr33k":
        context = {
            'current_user':current_user,
            'info':'您无权访问该功能'
        }
        return render(request,'show_info.html',context=context)
    if request.method == "GET":
        article = Article.objects.get(id=int(article_id))
        article.state = 3
        article.save()
        Update_log.objects.create(
            content="**" + article.author.name + "** 在 " + article.classify.name + " 栏目发表了 **《" + article.title + "》**"
        )
        return HttpResponseRedirect('/Gr33kLibrary/verify/')

def show_back_info(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        article_id = request.POST.get('article_id')
        article = Article.objects.get(id=int(article_id))
        if article.author == current_user or current_user.username == "Gr33k":
            context = {
                'info':'ok',
                'back_info':article.back_info
            }
        else:
            context = {
                'info': 'error',
            }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)

# def library(request):
#     try:
#         current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
#     except:
#         current_user = None
#     if request.method == "GET":
#         all_article = Article.objects.filter(state=3).order_by('-update_time')
#         all_article_temps = []
#         for article in all_article:
#             try:
#                 tags = article.tags.split(',')
#                 if '' in tags:
#                     tags.remove('')
#             except:
#                 tags = []
#             all_article_temps.append(
#                 Article_temp(
#                     article=article,
#                     tags=tags
#                 )
#             )
#
#         all_classify = Classify.objects.all().order_by('name')
#         all_users = User.objects.all().order_by('name')
#         all_tags = Tag.objects.all().order_by('name')
#         if all_tags.count() > 0:
#             search_tag = all_tags[0].id
#         else:
#             search_tag = ""
#         context = {
#             'current_user': current_user,
#             'all_article': all_article_temps,
#             'all_classify': all_classify,
#             'all_article_num':all_article.count(),
#             'all_users':all_users,
#             'all_tags':all_tags,
#             'search_tag':search_tag,
#             'show_tag_state':1,
#             'search_user':all_users[0].id
#         }
#         return render(request,'library.html',context=context)



def library(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        current_user = None
    if request.method == "GET":
        all_article = Article.objects.filter(state=3).order_by('-update_time')

        all_classify = Classify.objects.all().order_by('name')
        all_users = User.objects.all().order_by('name')
        all_tags = Tag.objects.all().order_by('name')

        all_article_dict = {}
        for classify in all_classify:
            all_article_dict[classify] = all_article.filter(classify_id=classify.id)

        context = {
            'current_user': current_user,
            'all_article': all_article_dict,
            'all_classify': all_classify,
            'all_article_num':all_article.count(),
            'all_users':all_users,
            'all_tags':all_tags,
            'show_tag_state':1,
        }
        return render(request,'library.html',context=context)


@csrf_exempt
def fileupload(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == 'POST':
        upload_file = request.FILES.get('file')
        task = request.POST.get('task_id')  # 获取文件唯一标识符
        chunk = request.POST.get('chunk', 0)  # 获取该分片在所有分片中的序号
        filename = '%s%s' % (task, chunk)  # 构成该分片唯一标识符
        default_storage.save(BASE_DIR + '/uploads/' + filename,ContentFile(upload_file.read()))  # 保存分片到本地
    return render_to_response('upload_tool.html',locals())

@csrf_exempt
def fileMerge(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    task = request.GET.get('task_id')
    ext = request.GET.get('filename', '')
    tool_name = request.GET.get('tool_name')
    upload_type = request.GET.get('type')
    if len(ext) == 0 and upload_type:
        ext = upload_type.split('/')[1]
    ext = '' if len(ext) == 0 else '.%s' % ext  # 构建文件后缀名
    chunk = 0
    new_filename = BASE_DIR + '/tools/%s%s' % (task, ext)
    with open(new_filename, 'wb') as target_file:  # 创建新文件
        while True:
            try:
                filename = BASE_DIR + '/uploads/%s%d' % (task, chunk)
                source_file = open(filename, 'rb')  # 按序打开每个分片
                target_file.write(source_file.read())  # 读取分片内容写入新文件
                source_file.close()
            except IOError:
                break
            chunk += 1
            os.remove(filename)  # 删除该分片，节约空间
    Tool.objects.create(
        name=tool_name,
        path= new_filename,
        file_size=convertBytes(os.path.getsize(new_filename)),
        upload_user=current_user,
    )
    return render_to_response('upload_tool.html',locals())


def search_author(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        author_name = request.POST.get('author_name')
        try:
            user = User.objects.get(id=int(author_name))
        except:
            context = {
                'current_user': current_user,
                'info': '没有该用户',
            }
            return render(request, 'show_info.html', context=context)
        all_article = Article.objects.filter(state=3).filter(author=user).order_by('-update_time')
        all_classify = Classify.objects.all().order_by('name')
        all_users = User.objects.all().order_by('name')
        all_tags = Tag.objects.all().order_by('name')

        all_article_dict = {}
        for classify in all_classify:
            all_article_dict[classify] = all_article.filter(classify_id=classify.id)

        context = {
            'current_user': current_user,
            'all_article': all_article_dict,
            'all_classify': all_classify,
            'all_article_num': all_article.count(),
            'all_users': all_users,
            'all_tags': all_tags,
            'search_user': user.id,
            'search_tag':'null'
        }
        return render(request, 'library.html', context=context)
    else:
        context = {
            'current_user': current_user,
            'info': '不支持该请求方法',
        }
        return render(request, 'show_info.html', context=context)

def search_tag(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        # tag_name = request.POST.get('tag_name')
        # try:
        #     tag = Tag.objects.get(name=tag_name)
        # except:
        #     context = {
        #         'current_user': current_user,
        #         'keytext': tag_name,
        #     }
        #     return render(request,'search_result.html',context=context)
        #
        # all_article = Article.objects.all().order_by('update_time')
        # articles = []
        # for article in all_article:
        #     article.content = article.content[:60] + '...'
        #     tags = article.tags.split(',')[:-1]
        #     if str(tag.id) in tags:
        #         articles.append(
        #             Article_temp(
        #                 article=article,
        #                 tags=tags
        #             )
        #         )
        # context = {
        #     'current_user': current_user,
        #     'all_article': articles,
        #     'keytext': tag_name
        # }
        tag_name = request.POST.get('tag_name')
        try:
            tag = Tag.objects.get(id=int(tag_name))
        except:
            context = {
                        'current_user': current_user,
                        'info': '没有该标签',
                    }
            return render(request,'show_info.html',context=context)
        all_article = Article.objects.filter(state=3).filter(tags__contains=str(tag.id) + ',').order_by('-update_time')
        all_classify = Classify.objects.all().order_by('name')
        all_users = User.objects.all().order_by('name')
        all_tags = Tag.objects.all().order_by('name')

        all_article_dict = {}
        for classify in all_classify:
            all_article_dict[classify] = all_article.filter(classify_id=classify.id)

        context = {
            'current_user': current_user,
            'all_article': all_article_dict,
            'all_classify': all_classify,
            'all_article_num': all_article.count(),
            'all_users': all_users,
            'all_tags': all_tags,
            'search_tag':tag.id,
            'search_user':'null'
        }
        return render(request, 'library.html', context=context)
        # return render(request, 'search_result.html', context=context)
    else:
        context = {
            'current_user': current_user,
            'info': '不支持该请求方法',
        }
        return render(request, 'show_info.html', context=context)


def search_article(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        keytext = request.POST.get('keytext')
        if current_user.username == "Gr33k":
            all_article = Article.objects.filter(Q(title__icontains=keytext) | Q(content__icontains=keytext))
        else:
            all_article = Article.objects.filter(Q(author=current_user) & (Q(title__icontains=keytext) | Q(content__icontains=keytext)))
        new_articles = []
        for article in all_article:
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
                tag_names = []
                for tag_id in tags:
                    try:
                        tag_name = Tag.objects.get(id=int(tag_id)).name
                        tag_names.append(tag_name)
                    except:
                        pass
            except:
                tag_names = []
            if article.title.__len__() > 20:
                article.title = article.title[:20] + '...'
            new_articles.append(
                Article_temp(
                    article,
                    tag_names
                )
            )
        context = {
            'current_user': current_user,
            'my_articles': new_articles,
            'keytext': keytext,
            'page_num':1,
            'page_sum':1
        }
        return render(request,'myarticle.html',context=context)


def collect(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        article_id = request.POST.get('article_id')
        try:
            article = Article.objects.get(id=int(article_id))
        except:
            context = {
                'info':'error'
            }
            context = json.dumps(context)
            return JsonResponse(context,safe=False)
        collect = Collect.objects.filter(article=article).filter(user=current_user).first()
        if collect:
            collect.delete()
            collect_num = Collect.objects.filter(article=article).count()
            context = {
                'info': 'ok',
                'state':'delete',
                'collect_num':str(collect_num)
            }
        else:
            collect = Collect.objects.create(
                user=current_user,
                article=article
            )
            collect_num = Collect.objects.filter(article=article).count()
            context = {
                'info':'ok',
                'state':'add',
                'collect_num':str(collect_num)
            }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)


def mycollect(request,page_num):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "GET":
        collects = Collect.objects.filter(user=current_user).order_by('-create_time')
        page_sum = int(collects.count() / 10) + 1
        page_num = int(page_num) - 1
        if page_num < 0 or page_num >= page_sum:
            context = {
                'current_user': current_user,
                'info': '页码有误'
            }
            return render(request, 'show_info.html', context=context)
        my_collects = collects[page_num*10:page_num*10 + 10]
        context = {
            'current_user':current_user,
            'collects':my_collects,
            'page_num': page_num + 1,
            'page_sum': page_sum,
            'pre_num': page_num,
            'next_num': page_num + 2,
        }
        return render(request,'mycollect.html',context=context)


def delete_collect(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        collect_id = request.POST.get('collect_id')
        collect = Collect.objects.get(id=int(collect_id))
        if collect.user == current_user:
            collect.delete()
            context = {
                'info':'ok'
            }
        else:
            context = {
                'info':'error'
            }
        context = json.dumps(context)
        return JsonResponse(context,safe=False)


def search_collect_article(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        keytext = request.POST.get('keytext')
        collects = Collect.objects.filter(Q(user=current_user) & (Q(article__title__icontains=keytext) | Q(article__content__icontains=keytext))).order_by('-create_time')
        context = {
            'current_user': current_user,
            'collects': collects,
            'page_num':1,
            'page_sum':1
        }
        return render(request, 'mycollect.html', context=context)


def qingy_sync(request):
    qingy_dir = BASE_DIR + '/static/qingy/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                title = filename.replace('.md', '')
                file_path = os.path.join(parent, filename)
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](./img','](/static/qingy/' + title + '/img')
                    Article.objects.create(
                        content=content,
                        title=title,
                        create_time=datetime.datetime.now(),
                        update_time=datetime.datetime.now(),
                        author_id=12,
                        classify_id=104,
                        state=3,
                        type=1,
                    )
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})



def pwnwiki_sync(request):
    qingy_dir = BASE_DIR + '/static/pwnwiki/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                title = filename.replace('.md', '')
                file_path = os.path.join(parent, filename)
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](../img','](/static/pwnwiki/img')
                    Article.objects.create(
                        content=content,
                        title=title,
                        create_time=datetime.datetime.now(),
                        update_time=datetime.datetime.now(),
                        author_id=12,
                        classify_id=105,
                        state=3,
                        type=1,
                    )
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def baige_sync(request):
    qingy_dir = BASE_DIR + '/static/baige/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                title = filename.replace('.md','')
                file_path = os.path.join(parent, filename)
                static_img_path = file_path.split('/static/')[-1].split(title)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](','](/static/' + static_img_path)
                    Article.objects.create(
                        content=content,
                        title=title,
                        create_time=datetime.datetime.now(),
                        update_time=datetime.datetime.now(),
                        author_id=12,
                        classify_id=106,
                        state=3,
                        type=1,
                    )
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def yougar_sync(request):
    qingy_dir = BASE_DIR + '/static/yougar/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                title = filename.replace('.md','')
                file_path = os.path.join(parent, filename)
                static_img_path = file_path.split('/static/')[-1].split(title)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](./resource','img](/static/' + static_img_path + 'resource')
                    Article.objects.create(
                        content=content,
                        title=title,
                        create_time=datetime.datetime.now(),
                        update_time=datetime.datetime.now(),
                        author_id=12,
                        classify_id=107,
                        state=3,
                        type=1,
                    )
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def apachecn_sync(request):
    qingy_dir = BASE_DIR + '/static/ApacheCN/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                file_path = os.path.join(parent, filename)
                with open(file_path,'r') as f:
                    title = f.readlines()[0].strip().replace('# ','')
                    f.close()
                static_img_path = file_path.split('/static/')[-1].split(filename)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](img','img](/static/' + static_img_path + 'img')
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=108,
                            state=3,
                            type=1,
                        )
                    except:
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def lingjiao_sync(request):
    qingy_dir = BASE_DIR + '/static/lingjiao/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                file_path = os.path.join(parent, filename)
                title = filename.replace('.md','')
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](media','](/static/lingjiao/media')
                    content = content.replace('](images', '](/static/lingjiao/images')
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=113,
                            state=3,
                            type=1,
                        )
                    except:
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})



def lingzu_sync(request):
    qingy_dir = BASE_DIR + '/static/lingzu/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            i += 1
            print(i)
            if '.md' in filename:
                file_path = os.path.join(parent, filename)
                title = filename.replace('.md','')
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](file','](/static/lingzu/file')
                    content = content.replace('](images', '](/static/lingzu/images')
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=114,
                            state=3,
                            type=1,
                        )
                    except:
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def download_img(parent,url):
    # 下载图片
    r = requests.get(url, stream=True,timeout=20)
    file_name = url.split('/')[-1]
    if not os.path.exists(parent + '/img/'):
        os.makedirs(parent + '/img/')
    path = parent + '/img/' + file_name
    if r.status_code == 200:
        open(path, 'wb').write(r.content)
    del r
    return file_name


def get_img_path(parent,content):
    p = re.compile(r'<p><div class="lightbox-wrapper"><a(.*?)<img(.*?)src="(.*?)"(.*?)</a></div></p>',re.DOTALL)
    for s in p.finditer(content):
        img_path = s.group(3)
        try:
            file_name = download_img(parent,img_path)
            print("下载完成:" + file_name)
        except:
            continue
        static_img_path = parent + '/img/' + file_name
        line = '<div class="lightbox-wrapper"><a' + s.group(1) + '<img' + s.group(2) + 'src="' + s.group(3) + '"' + s.group(4) + '</a></div>'
        content = content.replace(line,'\n\n![](/' + static_img_path.split('zslibrary/')[-1] + ')\n\n')
    return content


def zhihui_sync(request):
    qingy_dir = BASE_DIR + '/static/zhihui/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            if '.md' in filename:
                i += 1
                print(i)
                file_path = os.path.join(parent, filename)
                title = filename.replace('.md', '')
                static_img_path = file_path.split('/static/')[-1].split(filename)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    content = content.replace('](./img','](/static/' + static_img_path + 'img')
                    content = get_img_path(parent,content)
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=110,
                            state=3,
                            type=1,
                        )
                    except Exception as e:
                        print(e)
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})

def wooyun_sync(request):
    qingy_dir = BASE_DIR + '/static/wooyunwiki/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            if '.md' in filename:
                i += 1
                print(i)
                file_path = os.path.join(parent, filename)
                static_img_path = file_path.split('/static/')[-1].split(filename)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    p = re.compile(r'```(.*?)```',re.DOTALL)
                    for s in p.finditer(content):
                        old_str = '```' + s.group(1) + '```'
                        new_str = '```Code' + s.group(1) + '```'
                        content = content.replace(old_str,new_str)
                    content = content.replace('](./img','](/static/' + static_img_path + 'img')
                    content = get_img_path(parent,content)
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=118,
                            state=3,
                            type=0,
                        )
                    except Exception as e:
                        print(e)
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})


def yuque_sync(request):
    qingy_dir = BASE_DIR + '/static/yuque/'
    i = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            if '.md' in filename:
                i += 1
                print(i)
                file_path = os.path.join(parent, filename)
                title = filename.replace('.md', '')
                static_img_path = file_path.split('/static/')[-1].split(filename)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    if '十万阿里人都在用的笔记' in content:
                        continue
                    p = re.compile(r'<img src="\./img(.*?)" width=(.*?)>',re.DOTALL)
                    for s in p.finditer(content):
                        old_img = '<img src="./img' + s.group(1) + '" width=' + s.group(2) + '>'
                        new_img = '<img src="/static/' + static_img_path + 'img' + s.group(1) + '" width=50% >'
                        content = content.replace(old_img,new_img)
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=116,
                            state=3,
                            type=1,
                        )
                    except Exception as e:
                        print(e)
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})

def download_img1(parent,url,file_name):
    # 下载图片
    r = requests.get(url, stream=True,timeout=20)
    if not os.path.exists(parent + '/img/'):
        os.makedirs(parent + '/img/')
    path = parent + '/img/' + file_name
    if r.status_code == 200:
        open(path, 'wb').write(r.content)
    del r
    return file_name


def peiqi_sync(request):
    qingy_dir = BASE_DIR + '/static/peiqi/'
    i = 0
    mm = 0
    for parent, dirnames, filenames in os.walk(qingy_dir, followlinks=True):
        for filename in filenames:
            if '.md' in filename and 'README' not in filename:
                i += 1
                print(i)
                file_path = os.path.join(parent, filename)
                title = filename.replace('.md', '')
                static_img_path = file_path.split('/static/')[-1].split(filename)[0]
                with open(file_path,'r') as f:
                    content = f.read()
                    p = re.compile(r'!\[(.*?)\]\((.*?)\)',re.DOTALL)
                    for s in p.finditer(content):
                        old_img = '![' + s.group(1) + '](' + s.group(2) + ')'
                        if 'http' not in s.group(2):
                            continue
                        try:
                            mm += 1
                            download_img1(parent,s.group(2),str(mm) + '.png')
                            new_img = '<img src="/static/' + static_img_path + 'img/' + str(mm) + '.png" width=50% >'
                            content = content.replace(old_img,new_img)
                        except:
                            continue
                    try:
                        Article.objects.create(
                            content=content,
                            title=title,
                            create_time=datetime.datetime.now(),
                            update_time=datetime.datetime.now(),
                            author_id=12,
                            classify_id=117,
                            state=3,
                            type=0,
                        )
                    except Exception as e:
                        print(e)
                        pass
                    f.close()
            else:
                continue
    return render(request,'show_info.html',context={'info':'ok'})





def go_set_classify(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        select_article_ids = request.POST.getlist('select_article_ids')
        new_articles = []
        for select_article_id in select_article_ids:
            article = Article.objects.get(id=int(select_article_id))
            if article.title.__len__() > 20:
                article.title = article.title[:20] + '...'
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except:
                tags = []
            new_articles.append(
                Article_temp(
                    article,
                    tags
                )
            )

        classifys = Classify.objects.all().order_by('name')
        context = {
            'select_article_ids':select_article_ids,
            'classifys':classifys,
            'current_user':current_user,
            'new_articles':new_articles
        }
        return render(request,'set_classify.html',context=context)


def set_classify(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        select_article_ids = request.POST.getlist('select_article_ids')
        select_classify = request.POST.get('select_classify')
        classify = Classify.objects.get(id=int(select_classify))
        for select_article_id in select_article_ids:
            article = Article.objects.get(id=int(select_article_id))
            if article.author != current_user:
                continue
            article.classify = classify
            article.save()
        return HttpResponseRedirect('/Gr33kLibrary/myarticle/1/')

def go_set_tags(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        select_article_ids = request.POST.getlist('select_article_ids')
        new_articles = []
        for select_article_id in select_article_ids:
            article = Article.objects.get(id=int(select_article_id))
            if article.title.__len__() > 20:
                article.title = article.title[:20] + '...'
            try:
                tags = article.tags.split(',')
                if '' in tags:
                    tags.remove('')
            except:
                tags = []
            new_articles.append(
                Article_temp(
                    article,
                    tags
                )
            )

        tags = Tag.objects.all().order_by('name')
        context = {
            'select_article_ids':select_article_ids,
            'tags':tags,
            'current_user':current_user,
            'new_articles':new_articles
        }
        return render(request,'set_tgas.html',context=context)


def set_tags(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        select_article_ids = request.POST.getlist('select_article_ids')
        select_tag = request.POST.getlist('select_tag')
        append_tags = ''
        for tag in select_tag:
            append_tags += tag + ','
        for select_article_id in select_article_ids:
            article = Article.objects.get(id=int(select_article_id))
            if article.author != current_user:
                continue
            if article.tags == None:
                article.tags = append_tags
            else:
                article.tags += append_tags
            article.save()
        return HttpResponseRedirect('/Gr33kLibrary/myarticle/1/')


def delete_articles(request):
    try:
        current_user = User.objects.filter(is_lock=0).get(id=int(request.session['user']))
    except:
        return HttpResponseRedirect('/Gr33kLibrary/login/')
    if request.method == "POST":
        select_article_ids = request.POST.getlist('select_article_ids')
        for select_article_id in select_article_ids:
            select_article = Article.objects.get(id=int(select_article_id))
            if select_article.author != current_user:
                continue
            select_article.delete()
        return HttpResponseRedirect('/Gr33kLibrary/myarticle/1/')
