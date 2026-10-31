# Use the official Python image as a base
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Define build-time arguments
ARG DJANGO_SETTINGS_MODULE_ARG=djapp.settings.dev

# Set environment variables for Django settings
ENV DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE_ARG

# Database settings (DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT) are
# supplied at runtime by the container environment, never baked into the image.

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

# Run as an unprivileged user
RUN groupadd --system app && useradd --system --gid app --home-dir /app app \
    && chown -R app:app /app
USER app

HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/', timeout=5)" || exit 1
ENTRYPOINT ["/app/entrypoint.sh"]

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "djapp.wsgi:application"]