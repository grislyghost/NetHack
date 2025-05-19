FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && \
    apt install -y ttyd nethack-console && \
    useradd -m nethack

# Add startup script
COPY entrypoint.sh /home/nethack/entrypoint.sh
RUN chmod +x /home/nethack/entrypoint.sh && \
    chown nethack:nethack /home/nethack/entrypoint.sh

USER nethack
WORKDIR /home/nethack

CMD ["./entrypoint.sh"]
