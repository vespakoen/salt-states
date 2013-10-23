# # refresh databases
# {% if pillar['postgresql'].get('spatial_databases', False) %}
# {% for name in pillar['postgresql']['spatial_databases'] %}
# remove-postgresql-spatial-database-{{ name }}:
#   postgres_database.absent:
#     - name: {{ name }}
#     - user: postgres

# add-postgresql-spatial-database-{{ name }}:
#   postgres_database.present:
#     - name: {{ name }}
#     - encoding: UTF8
#     - lc_ctype: en_US.UTF-8
#     - lc_collate: en_US.UTF-8
#     - template: template_postgis
#     - owner: {{ name }}
#     - user: postgres
# {% endfor %}
# {% endif %}
# {% if pillar['postgresql'].get('databases', False) %}
# {% for name in pillar['postgresql']['databases'] %}
# remove-postgresql-database-{{ name }}:
#   postgres_database.absent:
#     - name: {{ name }}
#     - user: postgres

# add-postgresql-database-{{ name }}:
#   postgres_database.present:
#     - name: {{ name }}
#     - encoding: UTF8
#     - lc_ctype: en_US.UTF-8
#     - lc_collate: en_US.UTF-8
#     - template: template0
#     - owner: {{ name }}
#     - user: postgres
# {% endfor %}
# {% endif %}

# add-hstore-extension:
#   cmd.run:
#     - name: psql -U postgres -d trapps -c "CREATE EXTENSION hstore"
#     - user: postgres
init-app:
  cmd.run:
    - name: cd /home/azion/ivizi/app && php artisan migrate:install --env=development && php artisan migrate:run --env=development
    - user: www-data

# /tmp/truncate-trapps-db.sql:
#   file.managed:
#     - source: salt://trapps/files/truncate-trapps-db.sql
#   cmd.run:
#     - name: psql -U postgres -d trapps < /tmp/truncate-trapps-db.sql
#     - user: postgres

# update-data-dump:
#   cmd.run:
#     - name: cd /home/trapps/data && git pull
#     - user: trapps

# init-db:
#   cmd.run:
#     - name: psql -U postgres -d trapps < /home/trapps/data/dump.sql
#     - user: postgres
