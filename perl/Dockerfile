FROM perl:5.26

WORKDIR /root
RUN apt-get update && \
    apt-get --yes --force-yes install sqlite libsqlite-dev && \
    git clone https://github.com/g0ga/jee_deploy.git

WORKDIR /root/jee_deploy
RUN make installdeps

CMD ["bash", "-ls"]