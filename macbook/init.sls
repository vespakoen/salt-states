map-cmd-to-ctrl:
  file.managed:
    - source: salt://vespakoen/macbook/files/.Xmodmap
    - name: /home/{{ pillar['username'] }}/.Xmodmap
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
