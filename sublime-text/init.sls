sublime-text:
  pkg.installed:
    - sources:
      - sublime-text: salt://vespakoen/sublime-text/files/sublime-text_build-3059_amd64.deb

wbond-package-manager:
  file.managed:
    - source: http://sublime.wbond.net/Package%20Control.sublime-package
    - source_hash: md5=ffc7adcb7190ae7c0b71eeeac063a746
    - name: /home/{{ pillar['username'] }}/.config/sublime-text-3/Installed Packages/Package Control.sublime-package
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

change-user-preferences:
  file.managed:
    - source: salt://vespakoen/sublime-text/files/Preferences.sublime-settings
    - name: /home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

change-keymap-preferences:
  file.managed:
    - source: salt://vespakoen/sublime-text/files/Default.sublime-keymap
    - name: /home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

{% for package, args in pillar.get('sublime-text', {}).get('packages', {}).iteritems() %}

# @todo FIXME Temp fix, git problems with space in path
rm -rf '/home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/{{ args.get('dir') }}':
  cmd.run

git clone -b {{ args.get('rev') }} {{ args.get('git') }} '/home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/{{ args.get('dir') }}':
  cmd.run:
    - user: {{ pillar['username'] }}

package-{{ package }}:
  git.latest:
    - name: {{ args.get('git') }}
    - rev: {{ args.get('rev') }}
    - target: '/home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/{{ args.get('dir') }}'
    - user: {{ pillar['username'] }}
    - submodules: true

{% for file, args in args.get('files', {}).iteritems() %}
/home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/{{ file }}:
  file.managed:
    - template: jinja
    - source: {{ args.get('source') }}
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
{% endfor %}
{% endfor %}

/home/{{ pillar['username'] }}/.config/sublime-text-3/Installed Packages/Sublimerge Pro.sublime-package:
  file.managed:
    - source: http://www.sublimerge.com/packages/ST3/2.6.0/Sublimerge%20Pro.sublime-package
    - source_hash: md5=61b8a49f005b2cdc17c9527161925f88
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

change-flatland-colors:
  cmd.run:
    - cwd: /home/{{ pillar['username'] }}/.config/sublime-text-3/Packages/Theme - Flatland/Flatland Dark
    - names:
      - convert \( file-close-selected.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:file-close-selected.png
      - convert \( fold.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:fold.png
      - convert \( fold-closed.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:fold-closed.png
      - convert \( fold-closed-pressed.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:fold-closed-pressed.png
      - convert \( group-closed.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:group-closed.png
      - convert \( group-open.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:group-open.png
      - convert \( icon-buffer-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-buffer-on.png
      - convert \( icon-case-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-case-on.png
      - convert \( icon-context-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-context-on.png
      - convert \( icon-highlight-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-highlight-on.png
      - convert \( icon-preserve-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-preserve-on.png
      - convert \( icon-regex-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-regex-on.png
      - convert \( icon-reverse-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-reverse-on.png
      - convert \( icon-selection-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-selection-on.png
      - convert \( icon-word-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-word-on.png
      - convert \( icon-wrap-on.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:icon-wrap-on.png
      - convert \( quick-panel-row-selected.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:quick-panel-row-selected.png
      - convert \( sidebar-row-selected.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:sidebar-row-selected.png
      - convert \( tab-dirty.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:tab-dirty.png
      - convert \( tab-dirty-active.png -alpha extract \) -background \#{{ pillar['color'] }} -alpha shape png32:tab-dirty-active.png
      - convert \( standard-scrollbar-corner.png -alpha extract \) -background \#383a3b -alpha shape png32:standard-scrollbar-corner.png
      - convert \( standard-scrollbar-corner.png -alpha extract \) -background \#383a3b -alpha shape png32:standard-scrollbar-corner.png
      - convert \( standard-scrollbar-horizontal.png -alpha extract \) -background \#383a3b -alpha shape png32:standard-scrollbar-horizontal.png
      - convert \( standard-scrollbar-vertical.png -alpha extract \) -background \#383a3b -alpha shape png32:standard-scrollbar-vertical.png
      - convert \( tabset-background.png -alpha extract \) -background \#2f3132 -alpha shape png32:tabset-background.png
      - convert \( status-bar-background.png -alpha extract \) -background \#383a3b -alpha shape png32:status-bar-background.png
      - convert \( tab-inactive.png -alpha extract \) -background \#2f3132 -alpha shape png32:tab-inactive.png
      - convert \( tab-hover.png -alpha extract \) -background \#2f3132 -alpha shape png32:tab-hover.png
      - convert \( tab-active.png \) -background \#363839 png32:tab-active.png
      - sed -i 's/49, 52 ,55/44, 46, 47/g' ../Flatland\ Dark.sublime-theme
      - sed -i 's/49, 52, 55/44, 46, 47/g' ../Flatland\ Dark.sublime-theme
      - sed -i 's/-5/2/g' ../Flatland\ Dark.sublime-theme
      - sed -i 's/0, 4, 0, 0/0, 0, 0, 0/g' ../Flatland\ Dark.sublime-theme
      - sed -i 's/0, 4, 0, 0/0, 0, 0, 0/g' ../Flatland\ Dark.sublime-theme
      - sed -i 's/ 34,/ 24,/g' ../Flatland\ Dark.sublime-theme
