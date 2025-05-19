FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Prepare writable scoreboard path
RUN mkdir -p /home/nethack/hackdir && \
    cp -a /var/games/nethack/* /home/nethack/hackdir/ && \
    chown -R nethack:nethack /home/nethack/hackdir && \
    ln -sf /home/nethack/hackdir/record /var/games/nethack/record

# Set HACKDIR and run from a valid binary
ENV HACKDIR=/home/nethack/hackdir
ENV HACKOPTIONS="name:guest"

USER nethack
WORKDIR /home/nethack

CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
