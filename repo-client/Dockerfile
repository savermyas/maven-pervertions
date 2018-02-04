FROM centos:7.4.1708
COPY requirements.txt /tmp/
RUN yum -y install maven curl && \
    curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py && \
    pip install -r /tmp/requirements.txt
COPY .m2 /root/.m2