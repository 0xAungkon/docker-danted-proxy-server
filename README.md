````markdown
# Danted Server Docker

A minimal, production-ready Docker setup for running a **Dante SOCKS5 proxy server** using Docker and Docker Compose.

This project is intended for **developers, DevOps engineers, SREs, system administrators, and security engineers** who need a reliable SOCKS5 proxy for traffic routing, testing, automation, or controlled network access.

---

## Features

- SOCKS5 proxy powered by **Dante**
- Optional **username/password authentication**
- Simple Docker and Docker Compose setup
- Lightweight and production-ready
- Fully configurable via `danted.conf`
- Suitable for cloud, VPS, on-prem, and lab environments
- Open-source and contribution-friendly

---

## Repository Structure

```text
.
├── Dockerfile
├── compose.yml
├── danted.conf
└── README.md
````

---

## Requirements

* Docker ≥ 20.x
* Docker Compose ≥ 2.x
* Linux host recommended (macOS/Windows supported via Docker Desktop)

---

## Quick Start

```bash
git clone https://github.com/your-username/danted-server-docker.git
cd danted-server-docker
docker compose up -d
```

```text
Host: <server-ip>
Port: 1080
Protocol: SOCKS5
```

---

## Authentication (IMPORTANT)

Dante supports **username/password authentication** using system users.

### 1. Enable Authentication in `danted.conf`

```conf
method: username
user.notprivileged: nobody

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect error
}

pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    protocol: tcp udp
    log: connect disconnect error
}
```

### 2. Create Users Inside the Container

```bash
docker exec -it danted adduser proxyuser
```

Set a strong password.

### 3. Restart the Service

```bash
docker compose restart
```

### 4. Connect With Authentication

```bash
socks5://proxyuser:password@<server-ip>:1080
```

#### curl

```bash
curl --socks5-user proxyuser:password --socks5 <server-ip>:1080 https://example.com
```

#### Git

```bash
git config --global http.proxy socks5://proxyuser:password@<server-ip>:1080
```

---

## Docker Compose Example

```yaml
services:
  danted:
    build: .
    container_name: danted
    ports:
      - "1080:1080"
    restart: unless-stopped
```

---

## Use Cases

### Proxy Server

* General-purpose SOCKS5 proxy
* Application-level traffic routing
* Secure outbound access from restricted networks

### VPN Alternative (Layer 5)

* Lightweight alternative to full VPN
* Per-application tunneling
* No routing table or kernel-level changes

### DevOps / SRE

* CI/CD outbound traffic control
* Infrastructure testing
* Network policy validation

### Automation & Scraping

* IP rotation via multiple proxies
* Controlled egress traffic
* Headless browser routing

### Security & Networking

* Bastion-style outbound proxy
* Network segmentation
* Audit and logging of outbound connections

---

## Who This Is For

* Backend & Platform Engineers
* DevOps / SRE Teams
* Security Engineers
* Infrastructure & Network Administrators
* Automation & QA Engineers

Not intended for anonymous public proxy hosting.

---

## Security Notes

* Always enable authentication
* Restrict client IP ranges
* Never expose port `1080` publicly without firewall rules
* Prefer private networks or VPN access
* Log and monitor connections



---

## Disclaimer

You are responsible for legal, ethical, and policy compliance when operating a SOCKS5 proxy.

```
```
