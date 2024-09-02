from django.db import models

class TestModel(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    age = models.IntegerField(null=True, blank=True)  # New field added

    def __str__(self):
        return self.name
