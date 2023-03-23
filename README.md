# phproject-docker
Official Docker image for Phproject

This image is recommended for running Phproject in a production environment. For testing/CI, try the [alanaktion/phproject-ci](https://github.com/Alanaktion/phproject/tree/docker) image.

## Usage

This image is an optimized PHP 8 FPM server, with additional modules and optimizations for running Phproject. It requires a web server like nginx to proxy connections to FastCGI, and requires a MySQL server for the app to connect to.

For a basic environment, we'll use [`docker-compose`](https://github.com/docker/compose). Start by extracting the [latest release](https://github.com/Alanaktion/phproject/releases/latest) to the `/var/www/phproject` directory, then create a `docker-compose.yml` file:


```yml
version: '3.1'

services:

  phproject:
    image: alanaktion/phproject
    restart: always
    volumes:
      - /var/www/phproject:/var/www/phproject

  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: phproject
      MYSQL_USER: phproject
      MYSQL_PASSWORD: secret
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql

  nginx:
    image: nginx:latest
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - /var/www/phproject:/var/www/phproject
    ports:
      - 80:80

volumes:
  db:
```

This could use an `nginx.conf` file like this:

```nginx
http {
  server {
    listen 80;

    server_name phproject.example.com;
    root /var/www/phproject;
    index index.php;

    location / {
      try_files $uri $uri/ /index.php?$args;
    }

    location ~ [^/]\.php(/|$) {
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      fastcgi_pass phproject:9000;
      include fastcgi_params;
      fastcgi_param PATH_INFO $fastcgi_path_info;
    }
  }
}
```

Once started, you can use the web interface to complete the Phproject installation. Use `db` as your database host, with the configured database/user/password, if you're using the example `docker-compose.yml` from above.

### Production

Production-ready Apache server images with Phproject code included are built in the "release" directory. The [`alanaktion/phproject` image](https://hub.docker.com/r/alanaktion/phproject) on Docker Hub includes `apache-x.y.z` tags for each supported Phproject release, and an `apache` tag for the latest release build. These images include the PHP code and dependencies, allowing you to run the image directly without needing to have the Phproject code on the local filesystem. File uploads will be stored in the container unless a volume is mapped for the uploads directory.

For a simple Docker Compose setup using release images:

```yml
services:
  phproject:
    # You can omit the version number suffix to always run the latest production release code
    image: alanaktion/phproject:apache-1.7.14
    ports:
      - 80:80
    volumes:
      - uploads:/var/www/phproject/uploads
  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: phproject
      MYSQL_USER: phproject
      MYSQL_PASSWORD: secret
    volumes:
      - db:/var/lib/mysql
volumes:
  uploads:
  db:
```

## Building

To build and push this image:

```bash
docker build -t alanaktion/phproject .
docker push alanaktion/phproject
```

You'll need to replace the image name with one you're able to push to, if you want to push the built image. You can build without the `--push` option if you just want a local build.

Our production builds are available for the amd64, arm64, and armv7 platforms, using [docker buildx](https://docs.docker.com/buildx/working-with-buildx/). This works similarly to the standard build:

```bash
docker buildx create --use
docker buildx ls
docker buildx build \
  --platform linux/amd64,linux/arm/v7,linux/arm64 \
  --tag alanaktion/phproject \
  --push \
  .
```

For our automated builds, we use GitHub Actions to handle this process. See the `.github/workflows/image.yml` file in the repository for how that works. It is also automatically re-built once a week in case the upstream PHP image is changed, using the `.github/dependabot.yml` file.
