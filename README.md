
# Task overview

The project implemented as MVC Catalyst application. For persistent storage used SQLite DB. 
```
Catalyst 5.90128
Catalyst::Helper::View::TT
Catalyst::Model::DBIC::Schema
```

# Main functionaliy

Application supports main CRUD functional, that allows
* Create new movie
* Update already created movie
* Read the list of all movies and detailed information about each one
** Title of the movie
** Year of release
** Format distribution (DVD/VHS/Blue-Ray)
** Stars
* Movie can be searched by Title
* Movie can be searched by Actor
* Movie list sortable by Title, Actor, Year of release and Format
* Bulk upload from a text file

* Quick start

To run application download it from github repository on localfile system

```
git clone git@github.com:vyourtaev/VideoCatalog.git 

perl Makefile.PL

script/videocatalog_server.pl 
```

* Docker image

As soon as application required a lot of modules and installation all of them from the scratch required some time there is a prepared docker image that includes all dependencies

```
git clone git@github.com:vyourtaev/VideoCatalog.git 

docker pull yourtaev/perl:5.28

docker run --rm -p 3000:3000 -v $PWD:/app -w /app yourtaev/perl:5.28 script/videocatalog_server.pl

In browser navigate http://localhost:3000/video/list

```

* Automatic tests

```
rove -vl t
t/01crud.t ............ 
1..14
ok 1 - Conect to Root Controller: http://localhost
ok 2 - Connect Video Controller: http://localhost/video/list
ok 3 - Title is "Video Catalog Example Page"
ok 4 - Get form_create URL: http://localhost/form_create
ok 5 - Get content from form_create
ok 6 - Get connection to form_upload: http://localhost:3000/videl/form_upload
ok 7 - Check content form_upload
ok 8 - Add video submit form http://localhost:3000/video/form_submit
ok 9 - Check added movie http://localhost:3000/video/list
ok 10 - Search movie by Title: http://localhost:3000/video/search_by
ok 11 - Search movie by Actor: http://localhost:3000/video/search_by
ok 12 - Get form_upload http://localhost:3000/video/form_upload
ok 13 - Bulk movie file Uploaded
ok 14 - Delete movie by ID http://localhost:3000/video/delete/1
ok
t/controller_Video.t .. 
ok 1 - Request should succeed
1..1
ok
t/model_VideoDB.t ..... 
ok 1 - use VideoCatalog::Model::VideoDB;
1..1
ok
All tests successful.
Files=3, Tests=16,  2 wallclock secs ( 0.03 usr  0.00 sys +  1.04 cusr  0.12 csys =  1.19 CPU)
Result: PASS
```





 

