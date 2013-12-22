{% for project, args in pillar.get('projects', {}).items() -%}
make-browse-symlink-for-{{ project }}:
  file.managed:
    - name: /usr/local/bin/browse-{{ project }}
    - source: salt://vespakoen/projects/files/browse
    - template: jinja
    - mode: 755
    - context:
      mark: {{ project }}
{% endfor %}
