FROM jenkins/inbound-agent:latest

USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip gnupg default-jdk maven python3 python3-pip awscli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Terraform
ARG TERRAFORM_VERSION=1.7.3
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Chrome browser and ChromeDriver
ARG CHROME_DRIVER_VERSION=114.0.5735.90
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    wget -P /tmp "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /usr/local/bin/chromedriver && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
