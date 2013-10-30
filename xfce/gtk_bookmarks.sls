/home/{{ pillar['username'] }}/.config/gtk-3.0/bookmarks:
  file.managed:
    - source: salt://vespakoen/xfce/files/gtk/bookmarks
    - template: jinja
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 644
