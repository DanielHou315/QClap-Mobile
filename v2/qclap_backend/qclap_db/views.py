from django.shortcuts import render

from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from .models import VideoMetadata
from .lib import *


def ping(request):
    return JsonResponse({"message": "pong"}, status=200)

@csrf_exempt
def create_video_metadata(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        if not username or not password:
            return HttpResponseBadRequest("username and password are required", status=400)

        user = authenticate(username=username, password=password)
        if user is None:
            return HttpResponseBadRequest("Wrong username or Password", status=401)

        # try:
        metadata = VideoMetadata(
            slate_number=request.POST.get('slate_number', 0),
            production_title=request.POST.get('production_title', '<Title>'),
            director=request.POST.get('director', '<Director>'),
            scene=request.POST.get('scene', '0'),
            shot=request.POST.get('shot', '0'),
            take=request.POST.get('take', 0),
            camera_number=request.POST.get('camera_number', 0),
            camera_man=request.POST.get('camera_man', '<CameraMan>'),
            fps=request.POST.get('fps', 30.00),
            width=request.POST.get('width', 1920),
            height=request.POST.get('height', 1080),
            iso_speed=request.POST.get('iso_speed', None),
            focal_length=request.POST.get('focal_length', None),
            lens=request.POST.get('lens', None),
            user=user,
        )
        metadata.save()
        return JsonResponse({"metadata_url": read_root_url() + "api/v1/vm/" + str(metadata.id) + "/"}, status=201)
        # except Exception:
        #     return HttpResponseBadRequest("Error creating VideoMetadata", status=422)
    else:
        return HttpResponseBadRequest("Only POST requests are allowed", status=405)



@csrf_exempt
def get_video_metadata(request, id):
    if request.method == 'GET':
        
        username = request.GET.get('username')
        password = request.GET.get('password')
        print(username)
        print(password)
        if not username or not password:
            return HttpResponseBadRequest("username and password are required", status=400)

        user = authenticate(username=username, password=password)
        if not user:
            return HttpResponsBadRequest("Wrong username or Password", status=401)

        # get video metadata instance
        try:
            video_metadata = VideoMetadata.objects.get(id=id, user=user)
        except VideoMetadata.DoesNotExist:
            return JsonResponse({'error': 'Video metadata not found'}, status=404)

        # return JSON representation of video metadata instance
        return JsonResponse(VideoMetadata.export_videometadata_as_json(video_metadata.id), status=200, safe=False)
    else:
        return HttpResponseBadRequest("Only GET requests are allowed", status=405)


@csrf_exempt
def get_video_metadata_list(request):
    if request.method == 'GET':
        username = request.GET.get('username')
        password = request.GET.get('password')
        if not username or not password:
            return HttpResponseBadRequest("username and password are required", status=400)

        user = authenticate(username=username, password=password)
        if not user:
            return HttpResponseBadRequest("Wrong username or Password", status=401)
    
        # Get the list of metadata IDs that belong to the authenticated user
        videometadata_list = VideoMetadata.objects.filter(user=user).values_list('id', flat=True)

        return JsonResponse({'id_list': list(videometadata_list)}, status=200)
    else:
        return HttpResponseBadRequest("Only GET requests are allowed", status=405)
    
