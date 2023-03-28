### License
Apache 2.0

### TODO
1.    Figure out why docker doesn't run apache2 with php mod by default.  
2.    Determine how to run sushi-config.yaml as preconfig for sushi --init.  #Publish web site to localhost so that it is all working as designed for test suite after docker container is running. 

# FHIR IG Base Image
This Docker image contains the FHIR Implementation Guide (IG) publisher tool and all dependencies installed. It also provides "sushi" tool for projects using FHIR Shorthand.
### Clone the github repository. 
git clone https://github.com/nmdp-ig/fhir-ig-builder.git
### To completely rebuild the base image from scratch:
docker build -t fhir-ig-builder:latest --no-cache .
### Code to run after the image has built and is running. 
docker run -it -v $(pwd)/app-local:/app/app-local -p 80:80 fhir-ig-builder:latest /bin/bash 
### Restart apache2 so that the php modules are loaded.  Not sure why this doesn't work already.
Run this command /etc/init.d/apache2 restart
### Initialize IG 
sushi --init 
### Run the publisher against the fsh - run this from inside ExampleIG dir.
java -jar ../input-cache/publisher.jar -ig ig.ini
### Optional - publish to the URL.  Or, just go on to next step
java -jar ../input-cache/publisher.jar -no-sushi -ig ig.ini -publish http://localhost/ExampleIG
### Copy your code from output to /var/www/html/ to check some things
cp -r output/* /var/www/html/
### Look for index file in vscode or launch the index.html localhost browser on port 80
http://localhost 

### Attribution
By Jason Brelsford
