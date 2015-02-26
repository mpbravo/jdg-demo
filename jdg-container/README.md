# JBoss EAP Docker Container

## Required external files
Before running the docker command to create the image, you will have to download Red Hat JBoss Data Grid v6.4 from http://www.jboss.org/products/datagrid/overview/ and copy into this folder.

## Usage
```
$ docker build -t jdg .
$ docker run -d --name jdg -p 8081:8081 -p 9991:9991 -p 11223:11223 -p 8082:8082 -p 9992:9992 -p 11224:11224 -p 8083:8083 -p 9993:9993 -p 11225:11225 -p 8084:8084 -p 9994:9994 -p 11226:11226 jdg
```
