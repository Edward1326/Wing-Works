from django.urls import path
from .views import productGetCreate, productUpdateDelete, ingredientGetCreate, ingredientUpdateDelete, categoryGetCreate, categoryUpdateDelete

urlpatterns = [
    path('products/', productGetCreate.as_view(), name='product-list-create'),  
    path('products/<int:pk>/', productUpdateDelete.as_view(), name='product-update-delete'),  
    path('ingredients/', ingredientGetCreate.as_view(), name='ingredient-list-create'),  
    path('ingredients/<int:pk>/', ingredientUpdateDelete.as_view(), name='ingredient-update-delete'), 
    path('category/', categoryGetCreate.as_view(), name='ingredient-list-create'),  
    path('catogory/<int:pk>/', categoryUpdateDelete.as_view(), name='ingredient-update-delete'), 
]
