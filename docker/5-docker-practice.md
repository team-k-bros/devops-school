# Docker practice - react deployment

## Create a react app

create-react-app
```bash
$ brew install node
$ npm install -g create-react-app
$ npx create-react-app my-app
$ cd my-app
$ npm start
```

## Serverless Deployment Platform (vercel)

[https://vercel.com](https://vercel.com/)

1. Vercel Login & Github 연동
2. Configure Project
    - build command
    `CI='' npm run build`
3. Deploy

## S3 Hosting

1. Build react app
```bash
$ yarn build
```
2. Create AWS S3 Bucket - public
3. Add Bucket Policy
```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::my-bucket/*"]
    }
  ]
}
```
4. S3 file upload
```bash
$ aws s3 sync ./build s3://my-bucket --profile=default
```

## Docker + Nginx

```bash
$ echo "node_modules" > .dockerignore
$ docker build --target react-nginx -t react-nginx:latest .
$ docker run -p 80:80 -d react-nginx:latest
```

with docker compose
```bash
$ pwd
/your-path-to-1m/Docker/docker-03
$ cp Dockerfile ./your-project-folder
$ docker compose up react-nginx
```

## S3 upload with Docker

```bash
$ docker build --target react-s3 -t react-s3:latest .

$ docker run -e "AWS_ACCESS_KEY_ID={AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}" -e "AWS_DEFAULT_REGION=ap-northeast-2" react-s3:latest s3 sync ./build s3://my-bucket
```

with docker compose
```bash
$ pwd
/your-path-to-1m/Docker/docker-03
$ cp Dockerfile ./your-project-folder
$ docker compose run react-push-to-s3
```
