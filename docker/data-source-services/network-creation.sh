#!/usr/bin/env bash
echo "Creating container networks:"
docker network create st-internal --label "com.docker.compose.network=default"
