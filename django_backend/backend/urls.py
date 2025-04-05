"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
<<<<<<< HEAD

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('api.urls')),
]
=======
from rest_framework.authtoken.views import obtain_auth_token
from django.http import JsonResponse

# Create a simple homepage response
def homepage(request):
    return JsonResponse({
        "message": "Welcome to Wing Works API!",
        "endpoints": {
            "Admin Panel": "/admin/",
            "API Root": "/api/",
            "Auth Token": "/api/auth/",
            "Bookings": {
                "Create Booking": "/api/bookings/create/",
                "List Bookings": "/api/bookings/list/"
            },
            "Products": "/api/products/",
            "Ingredients": "/api/ingredients/",
            "Categories": "/api/categories/",
            "Users": "/api/users/"
        }
    })

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # Include API endpoints
    path('api/auth/', obtain_auth_token),  # Authentication API (Login)
    path('', homepage),  # Default API homepage
]


>>>>>>> recovered-files
