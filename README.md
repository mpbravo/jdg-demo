JBoss Data Grid Visualizer Demo
===============================
JBoss Data Grid Demo running on Docker

This demo is based on previous work, see:
 * JDG Visualizer Demo <https://github.com/infinispan/visual>
 * Hot Rod Demo <https://github.com/saturnism/hotrod-demo>

There are two Docker containers:
 * A JBoss Data Grid container, running four Data Grid instances
 * A JBoss Enterprise Application Platform, running the visualizer application

# 1. System Requirements
 * Docker
 * Maven

# 2. Required external files
Before building the containers, you will have to download the following products:
 * JBoss Data Grid 6.4
 * JBoss Enterprise Application Platform 6.3

And place them in the corresponding directories, jdg-container and eap-container.

# 3. Building the containers

## 3.1 JBoss Data Grid Container
	cd jdg-container
	docker build -t jdg .
	docker run -d --name jdg -p 8081:8081 -p 9991:9991 -p 11223:11223 -p 8082:8082 -p 9992:9992 -p 11224:11224 -p 8083:8083 -p 9993:9993 -p 11225:11225 -p 8084:8084 -p 9994:9994 -p 11226:11226 jdg

After the container has been built and run, you can start it and stop it by its name:

	docker stop jdg
	docker start jdg

## 3.2 JBoss EAP container
	docker build -t eap .
	docker run -d --name eap --link jdg:jdg -p 8080:8080 -p 9990:9990 eap

After the container has been built and run, you can start it and stop it by its name:

	docker stop eap
	docker start eap

# 4 Populating data

To configure Maven with the Red Hat Maven public repository, you can copy the provided Maven settings in your home:

	mv ~/.m2/settings.xml ~/.m2/settings.xml.bak
	cp example-settings.xml ~/.m2/settings.xml

At this point you can build and execute the application:

	git clone https://github.com/mpbravo/hotrod-demo.git
	cd hotrod-demo
	mvn clean package
	./data.sh

# 5 Visualizing the cache

Open a browser and type <http://localhost:8080/jdg-visualizer>

# 6 Stopping and starting Data Grid nodes

Get into the container running Data Grid nodes:

	docker exec -i -t jdg bash

Execute supervisorctl in the container:

	[root@1bdf8fef169f /]#supervisorctl

Check process status:

	supervisor> status
	jdg1                             RUNNING    pid 1700, uptime 0:02:42
	jdg2                             RUNNING    pid 1897, uptime 0:01:08
	jdg3                             RUNNING    pid 1479, uptime 0:03:00
	jdg4                             RUNNING    pid 8, uptime 0:08:25

With Supervisor you can stop and start the different Data Grid nodes and see the results in the web application.
