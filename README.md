
# Task overview

The project implemented as MVC Catalyst application. For persistent storage used SQLite DB. 

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
docker pull yourtaev/perl:5.28

docker run  -p 3000:3000 -v $PWD:/app -w /app yourtaev/perl:5.28 script/videocatalog_server.pl -r

In browser navigate http://localhost:3000

```





 

