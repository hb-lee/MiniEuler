FROM scratch as builder
MAINTAINER lhb
ADD ./ /
RUN yum --releasever 1.0 install -y vim

FROM builder
CMD /usr/bin/bash
