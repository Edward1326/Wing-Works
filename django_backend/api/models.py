from django.db import models

class addProduct(models.Model):
    INGREDIENT_CHOICES = [
        ('with', 'With Ingredients'),
        ('without', 'Without Ingredients'),
    ]

    name = models.CharField(max_length=100)
    category = models.CharField(max_length=100)
    with_ingredients = models.CharField(max_length=10, choices=INGREDIENT_CHOICES, default = 'with')
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField()
    minimum_stock = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.name

class addIngredient(models.Model):
    UNIT_CHOICES = [
        ('kg', 'Kilogram'),
        ('g', 'Gram'),
        ('l', 'Liter'),
        ('ml', 'Milliliter'),
        ('pcs', 'Pieces'),
    ]
    SUPPLIER_CHOICES = [
        ('with', 'With Supplier'),
        ('without', 'Without Supplier'),
    ]

    name = models.CharField(max_length=100)
    unit = models.CharField(max_length=10, choices=UNIT_CHOICES, default = 'pcs')
    stock = models.PositiveIntegerField()
    minimum_stock = models.PositiveIntegerField()
    with_supplier = models.CharField(max_length=10, choices=SUPPLIER_CHOICES, default = 'with')
    supplier_name = models.CharField(max_length=100)
    contact_number = models.CharField(max_length=15, null=True, blank=True)
    email_address = models.CharField(max_length=100)
    price_per_unit = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.name


class addCategory(models.Model):
    CATEGORY_CHOICES = [
        ('e', 'Event'),
        ('s', 'Standard'),
    ]

    name = models.CharField(max_length=100)
    category_type = models.CharField(max_length=10, choices=CATEGORY_CHOICES, default = 's')

    def __str__(self):
        return self.name