FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Create writable NetHack environment
RUN mkdir -p /home/nethack/hackdir && \
    cp -a /var/games/nethack/* /home/nethack/hackdir/ && \
    touch /home/nethack/hackdir/record \
          /home/nethack/hackdir/perm \
          /home/nethack/hackdir/lock.0 && \
    chown -R nethack:nethack /home/nethack/hackdir && \
    rm -f /var/games/nethack/record \
          /var/games/nethack/perm \
          /var/games/nethack/lock.0 && \
    ln -s /home/nethack/hackdir/record /var/games/nethack/record && \
    ln -s /home/nethack/hackdir/perm /var/games/nethack/perm && \
    ln -s /home/nethack/hackdir/lock.0 /var/games/nethack/lock.0

# Environment vars
ENV HACKDIR=/home/nethack/hackdir
ENV HACKOPTIONS="name:guest"

USER nethack
WORKDIR /home/nethack

# Launch NetHack through ttyd
CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
