# Generated by Django 2.1.7 on 2020-12-19 15:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Gr33kLibrary', '0016_article_read_num'),
    ]

    operations = [
        migrations.AddField(
            model_name='article',
            name='back_info',
            field=models.TextField(default=''),
        ),
    ]
