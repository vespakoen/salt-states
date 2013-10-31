/home/{{ pillar['username'] }}/.gitconfig:
  file.managed:
    - source: salt://vespakoen/git/files/.gitconfig
    - mode: 644
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
