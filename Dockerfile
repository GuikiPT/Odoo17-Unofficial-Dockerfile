FROM ubuntu:22.04

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Lisbon"

RUN apt-get install -y 
RUN apt-get update && \
        apt-get install --no-install-recommends -y \ 
        ca-certificates \
        curl \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3 \
        python3-num2words \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        xz-utils \
        wget \
        tzdata

RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
    && apt-get install -y ./wkhtmltox.deb \
    && rm -r wkhtmltox.deb

RUN npm install -g rtlcss

ENV ODOO_VERSION 17.0
ARG ODOO_RELEASE=latest
RUN curl -o odoo.deb -sSL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
    && apt-get -y install --no-install-recommends ./odoo.deb \
        && rm odoo.deb

COPY ./config/entrypoint.sh /
COPY ./config/odoo.conf /etc/odoo/

RUN chown odoo /etc/odoo/odoo.conf \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

EXPOSE 8069 8071 8072

ENV ODOO_RC /etc/odoo/odoo.conf

COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
