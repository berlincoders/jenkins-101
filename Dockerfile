# Use the base image from Docker Hub
FROM devopsjourney1/myjenkins-blueocean

# Switch to root user and install necessary packages
USER root
RUN apt-get update && apt-get install -y lsb-release python3-pip \
    && curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
        https://download.docker.com/linux/debian/gpg \
    && echo "deb [arch=$(dpkg --print-architecture) \
        signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
        https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli

# Switch back to jenkins user and install Jenkins plugins
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
