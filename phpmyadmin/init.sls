include:
    - vespakoen.mysql
    - vespakoen.nginx
    - vespakoen.php

phpmyadmin:
    pkg:
        - installed
    require:
        - pkg: mysql
        - pkg: php
