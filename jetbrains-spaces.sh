#!/bin/bash
mkdir -p space-on-premises && cd space-on-premises
export SPACE_RELEASE_NAME="2024.1.0"
curl -O "https://assets.on-premises.service.jetbrains.space/${SPACE_RELEASE_NAME}/docker-compose.yml"
docker-compose -p space-on-premises up -d

