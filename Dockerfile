FROM arm32v6/alpine

RUN apk update
RUN apk add alpine-sdk
RUN addgroup sdk
RUN adduser  -G sdk -s /bin/sh -D sdk
RUN echo "sdk:sdk"| /usr/sbin/chpasswd
RUN echo "sdk    ALL=(ALL) ALL" >> /etc/sudoers
RUN chmod g+w /var/cache/distfiles/
RUN sudo addgroup sdk abuild

COPY build /bin/
COPY docker-entrypoint.sh /usr/local/bin/

USER sdk
WORKDIR /home/sdk

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
