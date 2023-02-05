FROM rust:latest

ARG REPOSITORY_NAME
ARG REPOSITORY_LINK
ARG BRANCH_TO_CLONE

WORKDIR /app

# shared directory used to store the binary at the end
RUN mkdir bin

RUN apt-get update && apt-get upgrade
RUN apt-get install -y build-essential curl git vim

RUN mkdir /root/.ssh/
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa
RUN chown -R root:root /root/.ssh

COPY entrypoint.sh /app/
RUN chmod +x entrypoint.sh

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan -T 60 github.com >> /root/.ssh/known_hosts

RUN git clone -b $BRANCH_TO_CLONE $REPOSITORY_LINK
RUN mv $REPOSITORY_NAME/* .
RUN rm -rf target/release

ENTRYPOINT ["./entrypoint.sh"]