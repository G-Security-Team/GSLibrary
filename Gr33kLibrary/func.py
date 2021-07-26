
from Gr33kLibrary.models import *
import os
import math
import html
import re


def list2str(old_list:list):
    _str = ""
    for l in old_list:
        _str = _str + str(l) + ','
    return _str


class Article_temp():
    article = None
    tags = []
    article_num = 0

    def __init__(self,article,tags):
        self.tags = []
        self.article = article
        for tag in tags:
            try:
                tag_name = Tag.objects.get(id=int(tag)).name
                self.tags.append(tag_name)
            except:
                continue


def wrire_file(img,path,img_name_new):
    destination = open(os.path.join(path, img_name_new), 'wb+')
    for chunk in img.chunks():
        destination.write(chunk)
    destination.close()



def convertBytes(bytes, lst=None):
    if lst is None:
        lst=['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB']
    i = int(math.floor( # 舍弃小数点，取小
             math.log(bytes, 1024) # 求对数(对数：若 a**b = N 则 b 叫做以 a 为底 N 的对数)
            ))

    if i >= len(lst):
        i = len(lst) - 1
    return ('%.2f' + " " + lst[i]) % (bytes/math.pow(1024, i))

class Author():
    author = None
    article_num = 0
    invitation_user = None

    def __init__(self,author:Article,article_num:int,invitation_user):
        self.author = author
        self.article_num = article_num
        try:
            self.invitation_user = User.objects.get(id=int(invitation_user))
        except:
            self.invitation_user = None


class Classify_temp():
    classify = None
    article_num = 0

    def __init__(self,classify:Classify,article_num:int):
        self.classify = classify
        self.article_num = article_num


class Tag_temp():
    tag = None
    article_num = 0

    def __init__(self, tag: Tag, article_num: int):
        self.tag = tag
        self.article_num = article_num


def get_tag_article(tag_id):
    s_tag = str(tag_id) + ','
    num = Article.objects.filter(state=3).filter(tags__contains=s_tag).all().count()
    return num
