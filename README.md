# Jupyter Docker Starter Example
This is an example Jupyter-based Python application that run is packaged as a Docker image.

By including a small AppSpec JSON file describing the Docker image, the image can run inside of the [CHEESEHub](https://hub.cheesehub.org/) platform.


# Prerequisites
You will need to install [Docker Desktop](https://docs.docker.com/get-docker/)

You can use these steps to modify and rebuild this example using Docker


# Quick Start
Recommended developer workflow:
1. `docker compose up -d --build` - start the application
2. Navigate to http://localhost:8888
3. Make your edits
4. `docker compose down` - shut it down
5. `docker compose build && docker compose push` - build and publish the image
6. (Optional) `kubectl apply -f kubernetes.yaml` - run image in Kubernetes cluster (must be published first)
7. Navigate to http://localhost:8888 again
8. Perform final testing
9. `kubectl delete -f kubernetes.yaml` - shut it down again
10. Create a new AppSpec describing how to run this Docker image
11. Make a PR to merge the new AppSpec into the [CHEESEHub Catalog](https://github.com/cheese-hub/catalog)


# Getting Started
Once the application is running, you can navigate to http://localhost:8888 in your browser to see the running application.

You can use JupyterLab to edit and test your code, as well as for keeping and formatting your notes.

On http://localhost:8888, open the `Example.ipynb` notebook to see an example.

You can use Markdown cells to create formatted instructions or use `%run filename.py` to run pure Python functions.

Shift + Enter can be used to evaluate the cell and/or format markdown.


## Startup
To build and run the application:
```bash
% docker compose up -d --build
```
OR
```bash
$ docker build -t cheesehub/python-example-app .
$ docker run -itd -p 8888:8888 -v $(pwd):/home/jovyan --name python-example-app cheesehub/python-example-app
```

## Shutdown
To stop the application, you can run:
```bash
$ docker compose down
```
OR
```bash
$ docker stop python-example-app && docker rm -f python-example-app
```

# Publishing the Docker Image
To share this image with others (and to use it in production), we must push to an image repository.

We can use DockerHub for this, but any public image repo should work.

You can create an account on [DockerHub](https://hub.docker.com/) if you haven't already and push your images there.

## Login to DockerHub
You'll need to log into your DockerHub account to be able to push images.

You can login to this account from the `docker` CLI:
```bash
$ docker login
```

This will prompt you for your DockerHub username and password.

## Pushing an Image to DockerHub
To push the image to DockerHub:
```bash
$ docker compose push
```
OR
```bash
$ docker push cheesehub/python-example-app
```

This will upload the latest image from your local machine to DockerHub.

## Pulling an Image from DockerHub
To pull the image from DockerHub:
```bash
$ docker compose pull
```
OR
```bash
$ docker pull cheesehub/python-example-app
```

This will fetch the latest image from DockerHub and download it to your local machine.


# Optional: Testing in Kubernetes
We can [use Docker Desktop to run a local Kubernetes cluster](https://docs.docker.com/desktop/kubernetes/) to test this application.

**WARNING: make sure to stop your existing Docker container to avoid port conflicts with Kubernetes**

## Startup
We can use the included `integration/kubernetes.yaml` to test running this application in a local cluster:
```bash
$ kubectl apply -f integration/kubernetes.yaml
```

You should then be able to access the application on http://localhost:8888 as before - the image is now running as it will in production.

## Shutdown
To shut down the application, you can run the following:
```bash
$ kubectl delete -f integration/kubernetes.yaml
```


# Integration with CHEESEHub
The last step needed is to create a JSON spec telling CHEESEHub how to run this Docker image.

For more technical details about the required format, see: https://github.com/nds-org/ndslabs-specs

## AppSpec JSON
You can build this JSON up manually, or use our Add/Edit Spec page to build this JSON for you.

NOTE: You will need to request `developer` access to the CHEESEHub to use this feature.
Please reach out to your system adminstrator to request this access.

Navigate to https://hub.cheesehub.org/my-catalog/create to see the Editor.
At the bottom, you should see a toggle button that says "Show JSON Spec".

Click on this toggle to see the JSON Spec, which should update automatically as you edit the page.

We've included a sample `integration/appspec.json` file that runs this example application:
```json
{
  "access": "external",
  "additionalResources": [],
  "args": [],
  "catalog": "user",
  "command": [],
  "config": [],
  "creator": "lambert8illinoisedu",
  "depends": [],
  "display": "stack",
  "image": {
    "name": "cheesehub/python-example-app",
    "tags": [
      "latest"
    ]
  },
  "info": "",
  "key": "pyexample",
  "label": "Python Example App",
  "logo": "",
  "ports": [
    {
      "contextPath": "",
      "port": 8888,
      "protocol": "http"
    }
  ],
  "repositories": [],
  "tags": [],
  "volumeMounts": [
    {
      "mountPath": "/home/jovyan/work",
      "defaultPath": "work"
    }
  ]
}
```


You are required to at least enter the following:
* Key - choose a unique alphanumeric string identifier (e.g. `pyexample`)
* Label - the name to display in the CHEESEHub UI (e.g. `Example Python App`)
* Docker image name - the repo/org/image name of the Docker image (e.g. `cheesehub/python-example-app`)
* Docker tags - the version tag to use for Docker (e.g. `latest`)

Advanced Features:
* Volumes - if you want to mount a folder for the user to save files (e.g. `/home/jovyan/work` is shared with your other apps)
* Ports - if your application uses a particular port (e.g. Jupyter uses `8888`)
* Environment - if your code requires any environment variables (e.g. `os.getenv('MYSQL_USER'`)
* Dependencies - if your code requires multiple Docker images to run (e.g. `arpspoof-hacker` depends on `arpspoof-victim`)


# Bringing it all Together
Once your application works in CHEESEHub, you can make a PR to our [Application Catalog](https://github.com/cheese-hub/catalog).

Before merging it into our catalog, we will review and test your submission to verify the following:
* Working Docker image + build process
* Image has been pushed to a public image repository (e.g. DockerHub)
* A lesson plan and/or set of instrcutions for the demonstration is included

Once your additions have been merged, the new application will be available to all users of CHEESEHub! :tada: :confetti_ball:
