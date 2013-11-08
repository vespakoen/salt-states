/usr/local/bin/manage-sublime-workspaces:
  file.managed:
    - source: salt://vespakoen/projects/files/manage-sublime-workspaces
    - template: jinja
    - mode: 755

manage-sublime-workspaces clear:
  cmd.run

{% for project, args in pillar.get('projects', {}).items() -%}
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
