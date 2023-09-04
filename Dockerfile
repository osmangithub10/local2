# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /home/osman/my-app-project/app

# Copy the Python script into the container
COPY app.py .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Expose port 80 for the web server
EXPOSE 80

# Define the command to run when the container starts
CMD ["python", "app.py"]
