install-dependencies:
  pkg.installed:
    - names:
      - librsvg2-bin
      - python-mako

clarity-icons:
  git.latest:
    - name: https://github.com/jcubic/Clarity.git
    - target: /home/{{ pillar['username'] }}/.icons/Clarity
    - user: {{ pillar['username'] }}

/home/{{ pillar['username'] }}/.icons/Clarity/src/template_vespakoen.svg:
  file.managed:
    - source: salt://vespakoen/theme/files/template_vespakoen.svg
    - template: mako

cd /home/{{ pillar['username'] }}/.icons/Clarity && ./configure && make vespakoen:
  cmd.run
