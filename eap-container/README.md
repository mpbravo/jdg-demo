# JBoss EAP Docker Container

## Required external files
Before running the docker command to create the image, you will have to download Red Hat JBoss EAP v6.3 from http://www.jboss.org/products/eap/overview/ and copy into this folder.

## Usage
```
$ docker build -t eap .
$ docker run -d --name eap --link jdg:jdg -p 8080:8080 -p 9990:9990 eap
```
