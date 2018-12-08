FROM ubuntu:18.04
RUN set -xe \
    && apt-get update \
    && apt-get install -y apt-utils tzdata locales
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
     && echo $TZ > /etc/timezone
RUN set -xe &&\
    dpkg-reconfigure --frontend=noninteractive tzdata && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8



# # Unminimize
RUN yes | unminimize


RUN set -xe \
    && apt-get install -y vim perl wget tar man sudo adduser netstat-nat net-tools curl w3m  \
    && useradd -m -p "\$6\$AyOAQ1vh\$CcIXBW4cJopgUVKsTcxlGplUZ382K4yIxIAHhqmEewzJdc6x0MmbSDDQJ1DR.4eueGlYTf2ZbUl9oAQaUQEoi1" -s /bin/bash user \
    && usermod -aG sudo user \
    && echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user 

USER user:user

WORKDIR /home/user

CMD [ "/bin/bash" ]