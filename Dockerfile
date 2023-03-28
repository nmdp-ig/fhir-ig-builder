#docker build -t fhir-ig-builder:node .
FROM node

# Install dependencies.
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y gcc g++ make apt-utils
RUN apt-get install -y openjdk-17-jdk
# RUN apt-get install -y nodejs

# Install Jekyll for Ubuntu/Debian: https://jekyllrb.com/docs/installation/ubuntu/
RUN apt-get install -y ruby-full build-essential zlib1g-dev
RUN apt-get install -y vim

#Install apache2 and php
RUN apt update
RUN apt -y upgrade
RUN apt install -y php libapache2-mod-php apache2
COPY info.php /var/www/html
# RUN /etc/init.d/apache2 -k restart

#Install gems
RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc

#Source the bashrc so that it is active in docker container
RUN /bin/bash -c 'source ~/.bashrc'
RUN gem install -N jekyll bundler

RUN mkdir /app
WORKDIR /app

# Install the FHIR Shorthand transfiler:
RUN /bin/bash -c 'npm i -g fsh-sushi'

# Download the IG publisher.
RUN apt-get install curl
COPY ./_updatePublisher.sh .
RUN ./_updatePublisher.sh -y
# RUN chmod x *.sh *.bat

#Run simple test of php server
# RUN curl http://localhost/info.php after restarting apache2  /etc/init.d/apache2 restart

RUN ls -alh

EXPOSE 80
RUN /etc/init.d/apache2 restart

#The remaining items could possibly be worked into a docker image. 

# For some reason I end up having to run this docker interactively and then start apache2 myself. 
#Run this to startup. 
#docker run -it -v $(pwd)/app-local:/app/app-local -p 80:80 fhir-ig-builder:single /bin/bash
#THEN
#/etc/init.d/apache2 restart

#Test your web and php with
#http://localhost/info.php


#Code to run after the image has built and is running. 
#docker run -it -v $(pwd)/app-local:/app/app-local -p 80:80 -p 8080:8080 fhir-ig-builder:latest /bin/bash 

# RUN sushi --init 

# RUN java -jar ../input-cache/publisher.jar -ig ig.ini

# RUN java -jar ../input-cache/publisher.jar -no-sushi -ig ig.ini -publish http://localhost/ExampleIG

#Copy your code from output to /app/app-local to check some things
#cp -r output /app/app-local  or cp -r output /var/www/html to test with apache and php

#Launch a browser and point it at http://localhost/index.html

#Look for index file in vscode or other browser and launch the index.html with live server.

#Possible links needed 
#RUN wget https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
