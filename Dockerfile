# Use the official Python image as a base
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Define build-time arguments
ARG DJANGO_SETTINGS_MODULE_ARG=djapp.settings.dev
ENV DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE_ARG

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . /app/

# Set environment variables for Django
# These should be passed during runtime via docker-compose or manually during the docker run command
ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_HOST=${DB_HOST}
ENV DB_PORT=${DB_PORT}

# Expose port 8000
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "djapp.wsgi:application"]