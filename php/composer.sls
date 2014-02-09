get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; PHP=`which php`; $CURL -sS https://getcomposer.org/installer | $PHP'
    - unless: test -f /usr/local/bin/composer
    - cwd: /tmp/

install-composer:
  cmd.wait:
    - name: mv /tmp/composer.phar /usr/local/bin/composer
    - watch:
      - cmd: get-composer
