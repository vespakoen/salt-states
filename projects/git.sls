{% for project, args in pillar.get('projects', {}).items() -%}
{{ args.get('path') }}:
  file.directory.present:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

ensure-latest-{{args.get('git')}}:
  git.latest:
    - name: {{ args.get('git') }}
    - rev: {{ args.get('rev', 'master') }}
    - target: {{ args.get('path') }}
    - unless: [ -d {{ args.get('path') }} ]
    - user: {{ args.get('user', pillar['username']) }}
    - submodules: True
{% endfor %}
