FROM docker-registry.51uuabc.com/airflow:1.10.5
LABEL maintainer="HongWang"
ARG ENV_NAME=uat

# embulk
RUN yum install -y java-1.8.0-openjdk \
    && curl --create-dirs -o /opt/embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" \
    && chown -R dw_adm:dw_adm /opt/embulk \
    && chmod +x /opt/embulk/bin/embulk

USER dw_adm

RUN /opt/embulk/bin/embulk gem install embulk-input-mysql \
    && /opt/embulk/bin/embulk gem install embulk-output-parquet \
    && /opt/embulk/bin/embulk gem install embulk-input-mongodb \
    && /opt/embulk/bin/embulk gem install embulk-filter-expand_json \
    && /opt/embulk/bin/embulk gem install embulk-filter-expand_json_array \
    && /opt/embulk/bin/embulk gem install embulk-filter-column \
    && /opt/embulk/bin/embulk gem install embulk-parser-jsonl

USER root

# dataship
ARG SSH_PRIVATE_KEY
RUN yum install -y mysql-devel gcc git \
    && mkdir /root/.ssh/ \
    && echo "${SSH_PRIVATE_KEY}" >> /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa \
    && touch /root/.ssh/known_hosts \
    && ssh-keyscan gitlab.51uuabc.com >> /root/.ssh/known_hosts \
    && pip3 install git+ssh://git@gitlab.51uuabc.com/data/dataship.git@master \
    && rm -r /root/.ssh

# spark
ARG SPARK_UID="802"
ARG SPARK_GID="802"
ARG SPARK_VERSION=2.4.3
RUN groupadd -r -g $SPARK_GID spark \
    && useradd -r -u $SPARK_UID -g spark spark \
    && usermod -a -G spark dw_adm \
    && curl -O https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
    && tar -xzf spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop2.7 /opt/spark \
    && chown -R spark:spark /opt/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

COPY --chown=spark:spark ./conf/spark-${SPARK_VERSION}/${ENV_NAME}/* /opt/spark/conf/

# hdfs

ARG HDFS_UID="803"
ARG HDFS_GID="803"
ARG HADOOP_VERSION=3.1.1
RUN groupadd -r -g $HDFS_GID hdfs \
    && useradd -r -u $HDFS_UID -g hdfs hdfs \
    && usermod -a -G hdfs dw_adm \
    && curl -O https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -xzf hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} /opt/hadoop \
    && chown -R hdfs:hdfs /opt/hadoop \
    && rm hadoop-${HADOOP_VERSION}.tar.gz

COPY --chown=hdfs:hdfs ./conf/hadoop-${HADOOP_VERSION}/${ENV_NAME}/* /opt/hadoop/etc/hadoop/

# clear
RUN rm -rf /tmp/* \
        /var/cache/yum \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc

COPY script/entrypoint.sh /entrypoint.sh

ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH="/opt/spark/bin:/opt/embulk/bin:/opt/hadoop/bin:${PATH}"

ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
