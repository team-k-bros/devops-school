# Docker Commands

## Docker 설치

https://docs.docker.com/desktop/mac/install/

## docker build & run 

- run nginx
```shell
$ docker run -p 80:80 -d nginx

$ docker ps

$ docker images

$ docker stop <container-id>
```

- mount index.html w/ Dockerfile
```shell
$ docker build -t nginx-test:latest -f Dockerfile-nginx .

$ docker images

$ docker run -p 80:80 -d nginx-test:latest

$ docker run -p 80:80 -d -v <your-directory>/index.html:/var/www/html/index.nginx-debian.html nginx-test:latest

$ docker exec -it <container-id> /bin/sh

```

- copy index.html /w Dockerfile

```shell
$ docker build -t nginx-test-copy:latest -f Dockerfile-nginx-copy .

$ docker images

$ docker run -p 80:80 -d nginx-test-copy:latest

$ docker exec -it <container-id> /bin/sh

```

## CMD vs ENTRYPOINT

- CMD
```shell
$ docker build -t test-cmd:latest -f Dockerfile-cmd .

$ docker run test-cmd:latest
$ docker run test-cmd:latest echo hello
```

- ENTRYPOINT
```shell
$ docker build -t test-entrypoint:latest -f Dockerfile-entrypoint .

$ docker run test-entrypoint:latest
$ docker run test-entrypoint:latest echo hello
```

## ECR push
```shell
$ aws ecr get-login-password --region ap-northeast-2 --profile default | docker login --username AWS --password-stdin 057618736984.dkr.ecr.ap-northeast-2.amazonaws.com

$ docker tag nginx-test:latest 057618736984.dkr.ecr.ap-northeast-2.amazonaws.com/<REPOSITORY_NAME>:latest

$ docker push 057618736984.dkr.ecr.ap-northeast-2.amazonaws.com/<REPOSITORY_NAME>:latest
```