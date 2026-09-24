#!/bin/bash
set -euxo pipefail

dnf install -y nginx
systemctl enable nginx
systemctl start nginx
