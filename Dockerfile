FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and NetHack
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

USER nethack
WORKDIR /home/nethack

# Use the full path to NetHack to ensure it runs
CMD ["ttyd", "--port", "8080", "--once", "/usr/games/nethack"]
