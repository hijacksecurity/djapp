from .base import *

DEBUG = True

ALLOWED_HOSTS = ['*']

# Testing-specific database configuration
DATABASES['default'] = {
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': BASE_DIR / 'test_db.sqlite3',
}
