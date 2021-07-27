# # GSLibrary 安装手册（个人DEBUG版安装）
![](https://img.shields.io/badge/python3-3.7-2dc937)
![](https://img.shields.io/badge/django-2.1.7-2dc937)
- - - -

## 须知
👻👻本知识库禁止在互联网上进行搭建，若出现互联网可访问的GSLibrary本人概不负责。

🥳本工具分为**个人DEBUG版**与**离线服务器版**。
🤩离线服务器版安装程序较大，使用性能更好，且可以离线一键安装，具体下载方式请关注**G安全**公众号回复**GSLibrary服务器版**获取下载链接。

![](./img/1.png)
- - - -

## 关于漏洞文章数据
根据目前互联网上泄漏的知识库数据，本文库做了聚合，可直接全部集成进本工具，由于聚合数据过大请关注上面公众号回复下方列表内容即可获取到对应文库的聚合数据，包括图片资源。感谢各位师傅为安全行业作出的知识输出😇。

	1. qingy未分类（已发布）
	2. pwnwiki未分类（已发布）
	3. 白阁未分类
	4. yougar未分类
	5. ApacheCN未分类
	6. POCHouse未分类
	7. 知汇社区未分类
	8. Middleware-Vulnerability未分类
	9. Some-PoC-oR-ExP未分类
	10. 棱角社区未分类
	11. 零组未分类
	12. 语雀未分类

其中共计文章1.8W篇（不同知识库之间有重复）
CTF wp约600篇

- - - -
## 使用场景
为了方便大家的使用本知识库可以做为个人的知识库管理工具武器库管理工具，也可以搭建在内网中作为团队的知识库和武器库管理工具，针对使用场景的不同知识库发挥的作用也不同，推荐大家搭建在内网通过团队进行维护使其一直成长下去。

- - - -
## 开发工具
本知识库使用Python3 + Django 开发，属于轻量级知识库管理工具，他的代码量少、结构清晰。欢迎各位开发者进行二次开发。GSLibrary现在支持的功能有：
	1. 文章的书写、阅读、搜索、收藏、审核、排名
	2. 栏目与标签管理
	3. 工具的上传、下载、搜索
	4. 用户及邀请码管理

## 安装
### 一、数据库

使用mysql数据库，安装方式任意phpstudy也可，这里测试的版本为mysql5.7与mysql8。

### 二、clone 代码到本地并安装依赖

```
git clone https://github.com/lijiaxing1997/GSLibrary.git
python3 -m pip install -r requirements.txt
```

### 三、初始化数据库

可以使用图形化工具进行创建数据库，数据库名：**zslibrary**，随后选择导入sql文件选中项目目录下的zslibrary.sql即可。

若您使用的是命令行，则命令如下:
```
mysql -uroot -p
password:**********

create database zslibrary;
use zslibrary;
source GSLibrary/zslibrary.sql;
```

### 四、启动GSLibrary

```
python3 manage.py runserver 127.0.0.1:8000
```

😘😘访问本机8000端口即可，初始帐号密码 Gr33k/123456


### 五、预览

![](./img/2.png)

