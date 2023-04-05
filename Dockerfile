 # Choose base image here - this determines the OS / version / package manager
FROM python:3

# Change the working directory inside of the image
WORKDIR /app

# Install any other OS packages that are needed
# RUN apt-get -qq update && apt-get -qq install curl

# Copy requirements.txt into the image
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Copy the rest of the source code into the image
COPY . .

# After container starts up, wait for manual shutdown
CMD ["python", "./main.py"]
