xmonad:
  pkg.installed

suckless-tools:
  pkg.installed

/home/{{ pillar['username'] }}/.xmonad/xmonad.hs:
  file.managed:
    - template: jinja
    - source: salt://vespakoen/xmonad/files/xmonad.hs
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

xmonad --recompile:
  cmd.run

xmonad --restart:
  cmd.run

{% if pillar.get('xubuntu', False) %}
autostart-xmonad:
  file.managed:
    - name: /home/{{ pillar['username'] }}/.config/autostart/xmonad.desktop
    - source: salt://vespakoen/macbook/files/xmonad.desktop
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
{% endif %}
