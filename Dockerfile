FROM debian:stretch-slim
MAINTAINER zebra.lucky@gmail.com

ARG USER_ID
ARG GROUP_ID

ENV HOME /zcash

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} zcash
RUN useradd -u ${USER_ID} -g zcash -s /bin/bash -m -d /zcash zcash

RUN chown zcash:zcash -R /zcash

RUN apt-get update \
    && apt-get install -y wget libdigest-sha-perl libgomp1 \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

RUN download_url=https://z.cash/downloads/ \
    && version=4.4.1 \
    && tar_file=zcash-${version}-linux64-debian-stretch.tar.gz \
    && sum=22f8f4ff5e68ed0e3557b56e27ea7b4b4ed9be68522e1d1cea92aec210ffded6 \
    && wget ${download_url}${tar_file} \
    && echo $sum $tar_file | sha256sum -c \
    && tar -xzvf $tar_file -C /tmp/ && rm $tar_file \
    && cp /tmp/zcash-*/bin/*  /usr/local/bin \
    && rm -rf /tmp/zcash-*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER zcash

VOLUME ["/zcash"]

EXPOSE 18232 18233

WORKDIR /zcash

CMD ["zec_oneshot"]
