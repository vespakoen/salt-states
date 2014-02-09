/usr/local/bin/manage-sublime-workspaces:
  file.managed:
    - source: salt://vespakoen/projects/files/manage-sublime-workspaces
    - template: jinja
    - mode: 755

{% if(pillar.get('sublime-text', {}).get('projects', False)) %}
manage-sublime-workspaces clear:
  cmd.run
{% endif %}

{% for project, args in pillar.get('sublime-text', {}).get('projects', {}).iteritems() -%}
{{ args.get('target') }}:
  file.managed:
    - source: {{ args.get('source') }}
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - template: jinja

manage-sublime-workspaces add {{ args.get('target', '').replace('.sublime-project', '.sublime-workspace') }}:
  cmd.run
{% endfor %}
