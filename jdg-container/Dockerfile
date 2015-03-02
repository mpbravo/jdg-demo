#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss Data Grid Server 6.4         #
#                                                                     #
#######################################################################
FROM fedora:20

MAINTAINER mpbravo <pilar@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y update
RUN yum -y install java-1.7.0-openjdk-devel unzip supervisor

# Add Supervisor configuration file
ADD ./supervisord.conf /etc/supervisord.conf

# Make sure JAVA_HOME is set
ENV JAVA_HOME /usr/lib/jvm/jre

# Set root password
RUN echo "root:redhat123." | /usr/sbin/chpasswd

# Create user to run JBoss JDG
RUN useradd -m -d /home/jboss -p jboss jboss


####################################################################### 
# Install JBoss JDG                                                   # 
#######################################################################
USER jboss
ENV HOME /home/jboss
RUN mkdir $HOME/jdg && \
mkdir $HOME/tmp
ADD ./jboss-datagrid-6.4.0-server.zip $HOME/tmp/
RUN /usr/bin/unzip -q $HOME/tmp/jboss-datagrid-6.4.0-server.zip -d $HOME/jdg
ENV JDG_HOME $HOME/jdg/jboss-datagrid-6.4.0-server
RUN $JDG_HOME/bin/add-user.sh -g admin -u admin -p redhat123. -s
COPY ./node* $HOME/bin/
COPY ./launch.sh $HOME/bin/

######################################################################
# Configure visualizer demo                                          #
######################################################################
# Backup original clustered.conf file and add new file
RUN mv $JDG_HOME/bin/clustered.conf $JDG_HOME/bin/clustered.conf.bak
COPY ./clustered.conf $JDG_HOME/bin/

# Backup original clustered.xml file and add new file
RUN mv $JDG_HOME/standalone/configuration/clustered.xml $JDG_HOME/standalone/configuration/clustered.xml.bak
COPY ./clustered.xml $JDG_HOME/standalone/configuration/

# Create instance profiles
RUN cp -r $JDG_HOME/standalone $JDG_HOME/standalone1 && \
cp -r $JDG_HOME/standalone $JDG_HOME/standalone2 && \
cp -r $JDG_HOME/standalone $JDG_HOME/standalone3 && \
cp -r $JDG_HOME/standalone $JDG_HOME/standalone4

####################################################################### 
# Clean up                                                            # 
#######################################################################
RUN rm $HOME/tmp/*
# CMD ["/bin/bash", "/home/jboss/jdg/jboss-datagrid-6.4.0-server/bin/launch.sh"]
EXPOSE 8081 9991 10000 11223 8082 9992 10001 11224 8083 9993 10002 11225 8084 9994 10003 11226
USER root
CMD ["home/jboss/bin/launch.sh"]
