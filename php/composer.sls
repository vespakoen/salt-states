get-composer:
  cmd.run:
    - name: 'CURL=`which curl`; PHP=`/usr/bin/env php`; $CURL -sS https://getcomposer.org/installer | $PHP'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/

install-composer:
  cmd.wait:
    - name: mv /root/composer.phar /usr/local/bin/composer
    - cwd: /root/
    - watch:
      - cmd: get-composer
