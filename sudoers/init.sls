{% from "vespakoen/sudoers/package-map.jinja" import pkgs with context %}

sudo:
  pkg.installed:
    - name: {{ pkgs.sudo }}

/etc/sudoers:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - template: jinja
    - source: salt://vespakoen/sudoers/files/sudoers
    - context:
        included: False
    - require:
      - pkg: sudo
