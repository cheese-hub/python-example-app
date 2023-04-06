# Jupyter Docker Starter Kit
This is an example Jupyter-based Python application that is packaged and run as a Docker image.

By including a small AppSpec JSON file describing how to run it, this same Docker image can run inside of the [CHEESEHub](https://hub.cheesehub.org/) platform.


# Prerequisites
You will need to install [Docker Desktop](https://docs.docker.com/get-docker/)

You can use these steps to modify and rebuild this example using Docker


# Quick Start
Recommended developer workflow:
1. `docker compose up -d --build` - start the application
2. Navigate to http://localhost:8888 to make your edits - iterate on this until you are happy with your changes
3. `docker compose down` - shut it down
4. `docker compose build && docker compose push` - build and publish the image
5. (Optional) `kubectl apply -f kubernetes.yaml` - run image in Kubernetes cluster (must be published first)
6. Navigate to http://localhost:8888 again to perform final testing
7. `kubectl delete -f kubernetes.yaml` - shut it down again
8. Create a new AppSpec describing how to run this Docker image
9. Make a PR to add the new AppSpec into the [CHEESEHub Catalog](https://github.com/cheese-hub/catalog)


# Development
First, you'll need to create a pre-packaged Docker image that will run your application for you.

Feel free to use this repo as a starting point and make modifications as needed :)


## 1) Startup
To build and run the application:
```bash
% docker compose up -d --build
```
OR
```bash
$ docker build -t cheesehub/python-example-app .
$ docker run -itd -p 8888:8888 -v $(pwd):/home/jovyan --name python-example-app cheesehub/python-example-app
```


## 2) Making Changes
Once the application is running, you can navigate to http://localhost:8888 in your browser to use JupyterLab to edit and test your code, as well as for keeping and formatting your notes. Open the `Example.ipynb` notebook to see an example.

You can use Markdown cells to create formatted instructions or use `%run filename.py` to run pure Python functions.

Shift + Enter can be used to evaluate the cell and/or format markdown.

<img width="1680" alt="Screen Shot 2023-04-06 at 5 48 29 PM" src="https://user-images.githubusercontent.com/1413653/230507690-d3e1d24f-ab36-4fc3-99a7-76735e8b3911.png">


## 3) Shutdown
To stop the application, you can run:
```bash
$ docker compose down
```
OR
```bash
$ docker stop python-example-app && docker rm -f python-example-app
```

# 4) Publishing the Docker Image
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


# 5-7) Optional: Testing in Kubernetes
We can [use Docker Desktop to run a local Kubernetes cluster](https://docs.docker.com/desktop/kubernetes/) to test this application.

**WARNING: make sure to stop your existing Docker container to avoid port conflicts with Kubernetes**

## Startup
We can use the included `integration/kubernetes.yaml` to test running this application in a local cluster:
```bash
$ kubectl apply -f integration/kubernetes.yaml
```

You should then be able to access the application on http://localhost:8888 as before - the image is now running as if it were running in production.

## Shutdown
To shut down the application, you can run the following:
```bash
$ kubectl delete -f integration/kubernetes.yaml
```


# 8) Integration with CHEESEHub
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


# 9) Contributing Back to CHEESEHub
Once your application is tested and working in CHEESEHub, you can make a PR to our [Application Catalog](https://github.com/cheese-hub/catalog).

Before merging it into our catalog, we will review and test your submission to verify the following:
* Working Docker image + build process in place - see steps 1-3 above
* Image has been built and pushed to a public image repository (e.g. DockerHub) - see step 4 above

We may need to work with you to create a lesson plan or set of instructions to demonstrate the security concept or vulnerability highlighted by your code.

Once your additions have been merged, the new application will be available to all users of CHEESEHub! :tada: :confetti_ball:
