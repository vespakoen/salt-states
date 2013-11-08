{% for project, args in pillar.get('projects', {}).items() -%}
/usr/local/bin/browse-{{ project }}:
  file.managed:
    - source: salt://vespakoen/projects/files/browse
    - template: jinja
    - mode: 755
    - context:
      mark: {{ project }}
{% endfor %}
