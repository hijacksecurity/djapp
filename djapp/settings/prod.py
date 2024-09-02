import os
from .base import *

DEBUG = False

ALLOWED_HOSTS = ['*']  # Update this for production use

def get_env_variable(var_name, default_value):
    """ Get the environment variable or return the default value if it's empty or not set. """
    value = os.getenv(var_name, default_value)
    return value if value else default_value

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': get_env_variable('DB_NAME', 'mydb'),
        'USER': get_env_variable('DB_USER', 'myuser'),
        'PASSWORD': get_env_variable('DB_PASSWORD', 'mypassword'),
        'HOST': get_env_variable('DB_HOST', 'db'),
        'PORT': get_env_variable('DB_PORT', '5432'),
        'OPTIONS': {
            'sslmode': 'require',  # Enforce SSL connections
        },
    }
}

# Security settings
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_SSL_REDIRECT = False  # Set to True if using HTTPS in production
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
X_FRAME_OPTIONS = 'DENY'
SECURE_HSTS_SECONDS = 31536000
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# Static and media files settings for production
STATIC_URL = '/static/'
STATIC_ROOT = '/var/www/djapp/static/'

MEDIA_URL = '/media/'
MEDIA_ROOT = '/var/www/djapp/media/'