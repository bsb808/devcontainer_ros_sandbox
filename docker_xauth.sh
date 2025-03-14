#!/bin/bash
set -euxo pipefail
rm -r /tmp/.dockersim.xauth || true
touch /tmp/.dockersim.xauth
xauth nlist :1 | sed -e 's/^..../ffff/' | xauth -f /tmp/.dockersim.xauth nmerge -