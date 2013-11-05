python-mysqldb:
  pkg:
    - installed

mysql-server-5.5:
  pkg:
    - installed
  service.running:
    - name: mysql
    - watch:
      - pkg: python-mysqldb
      - file: /etc/mysql/my.cnf

/etc/mysql/my.cnf:
  file:
    - managed
    - source: salt://vespakoen/mysql/files/my.cnf
    - template: jinja
    - mode: 644
    - require:
        - pkg: mysql-server-5.5
    - defaults:
        mysql_replication: {{ pillar['mysql'].get('replication') }}
        mysql_host_ip: {{ pillar['mysql'].get('bind-ip') }}

{%- for database, args in pillar['mysql'].get('databases', {}).iteritems() %}
{{ database }}_database:
  mysql_database.present:
    - name: {{ database }}
  mysql_user.present:
    - name: {{ args.get('user') }}
    - host: '%'
    - password_hash: "{{ args.get('password_hash') }}"
  mysql_grants.present:
    - database: {{ database }}.*
    - user: {{ args.get('user') }}
    - host: '%'
    - grant: ALL PRIVILEGES
  require:
    - pkg: python-mysqldb
    - service: mysql

{{ database }}_database_unicode:
  module.run:
    - name: mysql.query
    - database: mysql
    - query: "ALTER DATABASE {{ database }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

{#
{{ database }}_database_create:
  module.run:
    - name: mysql.query
    - database: {{ database }}
    - query: "CREATE DATABASE IF NOT EXISTS {{ database }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

{{ database }}_database_grants:
  module.run:
    - name: mysql.query
    - database: {{ database }}
    - query: "GRANT ALL PRIVILEGES ON {{ database }}.* TO {{ args.get('user') }} @'%' IDENTIFIED BY '{{ args.get('password') }}';"
#}
{%- endfor %}

{%- if pillar['mysql'].get('replication') %}
/etc/mysql/conf.d/mysqld_replication.cnf:
    file:
        - managed
        - source: salt://vespakoen/mysql/files/mysqld_replication.cnf
        - template: jinja
        - mode: 644
        - require:
            - pkg: mysql-server-5.5
        - defaults:
            mysql_replication_server_id: {{ pillar['mysql'].get('replication-server-id') }}
            mysql_replication_offset: {{ pillar['mysql'].get('replication-offset') }}
            mysql_replication_master_host: {{ pillar['mysql'].get('replication-master').get('host') }}
            mysql_replication_master_user: {{ pillar['mysql'].get('replication-master').get('user') }}
            mysql_replication_master_password: {{ pillar['mysql'].get('replication-master').get('password') }}

replication_user_create:
  module.run:
  - name: mysql.query
  - database: mysql
  - query: "INSERT INTO user (Host, User, Password, Select_priv, Reload_priv, Super_priv, Repl_slave_priv) VALUES ('{{ pillar['mysql'].get('replication-slave').get('host') }}', '{{ pillar['mysql'].get('replication-slave').get('user') }}', password('{{ pillar['mysql'].get('replication-slave').get('password') }}'), 'Y', 'Y', 'Y', 'Y'); FLUSH PRIVILEGES;"

{#
replication_refresh:
  module.run:
  - name: mysql.query
  - database: mysql
  - query: "stop slave; CHANGE MASTER TO MASTER_HOST='{{ pillar['mysql'].get('replication-master').get('host') }}', MASTER_USER='{{ pillar['mysql-replication-master']['user'] }}', MASTER_PASSWORD='{{ pillar['mysql-replication-master']['password'] }}'; start slave;"
#}
{%- endif %}
