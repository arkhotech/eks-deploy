FROM --platform=linux/amd64 ubuntu:latest 

RUN apt-get -y update 

RUN apt-get -y install curl unzip jq git

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip ;\
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin  --update

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 ; \
    chmod 700 get_helm.sh ;\
    ./get_helm.sh

WORKDIR /home/worker

RUN useradd -d /home/worker worker ; \
    chown worker:worker /home/worker

USER worker

RUN curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/amd64/kubectl ;\
    chmod +x ./kubectl ;\
    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin ;\
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc 

ENV AWS_ACCESS_KEY_ID=$INPUT_ACCESS_KEY_ID

ENV AWS_SECRET_ACCESS_KEY=$INPUT_AWS_SECRET_ACCESS_KEY

ENV AWS_REGION=$INPUT_AWS_SREGION

RUN aws eks update-kubeconfig --region $INPUT_AWS_REGION --name $INPUT_CLUSTER_NAME

COPY entrypoint.sh /home/worker

ENTRYPOINT [ "entrypoint.sh", $INPUT_COMANDO ]
