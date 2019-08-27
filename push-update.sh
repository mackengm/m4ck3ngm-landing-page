#!/bin/bash
cd ~/Projects/summittdweller-landing-page
perl -i.bak -lpe 'BEGIN { sub inc { my ($num) = @_; ++$num } } s/(build = )(\d+)/$1 . (inc($2))/eg' config.toml
docker image build -t summittdweller-landing-update .
# docker login
docker tag summittdweller-landing-update summittdweller/summittdweller-landing:latest
docker push summittdweller/summittdweller-landing:latest
