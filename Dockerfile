# Using the official python image as the base image
FROM python:3.8-slim

# Setting the working directory in the container
WORKDIR /home/osman/my-app-project/app

# Copy python script into the container
COPY app.py .

# Expose port 80 for the web server
EXPOSE 80

# the command to run when the container starts
CMD ["python", "app.py"]
