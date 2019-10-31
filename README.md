# Dockerfile of ngrok on Alpine Linux

This container publishes other container's http connection to the public via [ngrok](https://ngrok.com/).

It publishes only the http connection in the same Docker network, so you don't need to expose the port to the host.

If you are familiar to docker-compose, then see the [sample docker-compose.yml file](./docker-compose.yml) first to capture the sense.

## How To

Using [docker-compose](https://docs.docker.com/compose/) is the easiest way and little more secure.

With docker-compose you will launch at least two containers.

One is the container that provides http service you want. Web page, blog, Web API, etc. anything that can be access via http. You don't need to expose the port to the host. But be sure it is accessible from the other container in the same Docker network.

Two is the container of ngrok. Which ports the http access to the container above to the public.

### Prepare HTTP Service Container

1. Prepare a container that serves http service. <br>Here we use [kagome's Web API](https://github.com/ikawaha/kagome#http-service) but launching any web server is OK.

### Prepare ngrok requirements

To launch ngrok container you need the `Authtoken` and the container name of your service.

1. Crete account in ngrok and [login](https://dashboard.ngrok.com/login).
2. Get [Your Tunnel Authtoken](https://dashboard.ngrok.com/auth).
3. Rename `ENVFILE.env.sample` to `ENVFILE.env`
