from django.http import HttpResponse
from .models import TestModel


def index(request):
    # Fetch all records from the TestModel
    items = TestModel.objects.all()

    # Create a simple HTML response
    response_html = "<h1>Welcome to DJApp!</h1><p>Your Django server is running correctly.</p>"
    response_html += "<h2>Items in the Database:</h2><ul>"

    # Loop through the items and add them to the HTML response
    for item in items:
        response_html += f"<li>{item.name}</li>"

    response_html += "</ul>"

    return HttpResponse(response_html)