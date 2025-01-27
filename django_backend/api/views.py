from rest_framework import generics
from .models import addProduct, addIngredient, addCategory
from .serializers import addProductSerializer, addIngredientSerializer, addCategorySerializer

class productGetCreate(generics.ListCreateAPIView):
    queryset = addProduct.objects.all()
    serializer_class = addProductSerializer

class productUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = addProduct.objects.all()
    serializer_class = addProductSerializer


class ingredientGetCreate(generics.ListCreateAPIView):
    queryset = addIngredient.objects.all()
    serializer_class = addIngredientSerializer

class ingredientUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = addIngredient.objects.all()
    serializer_class = addIngredientSerializer

class categoryGetCreate(generics.ListCreateAPIView):
    queryset = addCategory.objects.all()
    serializer_class = addCategorySerializer

class categoryUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = addCategory.objects.all()
    serializer_class = addCategorySerializer