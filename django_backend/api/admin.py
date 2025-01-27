from django.contrib import admin
from .models import addProduct, addIngredient, addCategory
# Register your models here.

admin.site.register(addProduct)
admin.site.register(addCategory)
admin.site.register(addIngredient)
