sshconfig:
  file.managed:
    - name: /home/{{ pillar['user'] }}/.ssh/config
    - mode: 600
    - user: {{ pillar['user'] }}
    - group: {{ pillar['user'] }}
    - template: jinja
    - source: salt://vespakoen/git/ssh_config

{% for name, key in pillar.get('deploy_keys', {}).iteritems() %}
deploy-key-{{ name }}:
  file.managed:
    - name: /home/{{ pillar['user'] }}/.ssh/{{ name }}_rsa
    - source: salt://vespakoen/git/key
    - template: jinja
    - defaults:
        key: {{ name }}
    - mode: 600
    - user: {{ pillar['user'] }}
    - group: {{ pillar['user'] }}
{% endfor %}
