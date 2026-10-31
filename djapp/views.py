import os

from django.shortcuts import render
from .models import TestModel


def index(request):
    # Render through the template engine so model values are auto-escaped (XSS).
    context = {
        "environment": os.getenv("DJANGO_SETTINGS_MODULE"),
        "items": TestModel.objects.all(),
    }
    return render(request, "djapp/index.html", context)
