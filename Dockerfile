FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack && \
    mkdir -p /home/nethack/.nethack && \
    chown -R nethack:nethack /home/nethack/.nethack

# Set NetHack to use a writable directory
ENV HACKDIR=/home/nethack/.nethack

USER nethack
WORKDIR /home/nethack

# Start ttyd, auto-run NetHack
CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
