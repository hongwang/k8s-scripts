FROM centos:7
LABEL maintainer="HongWang"
ENV LANG="en_US.UTF-8"

ARG AIRFLOW_VERSION=1.10.5
ARG AIRFLOW_HOME_ARG=/opt/airflow
ARG DW_ADM_UID="801"
ARG DW_ADM_GID="801"
ENV AIRFLOW_HOME=${AIRFLOW_HOME_ARG}

RUN set -ex \
    && yum install -y epel-release \
        python36 \
        python36-devel \
        mysql-devel \
        gcc-c++ \
        # support sasl
        cyrus-sasl cyrus-sasl-lib cyrus-sasl-plain cyrus-sasl-devel \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.6 get-pip.py \
    # support sasl
    && pip3 install thrift_sasl \
    && pip3 install "apache-airflow[async, crypto, jdbc, hdfs, elasticsearch, hive, mysql, password, postgres, ssh, kubernetes]==${AIRFLOW_VERSION}" \
    && mkdir -p ${AIRFLOW_HOME_ARG} \
    && groupadd -r -g $DW_ADM_GID dw_adm \
    && useradd -r -m -u $DW_ADM_UID -g dw_adm dw_adm \
    && chown -R dw_adm:dw_adm $AIRFLOW_HOME_ARG \
    && yum clean all \
    && rm -rf get-pip.py \
        /tmp/* \
        /var/cache/yum \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc


COPY patches/hooks/hdfs_hook.py /usr/local/lib/python3.6/site-packages/airflow/hooks/
COPY patches/contrib/executors/kubernetes_executor.py /usr/local/lib/python3.6/site-packages/airflow/contrib/executors/
COPY patches/contrib/kubernetes/worker_configuration.py /usr/local/lib/python3.6/site-packages/airflow/contrib/kubernetes/

COPY script/entrypoint.sh /entrypoint.sh

EXPOSE 8080

WORKDIR ${AIRFLOW_HOME_ARG}
ENTRYPOINT ["/entrypoint.sh"]
CMD ["webserver"]
