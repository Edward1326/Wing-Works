# Generated by Django 5.1.5 on 2025-01-23 09:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_addingredient_addproduct_delete_product'),
    ]

    operations = [
        migrations.CreateModel(
            name='addCategory',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('category_type', models.CharField(choices=[('e', 'Event'), ('s', 'Standard')], default='s', max_length=10)),
            ],
        ),
    ]
