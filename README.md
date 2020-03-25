# m4ck3ngm-landing-page

This project defines Mackenzie's landing page on the summitt-dweller-DO-docker droplet.  

# Deploying this Site

This site is intended to be deployed using [dockerized-server](https://github.com/McFateM/dockerized-server) approach, and the command stream used to launch [the page]( https://m4ck3ngm.com/) on the droplet is:

```
NAME=m4ck3ngm-landing-page
HOST=m4ck3ngm.com
IMAGE="m4ck3ngm/m4ck3ngm-landing-page"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=web \
    --label "traefik.frontend.rule=Host:${HOST}" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network web \
    --restart always \
    ${IMAGE}
```
