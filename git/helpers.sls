shyaml:
  pip.installed

/usr/local/bin/gps:
  file.managed:
    - source: salt://vespakoen/git/files/gps
    - mode: 755
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

/usr/local/bin/gpd:
  file.managed:
    - source: salt://vespakoen/git/files/gpd
    - mode: 755
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
