/home/{{ pillar['username'] }}/.config/Thunar/uca.xml:
  file.managed:
    - source: salt://vespakoen/xfce/files/thunar/uca.xml
    - template: jinja
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 644
