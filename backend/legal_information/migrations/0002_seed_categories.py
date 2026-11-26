from django.db import migrations
from django.utils.text import slugify


CATEGORIES = [
    ("Family Law", "Divorce, custody, inheritance"),
    ("Criminal Law", "Offences and defence"),
    ("Property & Land Law", "Ownership, leases and land matters"),
    ("Business & Corporate", "Company formation and contracts"),
    ("Employment Law", "Workplace rights and employment contracts"),
    ("Civil Law", "Civil disputes and claims"),
    ("Immigration Law", "Visas and residency"),
    ("Consumer Rights", "Goods, services and refunds"),
]


def add_categories(apps, schema_editor):
    Category = apps.get_model("legal_information", "Category")
    for name, description in CATEGORIES:
        Category.objects.get_or_create(
            name=name,
            defaults={"slug": slugify(name), "description": description},
        )


class Migration(migrations.Migration):
    dependencies = [("legal_information", "0001_initial")]

    operations = [migrations.RunPython(add_categories, migrations.RunPython.noop)]
