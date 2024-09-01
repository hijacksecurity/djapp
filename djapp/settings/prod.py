from .base import *

DEBUG = False

ALLOWED_HOSTS = ['*']

# Production-specific database configuration
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydb',
        'USER': 'myuser',
        'PASSWORD': 'mypassword',
        'HOST': 'db',
        'PORT': '5432',
    }
}

# Security settings
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
X_FRAME_OPTIONS = 'DENY'

# Static and media files settings for production
STATIC_URL = '/static/'
STATIC_ROOT = '/var/www/djapp/static/'

MEDIA_URL = '/media/'
MEDIA_ROOT = '/var/www/djapp/media/'
