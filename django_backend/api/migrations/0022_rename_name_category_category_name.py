# Generated by Django 5.1.5 on 2025-02-03 08:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0021_alter_unit_of_measurement_unit'),
    ]

    operations = [
        migrations.RenameField(
            model_name='category',
            old_name='name',
            new_name='category_name',
        ),
    ]
