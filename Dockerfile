FROM alpine:3.17.2

LABEL maintainer="Manuel Valle <manuvaldi@gmail.com>"

# For access via VNC
EXPOSE 5900

# Expose Ports of RouterOS
EXPOSE 1194 1701 1723 1812/udp 1813/udp 21 22 23 443 4500/udp 50 500/udp 51 5900 80 8080 8291 8728 8729

# Change work dir (it will also create this folder if is not exist)
WORKDIR /routeros

# Install dependencies
RUN set -xe \
 && apk add --no-cache --update \
    netcat-openbsd qemu-img qemu-x86_64 qemu-system-x86_64 \
    busybox-extras iproute2 iputils \
    bridge-utils iptables jq bash python3 \
    libarchive-tools

# Environments which may be change
ENV ROUTEROS_VERSON="7.8"
ENV ROUTEROS_IMAGE="chr-$ROUTEROS_VERSON.img"
ENV ROUTEROS_PATH="https://download.mikrotik.com/routeros/$ROUTEROS_VERSON/$ROUTEROS_IMAGE"

# Arguments
ARG VM_NAME=routeros
ARG VM_MEMORY=128M
ARG VM_DISK_SIZE=128M

# Download VDI image from remote site
RUN wget -qO- "$ROUTEROS_PATH".zip | bsdtar -C /routeros/ -xf-

# Copy script to routeros folder
ADD ["./scripts", "/routeros"]

VOLUME /routeros-instance

ENTRYPOINT ["/routeros/entrypoint.sh"]
