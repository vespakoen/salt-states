{% for project, args in pillar.get('projects', {}).items() -%}
{{ args.get('path') }}:
  file.directory.present:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

{{ args.get('git') }}:
  git.latest:
    - rev: {{ args.get('rev', 'master') }}
    - target: {{ args.get('path') }}
    - unless: [ -d {{ args.get('path') }} ]
    - user: {{ pillar['username'] }}

/home/{{ pillar['username'] }}/.marks/{{ project }}:
  file.symlink:
    - target: {{ args.get('path') }}
    - user: {{ pillar['username'] }}
    - makedirs: True

{% endfor %}