{% for user, args in pillar.get('users', {}).items() %}
oh-my-zsh-{{ user }}:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: /home/{{ user }}/.oh-my-zsh
    - user: {{ user }}
    - submodules: true

/home/{{ user }}/.zshrc:
  file.managed:
    - source: salt://zsh/files/.zshrc
    - user: {{ user }}
    - group: {{ user }}
    - template: jinja
{% endfor %}

zsh:
  pkg.installed
