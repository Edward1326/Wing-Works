from rest_framework import viewsets, permissions, status
from rest_framework.permissions import AllowAny
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.decorators import action, api_view, permission_classes
from .models import Product, Ingredient, Category, Booking, Employee, Role, Order, Financial, Supplier
from .serializers import (
    ProductSerializer, IngredientSerializer, CategorySerializer,
    BookingSerializer, RoleSerializer, EmployeeSerializer, FinancialSerializer, OrderSerializer, SupplierSerializer
)

# Roles --------------------------------------------------------------------------------------------
class RoleBasedPermission(permissions.BasePermission):
    def has_permission(self, request, view):
        user = request.user

        if not user.is_authenticated:
            return False

        try:
            employee = Employee.objects.get(username=user.username)
        except Employee.DoesNotExist:
            return False

        # ✅ Restrict API access at the main module level
        endpoint_map = {
            'create-order-main': 'create_order',
            'orders-list-main': 'orders_list',
            'financial-main': 'financial',
            'inventory-main': 'inventory',
            'booking-main': 'booking',
            'employee-main': 'employee',
        }

        required_permission = endpoint_map.get(view.basename)
        return required_permission and employee.has_access(required_permission)

# Product Management
class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [RoleBasedPermission] 

# Ingredient Management -----------------------------------------------------------------------
class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer
    permission_classes = [RoleBasedPermission]

@api_view(['GET'])
@permission_classes([AllowAny])
def get_ingredients(request):
    ingredients = Ingredient.objects.all()
    serializer = IngredientSerializer(ingredients, many=True)
    return Response(serializer.data)

# Category Management
class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [RoleBasedPermission]

# Order Management
class OrdersListViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer  
    permission_classes = [RoleBasedPermission]

# Booking Management ------------------------------------------------------------------------
class BookingViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer
    permission_classes = [RoleBasedPermission]

@api_view(['POST'])
@permission_classes([AllowAny])
def create_booking(request):
    serializer = BookingSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_bookings(request):
    bookings = Booking.objects.all()
    serializer = BookingSerializer(bookings, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_booking(request, booking_id):
    try:
        booking = Booking.objects.get(id=booking_id)
        serializer = BookingSerializer(booking)
        return Response(serializer.data)
    except Booking.DoesNotExist:
        return Response({"error": "Booking not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
@permission_classes([AllowAny])
def update_booking(request, booking_id):
    try:
        booking = Booking.objects.get(id=booking_id)
    except Booking.DoesNotExist:
        return Response({"error": "Booking not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = BookingSerializer(booking, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# ✅ Financial Management
class FinancialViewSet(viewsets.ModelViewSet):
    queryset = Financial.objects.all()  
    serializer_class = FinancialSerializer  
    permission_classes = [RoleBasedPermission]

# ✅ Inventory Management
class InventoryViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all() 
    serializer_class = ProductSerializer
    permission_classes = [RoleBasedPermission]
#Supplier ---------------------------------------------------------------------
@api_view(['POST'])
@permission_classes([AllowAny])
def create_supplier(request):
    serializer = SupplierSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_suppliers(request):
    suppliers = Supplier.objects.all()
    serializer = SupplierSerializer(suppliers, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_supplier(request, supplier_id):
    try:
        supplier = Supplier.objects.get(id=supplier_id)
        serializer = SupplierSerializer(supplier)
        return Response(serializer.data)
    except Supplier.DoesNotExist:
        return Response({"error": "Supplier not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
@permission_classes([AllowAny])
def edit_supplier(request, supplier_id):
    try:
        supplier = Supplier.objects.get(id=supplier_id)
    except Supplier.DoesNotExist:
        return Response({"error": "Supplier not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = SupplierSerializer(supplier, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# ✅ Employee ----------------------------------------------------------------
class EmployeeViewSet(viewsets.ModelViewSet):
    queryset = Employee.objects.all()
    serializer_class = EmployeeSerializer
    permission_classes = [RoleBasedPermission]

@api_view(['POST'])
@permission_classes([AllowAny])
def create_employee(request):
    serializer = EmployeeSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    print(serializer.errors)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_employees(request):
    employees = Employee.objects.all()
    serializer = EmployeeSerializer(employees, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_employee(request, employee_id):
    try:
        employee = Employee.objects.get(id=employee_id)
        serializer = EmployeeSerializer(employee)
        return Response(serializer.data)
    except Employee.DoesNotExist:
        return Response({"error": "Employee not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
@permission_classes([AllowAny])
def edit_employee(request, employee_id):
    try:
        employee = Employee.objects.get(id=employee_id)
    except Employee.DoesNotExist:
        return Response({"error": "Employee not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = EmployeeSerializer(employee, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


#Login --------------------------------------------------------------------
@api_view(['POST'])
def check_username(request):
    username = request.data.get('username')
    try:
        employee = Employee.objects.get(username=username)

        return Response({
            'exists': True,
            'status': employee.status
        })
    except Employee.DoesNotExist:
        return Response({'exists': False}, status=404)

@api_view(['POST'])
@permission_classes([AllowAny])
def verify_pin(request):
    username = request.data.get('username')
    pin = request.data.get('pin')
    try:
        employee = Employee.objects.get(username=username)
        if employee.pin == pin:
            return Response({
                'authenticated': True,
                'employee_id': employee.id,
                'role': employee.employee_role.role_name
            })
        return Response({'authenticated': False}, status=status.HTTP_401_UNAUTHORIZED)
    except Employee.DoesNotExist:
        return Response({'error': 'Employee not found'}, status=status.HTTP_404_NOT_FOUND)
    
# ✅ Role Management ----------------------------------------------------------
class RoleViewSet(viewsets.ModelViewSet):
    queryset = Role.objects.all()
    serializer_class = RoleSerializer
    permission_classes = [permissions.IsAuthenticated]

@api_view(['POST'])
@permission_classes([AllowAny])
def create_role(request):
    serializer = RoleSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    print(serializer.errors)  # 👈 add this
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_roles(request):
    roles = Role.objects.all()
    data = []

    for role in roles:
        employee_count = role.employee_set.count()  
        data.append({
            "id": role.id,
            "role_name": role.role_name,
            "employee_count": employee_count,
            "status": role.status,
        })

    return Response(data)

@api_view(['GET'])
@permission_classes([AllowAny])
def get_role(request, role_id):
    try:
        role = Role.objects.get(id=role_id)
        serializer = RoleSerializer(role)
        return Response(serializer.data)
    except Role.DoesNotExist:
        return Response({"error": "Role not found"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
@permission_classes([AllowAny])
def edit_role(request, role_id):
    try:
        role = Role.objects.get(id=role_id)
    except Role.DoesNotExist:
        return Response({"error": "Role not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = RoleSerializer(role, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CreateOrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()  
    serializer_class = OrderSerializer
    permission_classes = [RoleBasedPermission]