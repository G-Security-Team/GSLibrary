# Generated by Django 2.0 on 2021-07-17 06:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Gr33kLibrary', '0022_collect'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='update_time',
            field=models.DateTimeField(),
        ),
    ]
