# MinIO

The data source services includes an application called minio. This allows you to run an S3 service locally. You do not need access to AWS to use this service.

In order for minio to operate, you must follow the following steps after running `docker-compose` for the data source services.

## Post `docker-compose` Setup

1. Edit the `/etc/hosts` file on your system and make a reference for
```
127.0.0.1 s3.docker
```
2. Open your browser and navigate to the admin console `http://s3.docker:9090` and login to the MinIO admin console.
``` 
username: root
password: password
```
3. Create an appropriate bucket for each project as needed.
4. Modify your project's `.env` file to match the following:
```
FILESYSTEM_DRIVER=s3

AWS_ACCESS_KEY_ID=root
AWS_SECRET_ACCESS_KEY=password
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=[project-bucket-name]
AWS_ENDPOINT=http://s3.docker:9000
AWS_USE_PATH_STYLE_ENDPOINT=true
```
