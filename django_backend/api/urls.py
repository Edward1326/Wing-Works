<<<<<<< HEAD
from django.urls import path
from .views import productGetCreate, productUpdateDelete, ingredientGetCreate, ingredientUpdateDelete, categoryGetCreate, categoryUpdateDelete

urlpatterns = [
    path('products/', productGetCreate.as_view(), name='product-list-create'),  
    path('products/<int:pk>/', productUpdateDelete.as_view(), name='product-update-delete'),  
    path('ingredients/', ingredientGetCreate.as_view(), name='ingredient-list-create'),  
    path('ingredients/<int:pk>/', ingredientUpdateDelete.as_view(), name='ingredient-update-delete'), 
    path('category/', categoryGetCreate.as_view(), name='ingredient-list-create'),  
    path('catogory/<int:pk>/', categoryUpdateDelete.as_view(), name='ingredient-update-delete'), 
=======
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    BookingViewSet, 
    InventoryViewSet, 
    FinancialViewSet, 
    CreateOrderViewSet, 
    OrdersListViewSet, 
    EmployeeViewSet, 
    RoleViewSet,
    create_booking, get_bookings, update_booking, get_booking,
    create_role, get_roles, get_role, edit_role,
    create_employee, get_employees, get_employee, edit_employee,
    check_username, verify_pin,
    create_supplier, get_suppliers, get_supplier, edit_supplier,
    get_ingredients,
)

router = DefaultRouter()
router.register(r'orders-list-main', OrdersListViewSet, basename='orders_list')  
router.register(r'create-order-main', CreateOrderViewSet, basename='create_order')  
router.register(r'financial-main', FinancialViewSet, basename='financial')  
router.register(r'inventory-main', InventoryViewSet, basename='inventory')  
router.register(r'booking-main', BookingViewSet, basename='booking')  
router.register(r'employee-main', EmployeeViewSet, basename='employee')  
router.register(r'role', RoleViewSet, basename='role')   


urlpatterns = [
    path('', include(router.urls)),  

    path('auth/check-username/', check_username, name='check_username'),
    path('auth/verify-pin/', verify_pin, name='verify_pin'),

    path('bookings/create/', create_booking, name='create_booking'),  
    path('bookings/list/', get_bookings, name='get_bookings'),  
    path('bookings/update/<int:booking_id>/', update_booking, name='update_booking'), 
    path('bookings/<int:booking_id>/', get_booking, name='get_booking'),

    path('roles/create/', create_role, name='create_role'),
    path('roles/list/', get_roles, name='get_roles'), 
    path('roles/<int:role_id>/', get_role, name='get_role'),
    path('roles/edit/<int:role_id>/', edit_role, name='edit_role'),  

    path('employees/create/', create_employee, name='create_employee'),
    path('employees/list/', get_employees, name='get_employees'), 
    path('employees/<int:employee_id>/', get_employee, name='get_employee'),
    path('employees/edit/<int:employee_id>/', edit_employee, name='edit_employee'),

    path('suppliers/create/', create_supplier, name='create_supplier'),
    path('suppliers/list/', get_suppliers, name='get_suppliers'),
    path('suppliers/<int:supplier_id>/', get_supplier, name='get_supplier'),
    path('suppliers/edit/<int:supplier_id>/', edit_supplier, name='edit_supplier'),

    path('ingredients/list/', get_ingredients, name='get_ingredients'),
>>>>>>> recovered-files
]
