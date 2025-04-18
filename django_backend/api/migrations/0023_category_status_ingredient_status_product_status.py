# Generated by Django 5.1.5 on 2025-02-03 08:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0022_rename_name_category_category_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='status',
            field=models.CharField(choices=[('active', 'Active'), ('inactive', 'Inactive')], default='ACTIVE', max_length=10),
        ),
        migrations.AddField(
            model_name='ingredient',
            name='status',
            field=models.CharField(choices=[('active', 'Active'), ('inactive', 'Inactive')], default='ACTIVE', max_length=10),
        ),
        migrations.AddField(
            model_name='product',
            name='status',
            field=models.CharField(choices=[('active', 'Active'), ('inactive', 'Inactive')], default='ACTIVE', max_length=10),
        ),
    ]
