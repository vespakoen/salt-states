openjdk-7-jre-headless:
  pkg.installed

smartgit:
  pkg.installed:
    - sources:
      - smartgit: salt://vespakoen/smartgit/files/smartgithg-5-rc-3.deb
