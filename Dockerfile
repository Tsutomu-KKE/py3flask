FROM alpine:3.4

ENV USER=scientist HOME=/home/scientist
RUN export uid=1000 gid=1000 pswd=scientist && \
    apk add --no-cache musl python3 sudo && \
    apk add --no-cache --virtual=tzdata_pkg tzdata && \
    cp /usr/share/zoneinfo/Japan /etc/localtime && \
    apk del tzdata_pkg && \
    addgroup -g $gid $USER && \
    adduser -G $USER -S -s /bin/ash $USER && \
    mkdir -p $HOME/.cache && \
    echo "$USER:$pswd" | chpasswd && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    pip3 install -U pip && \
    pip install flask pyjade pyyaml markdown && \
    ln -s /usr/bin/python3.5 /usr/bin/python && \
    rm -rf /root/.[ac]*
USER $USER
WORKDIR $HOME
CMD ["/bin/ash"]
