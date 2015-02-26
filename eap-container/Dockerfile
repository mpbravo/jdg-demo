#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss EAP 6.3                      #
#                                                                     #
#######################################################################
FROM fedora:20

MAINTAINER mpbravo <pilar@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y update
RUN yum -y install java-1.7.0-openjdk-devel unzip maven git

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Set root password
RUN echo "root:redhat123." | /usr/sbin/chpasswd

# Create user to run JBoss EAP
RUN useradd -m -d /home/jboss -p jboss jboss

####################################################################### 
# Install JBoss EAP                                                   # 
#######################################################################
USER jboss
ENV HOME /home/jboss
RUN mkdir $HOME/eap && \
mkdir $HOME/tmp && \
mkdir -p $HOME/.m2/repository 
ADD ./jboss-eap-6.3.*.zip $HOME/tmp/
RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-6.3.*.zip -d $HOME/eap
ENV JBOSS_HOME $HOME/eap/jboss-eap-6.3
RUN $JBOSS_HOME/bin/add-user.sh -g admin -u admin -p redhat123. -s

####################################################################### 
# Build and deploy visualizer					      #
#######################################################################
ADD ./settings.xml $HOME/.m2/
WORKDIR /home/jboss
RUN /usr/bin/git clone https://github.com/mpbravo/visual.git
WORKDIR /home/jboss/visual
RUN /usr/bin/mvn clean package
RUN cp ./target/jdg-visualizer.war $JBOSS_HOME/standalone/deployments/
ADD ./visualizer.sh $JBOSS_HOME/bin/

####################################################################### 
# Clean up                                                            # 
#######################################################################
RUN rm $HOME/tmp/*
CMD ["/bin/bash", "/home/jboss/eap/jboss-eap-6.3/bin/visualizer.sh"]
EXPOSE 8080 9990 9999 
