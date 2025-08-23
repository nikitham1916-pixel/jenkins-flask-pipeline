# Use an official Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install
COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY app/ .

# Expose the port Flask runs on
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]


