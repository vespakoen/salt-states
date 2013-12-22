/etc/default/apport:
  file.managed:
    - source: salt://vespakoen/xfce/files/apport/apport
    - template: jinja
