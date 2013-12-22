/usr/local/bin/cs:
  file.managed:
    - source: salt://vespakoen/php/files/cs
    - mode: 755
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
