from rest_framework import serializers
from .models import addProduct, addIngredient, addCategory

class addProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = addProduct
        fields = '__all__'

class addIngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = addIngredient
        fields = '__all__'

class addCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = addCategory
        fields = '__all__'