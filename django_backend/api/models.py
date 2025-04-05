from django.db import models
import random

# GLOBAL ------------------------------------------------------------------------------------------------------------------

class Person(models.Model):
    username = models.CharField(max_length=100, unique=True)  
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    contact_number = models.CharField(max_length=15, null=True, blank=True)
    email_address = models.EmailField(max_length=100, unique=True) 

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

# INVENTORY ---------------------------------------------------------------------------------------------------------------

class Unit_of_Measurement(models.Model): 
    unit_name = models.CharField(max_length=100)
    unit = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.unit}"



class Supplier(models.Model):
    supplier_name = models.CharField(max_length=100)
    contact_number = models.CharField(max_length=15, null=True, blank=True)
    email_address = models.EmailField(max_length=100)  # EmailField ensures valid email format

    def __str__(self):
        return self.supplier_name

class Ingredient(models.Model):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active')
    ingredient_name = models.CharField(max_length=100)
    unit_of_measurement = models.ForeignKey('Unit_of_Measurement', on_delete=models.CASCADE)
    stock = models.DecimalField(max_digits=10, decimal_places=2)
    minimum_stock = models.DecimalField(max_digits=10, decimal_places=2)
    expiration_date = models.DateField(null=True, blank=True)
    
    suppliers = models.ManyToManyField(Supplier, through='SupplierIngredient')

    def __str__(self):
        return self.ingredient_name

class SupplierIngredient(models.Model):
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE)
    price_per_unit = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        unique_together = ('supplier', 'ingredient')  
    def __str__(self):
        return f"{self.supplier.supplier_name} supplies {self.ingredient.ingredient_name} at {self.price_per_unit}"
class Category(models.Model):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    CATEGORY_CHOICES = [
        ('event', 'Event'),
        ('standard', 'Standard'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active')
    category_name = models.CharField(max_length=100)
    category_type = models.CharField(max_length=10, choices=CATEGORY_CHOICES, default='standard')

    def __str__(self):
        return self.category_name

class Product(models.Model):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active')
    product_name = models.CharField(max_length=100)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    ingredients = models.ManyToManyField(Ingredient)
    cost = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)

    def __str__(self):
        return self.product_name

# POS --------------------------------------------------------------------------------------------------------------------

class Order(models.Model):
    customer_name = models.CharField(max_length=100, blank=True, null=True)  # Name can be added later


    def __str__(self):
        return f"Order {self.id} - {self.customer_name or 'Pending'}"  # Show 'Pending' if name is not set


class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name="order_items")
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    subtotal = models.DecimalField(max_digits=10, decimal_places=2, editable=False,  default=0.00)  # Auto-calculate

    def save(self, *args, **kwargs):
        self.subtotal = self.quantity * self.product.price  # Ensure 'Product' has a 'price' field
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Order {self.order.id} - {self.product.product_name} x {self.quantity}"

# EMPLOYEE ---------------------------------------------------------------------------------------------------------------

class AccessRights(models.Model):
    SUBSYSTEM_CHOICES = [
        ('create_order', 'Create Order'),
        ('orders_list', 'Orders List'),
        ('financial', 'Financial'),
        ('inventory', 'Inventory'),
        ('booking', 'Booking'),
        ('employee', 'Employee Management'),
    ]

    feature_name = models.CharField(max_length=100, choices=SUBSYSTEM_CHOICES, unique=True)

    def __str__(self):
        return self.get_feature_name_display()

class Role(models.Model):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active')
    role_name = models.CharField(max_length=100, unique=True)
    access_rights = models.ManyToManyField(AccessRights, blank=True)

    def __str__(self):
        return self.role_name

class Employee(Person):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active')
    employee_role = models.ForeignKey(Role, on_delete=models.CASCADE)
    pin = models.CharField(max_length=4, unique=True, editable=False)

    def save(self, *args, **kwargs):
        if not self.pin:
            self.pin = self.generate_unique_pin()
        super().save(*args, **kwargs)

    def generate_unique_pin(self):
        """Ensure PIN uniqueness."""
        while True:
            new_pin = str(random.randint(1000, 9999))
            if not Employee.objects.filter(pin=new_pin).exists():
                return new_pin

    def has_access(self, subsystem):
        """Check if employee has access to a given subsystem."""
        return self.employee_role.access_rights.filter(feature_name=subsystem).exists()

    def __str__(self):
        return f"{self.first_name} {self.last_name} | {self.employee_role.role_name}"

# BOOKING ---------------------------------------------------------------------------------------------------------------        

class Customer(Person):
    password = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class Booking(models.Model):
    BOOKING_STATUS = [
        ('S', 'Success'),
        ('C', 'Cancelled'),
        ('P', 'Pending'),
    ]
    PAYMENT_STATUS = [
        ('A', 'Partially Paid'),
        ('F', 'Fully Paid'),
        ('P', 'Pending'),
        ('R', 'Refunded'),
    ]

 
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True, blank=True)

    customer_name = models.CharField(max_length=200, null=True, blank=True)
    customer_email = models.EmailField(max_length=100, null=True, blank=True)
    customer_contact = models.CharField(max_length=15, null=True, blank=True)

    event_name = models.CharField(max_length=255)
    head_count = models.PositiveIntegerField(default=0)
    booking_date = models.DateField()
    total_amount = models.PositiveIntegerField(default=0)
    location = models.CharField(max_length=100)
    payment_status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default='P')
    booking_status = models.CharField(max_length=10, choices=BOOKING_STATUS, default='P')

    def __str__(self):
        return f"{self.event_name} | {self.location} | {self.booking_date}"


#FINANCIAL------------------------------------------------------------------------------------------
class Financial(models.Model):

    revenue = models.DecimalField(max_digits=10, decimal_places=2)
    expenses = models.DecimalField(max_digits=10, decimal_places=2)
    net_profit = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Financial Record"