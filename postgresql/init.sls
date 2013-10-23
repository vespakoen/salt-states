#include:
#  - sysctl

postgresql:
  pkg:
    - installed
  file.managed:
    - name: /etc/postgresql/9.1/main/postgresql.conf
    - source: salt://postgresql/postgresql.conf
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql
  service.running:
    - enable: True
    - watch:
      - file: postgresql
      - file: postgresql-hba

postgresql-contrib:
  pkg:
    - installed

postgresql-hba:
  file.managed:
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql

{% for user, args in pillar.get('users', {}).items() %}
postgresql-user-{{ user }}:
{% if args.get('postgresql', False) %}
  postgres_user.present:
    - password: {{ args.get('password', '') }}
    - user: postgres
    - name: {{ user }}
    - password: {{ args.get('password') }}
    - require:
      - service: postgresql
{% else %}
  postgres_user.absent:
    - name: {{ user }}
{% endif %}
{% endfor %}


{% if pillar['postgresql'].get('databases', False) %}
{% for name in pillar['postgresql']['databases'] %}
postgresql-database-{{ name }}:
  postgres_database.present:
    - name: {{ name }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF-8
    - lc_collate: en_US.UTF-8
    - template: template0
    - owner: {{ name }}
    - user: postgres
    - require:
      - postgres_user: postgres-user-{{ name }}
{% endfor %}
{% endif %}
