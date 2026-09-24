#!/bin/bash
set -euxo pipefail

dnf install -y docker
systemctl enable docker
systemctl start docker

# Pull and run the containerised page. Restart policy + a systemd unit give
# the same self-healing behaviour at the container level, on top of the ASG
# giving it at the instance level.
docker pull ${container_image}
docker run -d \
  --name web \
  --restart unless-stopped \
  -p 80:80 \
  ${container_image}
