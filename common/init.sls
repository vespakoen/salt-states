include:
  - system
  #- iptables
  - cron
  - users
  - tools
  - salt

common:
  pkg.installed:
    - pkgs:
      - build-essential
      - git-core
      - htop
