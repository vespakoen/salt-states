openjdk-7-jdk:
  pkg.installed

add-elasticsearch-key:
  cmd.run:
    - name: wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

/etc/apt/sources.list.d/elasticsearch.list:
  file.managed:
    - source: salt://vespakoen/elasticsearch/files/elasticsearch.list
    - user: root
    - group: root

apt-get update:
  cmd.run

elasticsearch:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: elasticsearch
