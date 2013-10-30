/home/{{ pillar['username'] }}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  file.managed:
    - source: salt://vespakoen/xfce/files/panel/xfce4-panel.xml
    - template: jinja
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 644
