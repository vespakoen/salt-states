/home/koen/.config/xfce4/terminal/terminalrc:
  file.managed:
    - source: salt://vespakoen/xfce/files/terminal/terminalrc
    - template: jinja
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 600
