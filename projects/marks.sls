rm /home/{{ pillar['username'] }}/.marks/*:
  cmd.run

{% for project, args in pillar.get('projects', {}).items() -%}
/home/{{ pillar['username'] }}/.marks/{{ project }}:
  file.symlink:
    - target: {{ args.get('path') }}
    - user: {{ pillar['username'] }}
    - makedirs: True
{% endif %}

{% endfor %}
