# Generated by Django 5.1.5 on 2025-02-03 06:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0018_alter_employee_pin'),
    ]

    operations = [
        migrations.RenameField(
            model_name='product',
            old_name='name',
            new_name='product_name',
        ),
    ]
