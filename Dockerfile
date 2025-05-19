FROM ubuntu:22.04

# Install dependencies and NetHack
RUN apt update && apt install -y \
    ttyd \
    nethack-console \
    && useradd -m nethack

USER nethack
WORKDIR /home/nethack

# Start ttyd and auto-run NetHack
CMD ["ttyd", "--port", "8080", "--once", "nethack"]
