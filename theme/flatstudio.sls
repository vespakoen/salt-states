get-flatstudio:
  file.managed:
    - source: salt://vespakoen/theme/files/FlatStudio-1.03.tar.gz
    - source_hash: md5=4a22cba22de2086b108bf8119473453f
    - name: /tmp/flatstudio.tar.gz

make-dot-themes-dir:
  file.directory.present:
    - name: /home/{{ pillar['username'] }}/.themes
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

unpack-flatstudio:
  cmd.run:
    - name: "/bin/tar -zxf /tmp/flatstudio.tar.gz -C /home/{{ pillar['username'] }}/.themes/"
    - user: {{ pillar['username'] }}
change-color:
  cmd.run:
    - names:
      - "find /home/{{ pillar['username'] }}/.themes/FlatStudio -type f -exec sed -i 's/#81d3d3/#{{ pillar['color'] }}/g' {} \\;"
      - "find /home/{{ pillar['username'] }}/.themes/FlatStudioDark -type f -exec sed -i 's/#4d679a/#{{ pillar['color'] }}/g' {} \\;"
      - "find /home/{{ pillar['username'] }}/.themes/FlatStudioDark -type f -exec sed -i 's/#E9E9E9/#{{ pillar['foreground_color'] }}/g' {} \\;"
      - "find /home/{{ pillar['username'] }}/.themes/FlatStudioDark -type f -exec sed -i 's/#e9e9e9/#{{ pillar['foreground_color'] }}/g' {} \\;"

{% if pillar.get('xubuntu', False) %}
xfconf-query -c xsettings -p /Net/ThemeName -s FlatStudioDark:
  cmd.run

xfconf-query -c xfce4-notifyd -p /theme -s FlatStudioDark:
  cmd.run
{% else %}
dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface gtk-theme FlatStudio:
  cmd.run
{% endif %}
