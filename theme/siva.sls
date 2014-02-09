get-siva:
  file.managed:
    - source: http://fc07.deviantart.net/fs70/f/2013/057/9/0/siva_flat_1_3_0_by_nale12-d5ugpl4.zip
    - source_hash: md5=5f5b7f3a4e0d10ad01e94aedbb9daf84
    - name: /tmp/siva.zip

make-dot-themes-dir:
  file.directory.present:
    - name: /home/{{ pillar['username'] }}/.themes
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

unpack-siva:
  cmd.run:
    - name: "/usr/bin/unzip /tmp/siva.zip -d /home/{{ pillar['username'] }}/.themes/"
    - user: {{ pillar['username'] }}

change-color:
  cmd.run:
    - names:
      - "find /home/{{ pillar['username'] }}/.themes/Siva Flat Dark -type f -exec sed -i 's/#af3838/#{{ pillar['color'] }}/g' {} \\;"

{% if pillar.get('xubuntu', False) %}
xfconf-query -c xsettings -p /Net/ThemeName -s "Siva Flat Dark":
  cmd.run

xfconf-query -c xfce4-notifyd -p /theme -s "Siva Flat Dark":
  cmd.run
{% else %}
dbus-launch --exit-with-session gsettings set org.gnome.desktop.interface gtk-theme "Siva Flat Dark":
  cmd.run
{% endif %}
