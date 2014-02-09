php-apc:
    pkg.installed

/etc/php5/conf.d/20-apc.ini:
    file.managed:
        - source: salt://vespakoen/php/files/apc.ini
        - require:
            - pkg: php
