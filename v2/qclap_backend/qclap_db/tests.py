from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.test import APITestCase

from .models import VideoMetadata
# from .views import *
# from .urls import *
from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User

import json


class VideoMetadataTestCase(APITestCase):
    def setUp(self):
        self.client = Client()
        self.user = User.objects.create(
            username='test@example.com',
            password=make_password('Hhd19293949')
        )
        self.user.save()

        try:
            logged_in = self.client.login(username='test@example.com', password='Hhd19293949')
        except Exception as e:
            print('Exception raised during authentication:', e)
        else:
            if logged_in:
                print('Authentication succeeded')
            else:
                print('Authentication failed')


        self.video_metadata = VideoMetadata.objects.create(
            production_title='Test Production',
            director='John Doe',
            scene='1',
            shot='1',
            take=1,
            camera_man='Jane Doe',
            fps=30.0,
            width=1920,
            height=1080,
            user=self.user
        )
        self.video_metadata_id = self.video_metadata.id
        self.url_create = reverse('create_video_metadata')
        self.url_get = reverse('get_video_metadata', kwargs={'id': self.video_metadata_id})
        self.url_list = reverse('get_video_metadata_list')

    def test_create_video_metadata(self):
        self.client.login(username=self.user.username, password='Hhd19293949')
        data = {
            'username': 'test@example.com',
            'password': 'Hhd19293949',
            'slate_number': 1,
            'production_title': 'Test Production 2',
            'director': 'Jane Doe',
            'scene': '1',
            'shot': '2',
            'take': 2,
            'camera_number': 1,
            'camera_man': 'John Doe',
            'fps': 24.0,
            'width': 1280,
            'height': 720
        }
        response = self.client.post(self.url_create, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(VideoMetadata.objects.count(), 2)

    def test_get_video_metadata(self):
        self.client.login(username=self.user.username, password='Hhd19293949')
        query_params = {
            'username': 'test@example.com',
            'password': 'Hhd19293949'
        }
        response = self.client.get(self.url_get, query_params, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = json.loads(response.content)
        self.assertEqual(data['production_title'], 'Test Production')
        self.assertEqual(data['director'], 'John Doe')




    def test_get_video_metadata_list_authenticated(self):
        # Authenticate user
        self.client.login(username='test@example.com', password='Hhd19293949')
        query_params = {
            'username': 'test@example.com',
            'password': 'Hhd19293949'
        }
        # Make GET request to get the list of metadata IDs
        response = self.client.get(self.url_list, query_params, format='json')

        # Verify response status code and content
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        data = response.content
        self.assertJSONEqual(response.content, {'id_list': [self.video_metadata.id]})




    def test_get_video_metadata_list_unauthenticated(self):
        # Make GET request to get the list of metadata IDs
        query_params = {
            'username': 'test@example.com',
            'password': 'Hhd19299'
        }
        # Make GET request to get the list of metadata IDs
        response = self.client.get(self.url_list, query_params, format='json')

        # Verify response status code and content
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
