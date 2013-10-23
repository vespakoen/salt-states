{% for user, args in pillar.get('users', {}).items() %}
oh-my-zsh-{{ user }}:
  git.latest:
    - name: https://github.com/robbyrussell/oh-my-zsh.git
    - target: /home/{{ user }}/.oh-my-zsh
    - rev: master
    - submodules: true

chown {{ user }}:{{ user }} /home/{{ user }}/.oh-my-zsh:
  cmd.run

/home/{{ user }}/.zshrc:
  file.managed:
    - source: salt://vespakoen/zsh/files/.zshrc
    - user: {{ user }}
    - group: {{ user }}
    - template: jinja
{% endfor %}

zsh:
  pkg.installed
