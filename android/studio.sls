download-android-studio:
  file.managed:
    - source: http://developer.android.com/sdk/installing/linux-studio
    - source_hash: md5=7a6f9b12b2cd5321ab0818b51306e01c
    - name: /tmp/android-studio.tgz

unpack-android-studio:
  cmd.run:
    - name: tar -zxvf /tmp/android-studio.tgz -C /usr/local/android-studio

symlink-android-studio-executable:
  cmd.run:
    - name: ln -s /usr/local/android-studio/bin/studio.sh /usr/local/bin/android-studio
