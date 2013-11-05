applications:
    pkg.installed:
      - names:
        - xubuntu-desktop
        - ubuntu-restricted-extras
        - libavformat-extra-53
        - libavcodec-extra-53
        - chromium-browser
        - chromium-codecs-ffmpeg
        - chromium-codecs-ffmpeg-extra
        - python-virtualenv
        - build-essential
        - git-core
        - git-flow
        - htop
        - imagemagick
        - openssh-server
        - vlc
        - wine
        - tree
        - gnome-font-viewer
        - keepassx
        - gparted
        - php5-cli
        - parcellite

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - :
    cmd.run

echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list:
    cmd.run:
        unless: [ -f /etc/apt/sources.list.d/google.list ]

google-chrome-beta:
    pkg.installed
