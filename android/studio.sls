download-android-studio:
  file.managed:
    - source: http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20130917.zip
    - source_hash: md5=2f7523d4eba9a8302c3c4a3955785e18
    - name: /tmp/android-studio.tgz

unpack-android-studio:
  cmd.run:
    - name: tar -zxvf /tmp/android-studio.tgz -C /usr/local/android-studio

symlink-android-studio-executable:
  cmd.run:
    - name: ln -s /usr/local/android-studio/bin/studio.sh /usr/local/bin/android-studio
