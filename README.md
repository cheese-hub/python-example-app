# Python Docker Starter Example
This is an example Python Docker application.


# Development
You can use these steps to modify and rebuild this example


## Without Docker
Modify the code and then execute `python ./main.py`:
```bash
$ python ./main.py
Hello World!
```


## With Docker
To build the image:
```bash
$ docker build -t cheesehub/python-example-app .
```

To run a container from the image:
```bash
$ docker run -it --rm cheesehub/python-example-app
Hello World!
```


## With Docker Compose
To build the image:
```bash
$ docker compose build
```

To run a container from the image:
```bash
$ docker compose up
[+] Running 1/0
 ⠿ Container python-example-app-python-example-app-1  Created                                                             0.0s
Attaching to python-example-app-python-example-app-1
python-example-app-python-example-app-1  | Hello World!
python-example-app-python-example-app-1 exited with code 0
```

To build and run the image in one step:
```bash
$ docker compose up --build
```


# Publishing the Docker Image
## Login to DockerHub
Create an account on DockerHub if you haven't already.

You can login to this account from the `docker` CLI:
```bash
$ docker login
```

This will prompt you for your DockerHub username and password

## Pushing an Image to DockerHub
To push the image to DockerHub:
```bash
$ docker push cheesehub/python-example-app
```
OR
```bash
$ docker compose push
```

This will upload the latest image from your local machine to DockerHub.

## Pulling an Image from DockerHub
To pull the image from DockerHub:
```bash
$ docker pull cheesehub/python-example-app
```
OR
```bash
$ docker compose pull
```

This will fetch the latest image from DockerHub and download it to your local machine.
