# Generated by Django 5.1.5 on 2025-03-24 03:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0032_financial_remove_supplier_ingredient_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='role',
            name='status',
            field=models.CharField(choices=[('active', 'Active'), ('inactive', 'Inactive')], default='active', max_length=10),
        ),
    ]
