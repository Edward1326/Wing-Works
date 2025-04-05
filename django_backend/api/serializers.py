from rest_framework import serializers
from .models import Product, Ingredient, Category, Booking, Employee, Role, AccessRights, Financial, Order, OrderItem, Supplier

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class IngredientSerializer(serializers.ModelSerializer):
    unit_of_measurement = serializers.StringRelatedField()

    class Meta:
        model = Ingredient
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'

class AccessRightsSerializer(serializers.ModelSerializer):
    class Meta:
        model = AccessRights
        fields = '__all__'


class SupplierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplier
        fields = '__all__'


class RoleSerializer(serializers.ModelSerializer):
    access_rights = serializers.SlugRelatedField(
        slug_field='feature_name',
        queryset=AccessRights.objects.all(),
        many=True
    )

    class Meta:
        model = Role
        fields = ['id', 'role_name', 'status', 'access_rights']
        
class EmployeeSerializer(serializers.ModelSerializer):
    employee_role = serializers.SlugRelatedField(
        slug_field='role_name',  # Accept role_name as string
        queryset=Role.objects.all()
    )

    class Meta:
        model = Employee
        fields = '__all__'
        
class FinancialSerializer(serializers.ModelSerializer):
    class Meta:
        model = Financial
        fields = '__all__'


class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = '__all__'
