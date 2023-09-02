# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /home/osman/my-app-project/app

# Copy the Python script into the container
COPY home/osman/my-app-project/app/* .

# Expose port 80 for the web server
EXPOSE 80

# Define the command to run when the container starts
CMD ["python", "home/osman/my-app-project/app/app.py"]
