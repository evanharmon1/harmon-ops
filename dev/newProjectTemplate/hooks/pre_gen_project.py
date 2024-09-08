import random

def random_color():
    return "#{:06x}".format(random.randint(0, 0xFFFFFF))

# Set the generated color in the context
context = {
    "random_color": random_color()
}

with open("cookiecutter_context.json", "w") as f:
    f.write(f'{context}')
