FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Prepare a writable copy of NetHack files
RUN mkdir -p /home/nethack/hackdir && \
    cp -a /var/games/nethack/* /home/nethack/hackdir/ && \
    chown -R nethack:nethack /home/nethack/hackdir

# Set the HACKDIR explicitly
ENV HACKDIR=/home/nethack/hackdir
ENV HACKOPTIONS="name:guest"

USER nethack
WORKDIR /home/nethack/hackdir

# Run from inside the writable hackdir
CMD ["ttyd", "--port", "8080", "--once", "./nethack"]
