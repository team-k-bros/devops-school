# Docker-compose

## docker로 작업

```bash
$ docker run --name db -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 -d docker.io/library/mariadb:10.3

$ docker build -t backend:latest .
$ docker run --name=backend -p 5000:5000 -d backend:latest

$ docker build -t proxy:latest .
$ docker run --name=proxy -p 80:80 -d proxy:latest
```

## logs

```bash
$ docker logs CONTAINER_NAME

# 로그 계속 확인하기
$ docker logs -f CONTAINER_NAME
```

## inspect

```bash
$ docker inspect CONTAINER_NAME

# ip 확인하기
$ docker inspect CONTAINER_NAME | grep -ir ip

$ docker volume ls
$ docker inspect volume VOLUME_NAME

$ docker network ls
$ docker inspect network VOLUME_NAME
```

## docker-compose

### Up & Down

- docker-compose up

```bash
$ docker-compose up -d

$ docker ps

$ docker images

$ docker-compose down
```

### DNS resolution in docker-compose

- backend/hello.py
- proxy/conf

### docker-compose checklist

- services
- command
- volumes
- networks
- environment
- expose vs ports
- depends_on
