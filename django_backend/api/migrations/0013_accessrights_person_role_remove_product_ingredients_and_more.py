# Generated by Django 5.1.5 on 2025-01-30 14:18

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_remove_product_minimum_stock_remove_product_stock'),
    ]

    operations = [
        migrations.CreateModel(
            name='AccessRights',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('feature_name', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Person',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=100)),
                ('first_name', models.CharField(max_length=100)),
                ('last_name', models.CharField(max_length=100)),
                ('contact_number', models.CharField(blank=True, max_length=15, null=True)),
                ('email_address', models.EmailField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Role',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('role_name', models.CharField(max_length=100)),
                ('role_type', models.CharField(max_length=100)),
            ],
        ),
        migrations.RemoveField(
            model_name='product',
            name='ingredients',
        ),
        migrations.AddField(
            model_name='product',
            name='minimum_stock',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AddField(
            model_name='product',
            name='stock',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='ingredient',
            name='expiration_date',
            field=models.DateField(),
        ),
        migrations.CreateModel(
            name='Employee',
            fields=[
                ('person_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='api.person')),
                ('pin', models.CharField(max_length=5)),
                ('employee_role', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.role')),
            ],
            bases=('api.person',),
        ),
        migrations.DeleteModel(
            name='ProductIngredient',
        ),
    ]
