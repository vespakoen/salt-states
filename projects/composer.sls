{% for project, args in pillar.get('projects', {}).items() -%}
{% if(args.get('composer', False)) %}
composer-install-{{ project }}:
  cmd.run:
    - name: cd {{ args.get('path') }} && composer install
    - user: www-data
    - unless: [ -f {{ args.get('path') }}/composer.lock ]
{% endif %}
{% endfor %}
