rm /home/{{ pillar['username'] }}/.marks/*:
  cmd.run

/usr/local/bin/manage-sublime-workspaces:
  file.managed:
    - source: salt://vespakoen/projects/files/manage-sublime-workspaces
    - template: jinja
    - mode: 755

manage-sublime-workspaces clear:
  cmd.run

{% for project, args in pillar.get('projects', {}).items() -%}
{{ args.get('path') }}:
  file.directory.present:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}


/usr/local/bin/browse-{{ project }}:
  file.managed:
    - source: salt://vespakoen/projects/files/browse
    - template: jinja
    - mode: 755
    - context:
      mark: {{ project }}

{{ args.get('git') }}:
  git.latest:
    - rev: {{ args.get('rev', 'master') }}
    - target: {{ args.get('path') }}
    - unless: [ -d {{ args.get('path') }} ]
    - user: {{ pillar['username'] }}
    - submodules: True

/home/{{ pillar['username'] }}/.marks/{{ project }}:
  file.symlink:
    - target: {{ args.get('path') }}
    - user: {{ pillar['username'] }}
    - makedirs: True

{% if(args.get('sublime', False)) %}
{{ args.get('sublime_path') }}/{{ project }}.sublime-project:
  file.managed:
    - source: salt://config/sublime/{{ args.get('sublime') }}
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - template: jinja

manage-sublime-workspaces add {{ args.get('sublime_path') }}/{{ project }}.sublime-workspace:
  cmd.run
{% endif %}

{% endfor %}
