php:
    pkg.installed:
        - pkgs:
            - php5-cli

{% if(pillar.get('php', {}).get('packages', False)) %}
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

{% for site, args in pillar.get('sites', {}).items() %}
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

include:
    - vespakoen.php.composer
