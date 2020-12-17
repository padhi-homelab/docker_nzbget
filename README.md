# docker_nzbget <a href='https://github.com/padhi-homelab/docker_nzbget/actions?query=workflow%3A%22Docker+CI+Release'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_nzbget/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://microbadger.com/images/padhihomelab/nzbget'><img src='https://img.shields.io/microbadger/layers/padhihomelab/nzbget/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/nzbget'><img src='https://img.shields.io/docker/image-size/padhihomelab/nzbget/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [nzbget] Docker image, based on [Alpine Linux].

|        386         |       amd64        |       arm/v6       |       arm/v7       |       arm64        |      ppc64le       |       s390x        |
| :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: |
| :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |

## Usage

```
docker run --detach \
           -p 6789:6789 \
           -e DOCKER_UID=`id -u` \
           -v /path/to/store/configs:/configs \
           -v /path/to/store/data/and/logs:/data \
           -v /path/to/finished/downloads:/downloads/complete \
           -v /path/to/incomplete/downloads:/downloads/incomplete \
           -it padhihomelab/nzbget
```

Runs `nzbget` with WebUI served on port 6789.

_<More details to be added soon>_


[Alpine Linux]: https://alpinelinux.org/
[nzbget]:  https://www.nzbget.org/
