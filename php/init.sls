include:
    - vespakoen.nginx

get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/local/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer

php:
    pkg.installed:
        - pkgs:
            - php5-fpm
            - php5-cli
        - require:
            - pkg: nginx
    service.running:
        - name: php5-fpm
        - enable: True
        - watch:
            - file: /etc/php5/conf.d/php.ini
            # - file: /etc/php5/conf.d/apc.ini
        - reload: True
        - require:
            - pkg: php

php-extras:
    pkg.installed:
        - pkgs: {{ pillar['php'].get('packages') }}

/etc/php5/conf.d/php.ini:
    file.managed:
        - source: salt://vespakoen/php/files/php.ini
        - require:
            - pkg: php
        - template: jinja

# /etc/php5/conf.d/apc.ini:
#     file.managed:
#         - source: salt://vespakoen/php/files/apc.ini
#         - require:
#             - pkg: php

{% for site, args in pillar.get('nginx').get('sites', {}).items() %}
{% if 'php' in args and args.php == True %}
/etc/php5/fpm/pool.d/{{ site }}.conf:
    file.managed:
        - source: salt://vespakoen/php/files/site.conf
        - template: jinja
        - context:
            site: {{ site }}
            args: {{ args }}
        - watch_in:
            - service: php
        - require:
            - pkg: php
{% else %}
/etc/php5/fpm/pool.d/{{ site }}.conf:
    file.absent:
        - require:
            - pkg: php
{% endif %}
{% endfor %}
