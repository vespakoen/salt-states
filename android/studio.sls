download-android-studio:
  file.managed:
    - source: http://dl.google.com/android/studio/android-studio-bundle-132.883541-linux.tgz
    - source_hash: md5=7a6f9b12b2cd5321ab0818b51306e01c
    - name: /tmp/android-studio.tgz

unpack-android-studio:
  cmd.run:
    - name: tar -zxvf /tmp/android-studio.tgz -C /usr/local/

symlink-android-studio-executable:
  cmd.run:
    - name: ln -s /usr/local/android-studio/bin/studio.sh /usr/local/bin/android-studio

openjdk-7-jdk:
  pkg.installed
