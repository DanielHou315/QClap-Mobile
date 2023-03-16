from django.db import models
from django.contrib.auth.models import User

import json
from django.core import serializers


MAX_DESC_LEN = 65535


class VideoMetadata(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    slate_number = models.IntegerField(default=1)

    # Production Information
    production_title = models.CharField(max_length=255)
    director = models.CharField(max_length=255)

    # Scene Information
    scene = models.CharField(max_length=255, default="1")
    shot = models.CharField(max_length=255, default="1")
    take = models.IntegerField(default=1)

    # Camera Info
    camera_number = models.IntegerField(default=1)
    camera_man = models.CharField(max_length=255)

    fps = models.FloatField(default=30.00)
    width = models.IntegerField(default=1920)
    height = models.IntegerField(default=1080)

    iso_speed = models.IntegerField(null=True, blank=True)
    focal_length = models.CharField(max_length=255, null=True, blank=True)
    lens = models.CharField(max_length=255, null=True, blank=True)

    date_time = models.DateTimeField(auto_now_add=True)

    @staticmethod
    def export_videometadata_as_json(id_in):
        try: 
            videometadata = VideoMetadata.objects.filter(id=id_in)
            json_data = serializers.serialize('json', videometadata)
            return json.loads(json_data)[0]['fields']
        except VideoMetadata.DoesNotExist:
            return {}
