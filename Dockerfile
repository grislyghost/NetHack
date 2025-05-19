FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Replace /var/games/nethack with a writable version
RUN mkdir -p /home/nethack/hackdir && \
    cp -a /var/games/nethack/* /home/nethack/hackdir/ || true && \
    chown -R nethack:nethack /home/nethack/hackdir && \
    rm -rf /var/games/nethack && \
    ln -s /home/nethack/hackdir /var/games/nethack

# Optional: customize name
ENV HACKOPTIONS="name:guest"

USER nethack
WORKDIR /home/nethack

CMD ["ttyd", "--port", "8080", "--theme", "background=#000000,fontSize=16", "/usr/games/nethack"]
