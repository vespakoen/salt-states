include:
    - vespakoen.php.composer

php:
    pkg.installed:
        - pkgs:
            - php5-cli

{% if(pillar.get('php', False).get('packages', False)) %}
php-extras:
    pkg.installed:
        - pkgs: {{ pillar['php'].get('packages', []) }}
{% endif %}

/etc/php5/conf.d/php.ini:
    file.managed:
        - source: salt://vespakoen/php/files/php.ini
        - require:
            - pkg: php
        - template: jinja

{% if('php-apc' in pillar.get('php').get('packages', [])) %}
/etc/php5/conf.d/20-apc.ini:
    file.managed:
        - source: salt://vespakoen/php/files/apc.ini
        - require:
            - pkg: php
{% endif %}

{% for site, args in pillar.get('nginx', {}).get('sites', {}).items() %}
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
