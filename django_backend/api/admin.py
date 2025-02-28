from django.contrib import admin
from .models import *
# Register your models here.

#GLOBAL ------------------------------------------------------------------------------------------
admin.site.register(Person)

#INVENTORY ---------------------------------------------------------------------------------------
class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_name', 'category', 'cost', 'price', 'status')

admin.site.register(Product, ProductAdmin)

class CategoryAdmin(admin.ModelAdmin):
    list_display = ('category_name', 'category_type', 'status')

admin.site.register(Category, CategoryAdmin)


class UnitAdmin(admin.ModelAdmin):
    list_display = ('unit_name', 'unit')

admin.site.register(Unit_of_Measurement, UnitAdmin)


class IngredientAdmin(admin.ModelAdmin):
    list_display = ('ingredient_name','unit_of_measurement', 'stock_with_unit', 'minimum_stock', 'expiration_date', 'status')

    def stock_with_unit(self, obj):
        return f"{obj.stock} {obj.unit_of_measurement}"

    def minimum_stock(self, obj):
        return f"{obj.minimum_stock} {obj.unit_of_measurement}"

    stock_with_unit.short_description = 'Stock'  

admin.site.register(Ingredient, IngredientAdmin)

admin.site.register(Supplier)

#POS --------------------------------------------------------------------------------------------
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id','customer_name')

admin.site.register(Order, OrderAdmin)

class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('id','get_customer_name')

    def get_customer_name(self, obj):
        return obj.order.customer_name

admin.site.register(OrderItem, OrderItemAdmin)

#EMPLOYEE ---------------------------------------------------------------------------------------
class EmployeeAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'employee_role', 'pin') 
    readonly_fields = ('pin',) 

admin.site.register(Employee, EmployeeAdmin)

admin.site.register(Role)
admin.site.register(Customer)
admin.site.register(Booking)
