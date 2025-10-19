FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y dante-server && \
    rm -rf /var/lib/apt/lists/*

COPY danted.conf /etc/danted.conf

EXPOSE 1080

CMD ["bash", "-c", "sudo danted -f /etc/danted.conf"]
