# Generated by Django 5.1.5 on 2025-01-30 16:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0017_rename_with_ingredients_product_ingredients'),
    ]

    operations = [
        migrations.AlterField(
            model_name='employee',
            name='pin',
            field=models.CharField(editable=False, max_length=4, unique=True),
        ),
    ]
