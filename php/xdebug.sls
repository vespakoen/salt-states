php5-xdebug:
  pkg.installed

/etc/php5/conf.d/xdebug.ini:
  file.managed:
    - source: salt://vespakoen/php/files/xdebug.ini
    - template: jinja
