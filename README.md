# Python Docker Starter Example
This is an example Python Docker application.

# Prerequisites
You will need to install [Docker Desktop](https://docs.docker.com/get-docker/)

# Development
You can use these steps to modify and rebuild this example using Docker

## With Docker Compose
To build and run the application, run `docker compose up -d --build`:
```bash
% docker compose up -d --build
[+] Building 0.7s (11/11) FINISHED                                                                                             
 => [internal] load build definition from Dockerfile                                                                      0.0s
 => => transferring dockerfile: 32B                                                                                       0.0s
 => [internal] load .dockerignore                                                                                         0.0s
 => => transferring context: 35B                                                                                          0.0s
 => [internal] load metadata for docker.io/jupyter/base-notebook:latest                                                   0.6s
 => [auth] jupyter/base-notebook:pull token for registry-1.docker.io                                                      0.0s
 => [internal] load build context                                                                                         0.0s
 => => transferring context: 287B                                                                                         0.0s
 => [1/5] FROM docker.io/jupyter/base-notebook@sha256:7235c406df72c3e7f6abd1bbfbea0ce8aeedf1823b69fcdc7eb39a7f7e745116    0.0s
 => CACHED [2/5] RUN conda update -n base conda                                                                           0.0s
 => CACHED [3/5] RUN mkdir -p /home/jovyan && fix-permissions /home/jovyan                                                0.0s
 => CACHED [4/5] COPY --chown=1000:100 . /home/jovyan                                                                     0.0s
 => CACHED [5/5] WORKDIR /home/jovyan                                                                                     0.0s
 => exporting to image                                                                                                    0.0s
 => => exporting layers                                                                                                   0.0s
 => => writing image sha256:352f303e711f42c40be69cefbe39646392609a7b2f70e7f6d77dc82a567cd07a                              0.0s
 => => naming to docker.io/cheesehub/python-example-app                                                                   0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
[+] Running 2/2
 ⠿ Network python-example-app_default  Created                                                                            0.1s
 ⠿ Container python-example-app        Started 
```

You can then access Jupyter in your browser by navigating to http://localhost:8888

## With Docker
To build the image:
```bash
$ docker build -t cheesehub/python-example-app .
```

To run a container from the image:
```bash
$ docker run -it -p 8888:8888 cheesehub/python-example-app
```

You can then access Jupyter in your browser by navigating to http://localhost:8888

## Without Docker
Modify the code and then execute `python ./main.py`:
```bash
$ python ./main.py
Hello World!
```

You can also install Jupyter locally and you can use that to make your edits using that

# Testing + Instructions
Once the container is running, you can navigate to http://localhost:8888 in your browser to see the running application.

## With Jupyter Notebook
You can use Jupyter to test your code and keep notes.

On http://localhost:8888, open the `Example.ipynb` notebook to see an example.

You can use Markdown cells to create formatted instructions or use `%run filename.py` to run pure Python functions.

Shift + Enter can be used to evaluate the cell and/or format markdown.


# Publishing the Docker Image
To share this image with others (or to use it in production), the built image must be pushed to a repository.

We can use DockerHub for this, but any public image repo should work.


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



# In CHEESEHub
The last step needed is to create a JSON spec describing how to run this Docker image.

For more technical details about the required format, see: https://github.com/nds-org/ndslabs-specs

## AppSpec JSON
You can build this JSON up manually, or use our Add/Edit Spec page to build this JSON for you.

NOTE: You will need to request `developer` access to the CHEESEHub to use this feature.
Please reach out to your system adminstrator to request this access.

Navigate to https://hub.cheesehub.org/my-catalog/create to see the Editor.
At the bottom, you should see a toggle button that says "Show JSON Spec".
Click on this to see the JSON Spec, which should update automatically as you edit the page:
```json
{
    "key": "pyexample",
    "label": "Python Example App",
    "display": "stack",
    "access": "external",
    "image": {
        "name": "cheesehub/python-example-app",
        "tags": ["latest"]
    },
    "logo": "",
    "info": "",
    "depends": [],
    "config": [],
    "ports": [
        {
            "protocol": "HTTP",
            "port": "8888",
            "contextPath": ""
        }
    ],
    "volumeMounts": [],
    "additionalResources": [],
    "repositories": [],
    "command": [],
    "args": [],
    "catalog": "user",
    "tags": []
}
```

Enter details about your application.

You are required to enter the following:
* Key - choose a unique alphanumeric string identifier (e.g. `pyexample`)
* Label - the name to display in the CHEESEHub UI (e.g. `Example Python App`)
* Docker image name - the repo/org/image name of the Docker image (e.g. `cheesehub/python-example-app`)
* Docker tags - the version tag to use for Docker (e.g. `latest`)
* Ports - if your application uses a particular port (e.g. Jupyter uses `8888`)

Advanced Features:
* Environment - if your code requires any environment variables (e.g. `os.getenv('MYSQL_USER'`)
* Dependencies - if your code requires multiple Docker images to run (e.g. `arpspoof-hacker` depends on `arpspoof-victim`)
* Volumes - if you want to mount a folder for the user to save files
