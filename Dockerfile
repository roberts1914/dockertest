FROM ubuntu:14.04
MAINTAINER Doug Roberts  "roberts_douglas@yahoo.com"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install redis-server redis-tools apache2 supervisor
RUN apt-get -y install nfs-kernel-server runit inotify-tools -qq
RUN mkdir -p /exports
RUN mkdir -p /etc/sv/nfs
RUN mkdir -p /var/lock/apache2 /var/run/apache2  /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nfs.init /etc/sv/nfs/run
ADD nfs.stop /etc/sv/nfs/finish
ADD nfs_setup.sh /usr/local/bin/nfs_setup
ADD exports /etc/exports
VOLUME /exports
EXPOSE 6379 80 111:111/udp 2049:2049/tcp
CMD ["/usr/bin/supervisord"]
