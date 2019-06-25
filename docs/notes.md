### A Docker config for single-container workflow

For complex, multi-container workflows, Docker's Docker Compose provides a great way to manage them. However, many times a task needs only a single container and for that Docker Compose isn't necessary. Using Node to learn utilities such as Gulp, webpack, or Tailwind is a good example. Having a simple, repeatable process for spinning up a Node (or whatever your current obsession is) container for a weekend of poking around is very handy. This article describes a simple approach to single-container projects. 


Docker is one of those technologies that you learn in waves. Rich and deep with features and functionality, a full command of Docker takes lots of study and experimenting. However, once you've accomplished a couple of small, focused tasks with Docker, the things it can do for you start to come into focus. They include: 

* Eliminating virtual machines. Nearly everything that you're using a VM for in your dev workflow can be accomplished with Docker. And with less overlow, less hassle, and easy setup and environment duplication. 

* Remove configuration hell from your dev workflows. Spinning up a Web app with any modern platform requires several components. You need a core framework (Node and Express, Python and Flask, PHP and Laravel, etc); you need a Web server (Nginx, Apache, among others), you need a database (MySQL, MariaDB, Postgres, MongoDB, etc); you need a database admin client; you might need state management (Redis, Macached, etc), you'll probably need a build tool (like Webpack or Gulp),  

* Experimental environment


, Docker has several concepts and components. 

In this case, the task at hand was a weekend of CSS utility-style. I've been following Tailwind CSS for more than a year now, but only with its CSS basic file CSS file loaded via CDN. To really get the most out of Tailwind you'll want to be able to create your own cutom Tailwind CSS file. [Read more about Tailwind's approach here.](https://tailwindcss.com/#what-is-tailwind) 

A Tailwind CSS file is created with a Node app. This type of project is a natural for Docker and a container based on a standard Node image. The Docker file to create the (minimally customized) image is below. 

	FROM node:latest

	LABEL maintainer="Roger Pence"

	RUN apt-get update \
		&& apt-get install -y vim \
		&& apt-get install -y --no-install-recommends apt-utils \
		&& apt-get install apt-transport-https \
		&& apt-get -y autoremove \
		&& apt-get -y clean \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
		&& echo 'npm-do() { (PATH=$(npm bin):$PATH; eval $@;) }' >> /root/.bashrc

	WORKDIR /opt    

This image is derived from the office Node latest image from [hub.docker.com](https://hub.docker.com/_/node). It adds Vim, does a little clean up, and adds a Bash function called `npm-do` that eliminates the need to fully-qualify Node modules on the command. For example, instead of 

	./node_modules/.bin/tailwind --version

you can use 

	npm-do tailwind --version

npm-do came from [this Axel Rauschmayer blog post.](http://2ality.com/2016/01/locally-installed-npm-executables.html) It's pretty handy.

Build the image with this command line:

	$ docker build -t $IMAGE -f ./Dockerfile .

> I usually use Docker on Ubuntu, but I was pleasantly surprised to see that, except for a few line-ending issues, Docker Desktop for Windows did a pretty good job for me as well. 





	.
	├── dev
	├── Dockerfile
	└── project
	    ├── app
	   │  ├── build-tw.sh
	   │  ├── dist
	   │  │  └── tailwind-full.css
	   │  ├── src
	   │  │  ├── article.html
	   │  │  └── home.html
	   │  ├── tailwind.config.js
	   │  └── tw-style-base.css
	   ├── config-shared-dir.sh
	   ├── node_modules...
	   ├── package-lock.json
	   └── package.json
	