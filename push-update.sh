#!/bin/bash
cd ~/Projects/static-landing-page
perl -i.bak -lpe 'BEGIN { sub inc { my ($num) = @_; ++$num } } s/(build = )(\d+)/$1 . (inc($2))/eg' config.toml
docker image build -t static-landing-update .
docker login
docker tag static-landing-update mcfatem/static-landing:latest
docker push mcfatem/static-landing:latest
