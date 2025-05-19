FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Create writable versions of perm and record
RUN mkdir -p /home/nethack/hackdir && \
    cp -a /var/games/nethack/* /home/nethack/hackdir/ && \
    touch /home/nethack/hackdir/record /home/nethack/hackdir/perm && \
    chown -R nethack:nethack /home/nethack/hackdir && \
    rm -f /var/games/nethack/record /var/games/nethack/perm && \
    ln -s /home/nethack/hackdir/record /var/games/nethack/record && \
    ln -s /home/nethack/hackdir/perm /var/games/nethack/perm

# Set game path to writable directory
ENV HACKDIR=/home/nethack/hackdir
ENV HACKOPTIONS="name:guest"

USER nethack
WORKDIR /home/nethack

CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
