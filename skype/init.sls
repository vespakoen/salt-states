{% if grains['os'] == 'Ubuntu' %}
/etc/apt/sources.list.d/canonical.list:
  file.managed:
    - source: salt://vespakoen/skype/files/canonical.list
    - template: jinja
{% endif %}

skype:
  pkg.installed
