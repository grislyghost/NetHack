FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack && \
    mkdir -p /home/nethack/hackdir && \
    cp -r /var/games/nethack/* /home/nethack/hackdir/ 2>/dev/null || true && \
    chown -R nethack:nethack /home/nethack/hackdir

# Set NetHack to use a writable location
ENV HACKDIR=/home/nethack/hackdir

USER nethack
WORKDIR /home/nethack

# Run NetHack via ttyd on port 8080
CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
