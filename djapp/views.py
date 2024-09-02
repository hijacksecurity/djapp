import os

from django.http import HttpResponse
from .models import TestModel


def index(request):
    items = TestModel.objects.all()

    # Simple welcome message
    response_html = "<h2>Welcome to the Test Page!</h2><p>This is <b>{}</b> environment.</p>".format(os.getenv("DJANGO_SETTINGS_MODULE"))

    response_html += "<ul>"
    for item in items:
        response_html += f"<li>{item.name} - {item.description} - Age: {item.age}</li>"
    response_html += "</ul>"

    return HttpResponse(response_html)