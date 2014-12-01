FROM centos:centos7

RUN yum -y update
RUN yum -y install openssh-server supervisor openssh-clients sudo cronie perl

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN echo "root:root" | chpasswd

# allow vagrant to do notty login
RUN sed -i "s/.*Defaults.*requiretty.*/#Defaults requiretty/g" /etc/sudoers

# error fixes
RUN sed -i "s/IPTABLES_MODULES_UNLOAD=\"yes\"/IPTABLES_MODULES_UNLOAD=\"no\"/g" /etc/sysconfig/iptables-config
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
