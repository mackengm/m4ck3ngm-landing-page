# summittdweller-landing-page

This project defines the landing page for my summittdweller.com server.  

# Deploying this Site

This site is intended to be deployed using my [docker-bootstrap](https://github.com/McFateM/docker-bootstrap) approach, and the command stream used to launch [the page]( https://summittdweller.com/) on my DigitalOcean Docker droplet is:

```
NAME=summittdweller-landing-page
HOST=summittdweller.com
IMAGE="summittdweller/summittdweller-landing"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=traefik_webgateway \
    --label "traefik.frontend.rule=Host:${HOST}" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network traefik_webgateway \
    --restart always \
    ${IMAGE}
```

# Updating This Site

The process of adding a site, or any addition/change, to this page is pretty straightforward...

```
cd ~/Projects/summittdweller-landing-page
docker image build -t new-img .
docker login
docker tag new-img summittdweller/summittdweller-landing:latest
docker push summittdweller/summittdweller-landing:latest
```

Watchtower should *automagically* take care of the rest!

# An Even Easier Update

Not long ago I added the _Atom Shell Commands_ package to my _Atom_ config, added a command named **Push a Static Update**, and pointed that command at the _push_update.sh_ script that is now part of this project.  That _bash_ script, does just a few things, and it reads like this:

```bash
#!/bin/bash
cd ~/Projects/summittdweller-landing-page
perl -i.bak -lpe 'BEGIN { sub inc { my ($num) = @_; ++$num } } s/(build = )(\d+)/$1 . (inc($2))/eg' config.toml
docker image build -t landing-update .
docker login
docker tag landing-update mcfatem/summittdweller-landing:latest
docker push mcfatem/summittdweller-landing:latest
```
The `perl...` line runs a text substitution that opens the project's `config.toml` file, parses it looking for a string that matches `build = ` followed by an integer.  The substitution increments that interger by one and puts the result back into an updated `config.toml` file.  The result is eventually the `Build 14`, or whatever number, that you see just below the site title and descriptions.  

The rest of the _push_update.sh_ script is responsible for building a new docker image, logging in to _Docker Hub_, tagging the new image as the `:latest` version of _summittdweller-landing_, and pushing that new tagged image to my _Docker Hub_ account where _Watchtower_ can do its thing.
