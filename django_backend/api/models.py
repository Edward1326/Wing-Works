from django.db import models
import random


#GLOBAL ------------------------------------------------------------------------------------------------------------------

class Person(models.Model):
    username = models.CharField(max_length=100)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    contact_number = models.CharField(max_length=15, null=True, blank=True)
    email_address = models.EmailField(max_length=100)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

#INVENTORY ---------------------------------------------------------------------------------------------------------------

class Unit_of_Measurement(models.Model):
    unit_name = models.CharField(max_length=100)
    unit = models.CharField(max_length=100, default = 'g')

    def __str__(self):
        return f"{self.unit}"

class Ingredient(models.Model):

    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default = 'ACTIVE')
    ingredient_name = models.CharField(max_length=100)
    unit_of_measurement = models.ForeignKey(Unit_of_Measurement, on_delete=models.CASCADE, blank=False, null=False)
    stock = models.PositiveIntegerField()
    minimum_stock = models.PositiveIntegerField()
    expiration_date = models.DateField()

    def __str__(self):
        return f"{self.ingredient_name}"
        
class Supplier(models.Model):

    supplier_name = models.CharField(max_length=100)
    contact_number = models.CharField(max_length=15, null=True, blank=True)
    email_address = models.CharField(max_length=100)
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE, blank=False, null=False)
    price_per_unit = models.DecimalField(max_digits=10, decimal_places=2)


    def __str__(self):
        return self.supplier_name

class Category(models.Model):

    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    
    CATEGORY_CHOICES = [
        ('e', 'Event'),
        ('s', 'Standard'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default = 'ACTIVE')
    category_name = models.CharField(max_length=100)
    category_type = models.CharField(max_length=10, choices=CATEGORY_CHOICES, default = 's')

    def __str__(self):
        return self.category_name


class Product(models.Model):

    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
    ]

    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default = 'ACTIVE')
    product_name = models.CharField(max_length=100)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, blank=False, null=False)
    ingredients = models.ManyToManyField(Ingredient)
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.product_name

#POS --------------------------------------------------------------------------------------------------------------------

class Order(models.Model):
    customer_name = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.customer_name} {self.id}"

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name="order_items")
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()

    def __str__(self):
        return f" {self.order.id}"

#EMPLOYEE ---------------------------------------------------------------------------------------------------------------

class AccessRights(models.Model):
    feature_name = models.CharField(max_length=100)

    def __str__(self):
        return self.feature_name

class Role(models.Model):
    role_name = models.CharField(max_length=100)
    role_type = models.CharField(max_length=100)

    def __str__(self):
        return self.role_name
    
class Employee(Person):
    employee_role = models.ForeignKey('Role', on_delete=models.CASCADE)
    pin = models.CharField(max_length=4, unique=True, editable=False)

    def save(self, *args, **kwargs):
        if not self.pin:  
            self.pin = self.generate_pin()
        super().save(*args, **kwargs)

    def generate_pin(self):
        return str(random.randint(1000, 9999))  

    def __str__(self):
        return f"{self.first_name} {self.last_name} | {self.employee_role.role_name}"


#BOOKING ---------------------------------------------------------------------------------------------------------------        

class Customer(Person):
    password = models.CharField(max_length=100)
    
    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class Booking(models.Model):

    BOOKING_STATUS = [
        ('s', 'Success'),
        ('c', 'Cancelled'),
        ('p', 'Pending'),
    ]
    PAYMENT_STATUS = [
        ('pp', 'Partially Paid'),
        ('fp', 'Fully Paid'),
        ('p', 'Pending'),
    ]

    head_count = models.PositiveIntegerField(default=0)
    booking_date = models.DateField()
    total_amount = models.PositiveIntegerField(default=0)
    location = models.CharField(max_length=100)
    payment_status = models.CharField(max_length=10, choices=PAYMENT_STATUS, default = 'p')
    booking_status = models.CharField(max_length=10, choices=BOOKING_STATUS, default = 'p')

    def __str__(self):
        return f"{self.location} | {self.booking_date}"