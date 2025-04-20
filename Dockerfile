FROM registry.access.redhat.com/ubi8/ubi:8.7

LABEL maintainer="ozgecmis.online"

RUN dnf update -y && \
    dnf install httpd -y && \
    dnf clean all && rm -rf /var/cache/dnf

COPY index.html /var/www/html/index.html
 
EXPOSE 80

HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
