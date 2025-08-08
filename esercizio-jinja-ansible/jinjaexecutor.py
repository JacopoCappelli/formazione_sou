from jinja2 import Environment, FileSystemLoader

file_data = [
    {'domain': '@produzione'},
    {'domain': '@collaudo'},
    {'domain': '@sviluppo'},
]

env = Environment(loader=FileSystemLoader('/tmp'))
template = env.get_template('templates/jinja-conf.j2')

output=template.render(file=file_data)

with open('/etc/security/limits.conf', 'w') as f:
    f.write(output)

print("Template generato con successo:")
print(output)
