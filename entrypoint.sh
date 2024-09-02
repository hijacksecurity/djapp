#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to wait for the database to be ready
wait_for_db() {
  # Determine which database to check based on DB_HOST environment variable
  if [ -n "$DB_HOST" ]; then
    DB_TO_CHECK=$DB_HOST
  else
    DB_TO_CHECK=default
  fi

  echo "Waiting for database connection ($DB_TO_CHECK)..."
  until python manage.py check --database $DB_TO_CHECK; do
    >&2 echo "Database is unavailable - sleeping"
    sleep 1
  done
  echo "Database is up - continuing..."
}

# Wait for the database to be ready
wait_for_db

# Run database migrations
echo "Running database migrations..."
python manage.py makemigrations
python manage.py migrate

# Run the application
exec "$@"
