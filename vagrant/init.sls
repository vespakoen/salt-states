install-vagrant:
  pkg.installed:
    - name: vagrant
    - sources:
      - vagrant: salt://vespakoen/vagrant/files/vagrant_1.3.5_x86_64.deb

  cmd.run:
    - name: vagrant plugin install vagrant-salt
    - unless: vagrant plugin list | grep vagrant-salt | wc -l
