# Use the official Python image as a base
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Define build-time arguments
ARG DJANGO_SETTINGS_MODULE_ARG=djapp.settings.dev
ARG DB_NAME_ARG=""
ARG DB_USER_ARG=""
ARG DB_PASSWORD_ARG=""
ARG DB_HOST_ARG=""
ARG DB_PORT_ARG=""

# Set environment variables for Django settings
ENV DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE_ARG

# Conditionally set environment variables for database, only if provided
# This pattern allows them to remain empty in non-production environments
ENV DB_NAME=$DB_NAME_ARG
ENV DB_USER=$DB_USER_ARG
ENV DB_PASSWORD=$DB_PASSWORD_ARG
ENV DB_HOST=$DB_HOST_ARG
ENV DB_PORT=$DB_PORT_ARG

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . /app/

# Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh

# Expose port 8000
EXPOSE 8000

# Set the entry point to the entrypoint script
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "djapp.wsgi:application"]