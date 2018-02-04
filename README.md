# Maven-pervertions
Non-typical Maven usage infrastructure and projects

## Pre-requisites
  * Docker (tested with 17.12.0-ce)
  * Docker Compose (tested with 1.12.0)

## Usage
  Start the containers from the project folder:
  
    docker-compose up -d --build
  
  To get the Nexus 3 HTTP port, mapped to the localhost use the command:
  
    docker-compose port nexus 8081

  Then target your browser to the printed port. Username/password - admin/admin123.
  
  To use the configured client for the infrastructure, start the Bash inside the Docker container:
  
    docker-compose run --rm repo-client bash 