FROM centos:centos6

ENV TMP_DIR=/tmp/install

COPY . $TMP_DIR/

WORKDIR $TMP_DIR

RUN ./install.sh

WORKDIR /

EXPOSE 22