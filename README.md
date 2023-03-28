# License
Apache 2.0

#TODO 
#1.    Figure out why docker doesn't run apache2 with php mod by default.  
#2.    Determine how to run sushi-config.yaml as preconfig for sushi --init.  #Publish web site to localhost so that it is all working as designed for test suite after docker container is running. 

# FHIR IG Base Image
This Docker image contains the FHIR Implementation Guide (IG) publisher tool and all dependencies installed. It also provides "sushi" tool for projects using FHIR Shorthand.

...
# Clone the github repository.
You should start by doing this.  Suggestions for code to run inside the docker image below. 

```
...
# To completely rebuild the base image from scratch:
docker build -t fhir-ig-builder:latest --no-cache .

#Code to run after the image has built and is running. 
#docker run -it -v $(pwd)/app-local:/app/app-local -p 80:80 fhir-ig-builder:latest /bin/bash 

#Restart apache2 so that the php modules are loaded.  Not sure why this doesn't work already.
#Run this command /etc/init.d/apache2 restart

# RUN sushi --init 

# RUN java -jar ../input-cache/publisher.jar -ig ig.ini

# RUN java -jar ../input-cache/publisher.jar -no-sushi -ig ig.ini -publish http://localhost/ExampleIG

#Copy your code from output to /app/app-local to check some things
#cp -r output /app/app-local 
#Look for index file in vscode or other browser and launch the index.html with live server. Or, 
```

# Attribution
By Jason Brelsford
