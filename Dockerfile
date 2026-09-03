# Jenkins LTS image with Java 17
FROM jenkins/jenkins:lts-jdk17

# Temporarily use root only while installing required system packages.
USER root

# Install Docker CLI and Git so Jenkins can communicate with
# the separate Docker-in-Docker service and access source repositories.
RUN apt-get update && \
    apt-get install -y --no-install-recommends docker-cli git && \
    rm -rf /var/lib/apt/lists/*

# Install Jenkins plugins required for Pipeline-as-Code and Docker agents.
RUN jenkins-plugin-cli --plugins \
    workflow-aggregator \
    git \
    docker-workflow \
    credentials-binding \
    pipeline-stage-view

# Run Jenkins itself as the standard unprivileged Jenkins user.
USER jenkins
