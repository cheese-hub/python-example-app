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

To run the image:
```bash
$ docker run -it --rm cheesehub/python-example-app
Hello World!
```


## With Docker Compose
To build the image:
```bash
$ docker compose build
```

To run the image:
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
