# Maven-pervertions
Non-typical Maven usage infrastructure and projects

## Pre-requisites
  * Docker (tested with 17.12.0-ce)
  * Docker Compose (tested with 1.12.0)

## Getting started
  Start the containers from the project folder:
  
    docker-compose up -d nexus  
  
  If you are running the containers in the first time, it is worth to create
  a hosted PyPi repo. You may do it using the following command:

    docker-compose exec nexus /tmp/pypi-init.sh
  
## Usage

### Nexus 3 container
  To get the Nexus 3 HTTP port, mapped to the localhost use the command:
  
    docker-compose port nexus 8081

  Then target your browser to the printed port. Username/password - admin/admin123.
  
### Client container
  To run one-off scripts and manual scenarios the `repo-client` image should be built.
  For manual commands start the Bash inside the Docker container:
  
    docker-compose run --rm repo-client bash
    
## Scenario

  Deploy the parent and archetype projects to Nexus 3 Maven repo:
  
    docker-compose run --rm repo-client mvn -f /root/projects/parent/pom.xml deploy
    docker-compose run --rm repo-client mvn -f /root/projects/python-parent/pom.xml deploy
    docker-compose run --rm repo-client mvn -f /root/projects/python-archetype/pom.xml deploy
    
  Deploy the Java Hello World application to Nexus 3 Maven repo:
    
    docker-compose run --rm repo-client mvn -f /root/projects/java-hello/pom.xml deploy
    
  Create a Maven-wrapped Python project from the archetype:
  
    docker-compose run --rm repo-client mvn archetype:generate \
                                            -DarchetypeGroupId=com.griddynamics.techtalk \
                                            -DarchetypeArtifactId=python-archetype \
                                            -DarchetypeVersion=0.0.1 \
                                            -DgroupId=com.griddynamics.techtalk \
                                            -DartifactId=mypython \
                                            -Dversion=1.0-SNAPSHOT \
                                            -DinteractiveMode=false
  
  Or local scenario to run inside the container without deployment of artifacts (for development purposes):
  
    docker-compose run --rm repo-client bash
  
    cd /root/projects
    rm -rf /root/projects/mypython
    mvn -f /root/projects/parent/pom.xml clean install
    mvn -f /root/projects/python-parent/pom.xml clean install
    mvn -f /root/projects/python-archetype/pom.xml clean install
    mvn archetype:generate -DarchetypeGroupId=com.griddynamics.techtalk \
                           -DarchetypeArtifactId=python-archetype \
                           -DarchetypeVersion=0.0.1 \
                           -DgroupId=com.griddynamics.techtalk \
                           -DartifactId=mypython \
                           -Dversion=1.0-SNAPSHOT \
                           -DinteractiveMode=false
    cd /root/projects/mypython
    mvn deploy
    
## Links

  * [Python setuptools usage](http://setuptools.readthedocs.io/en/latest/setuptools.html)
  * [Python project structure](http://docs.python-guide.org/en/latest/writing/structure/)