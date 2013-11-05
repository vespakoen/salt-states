install-rvm-and-ruby:
  cmd.run:
    - name: curl -L https://get.rvm.io | bash -s stable --ruby
    - user: {{ pillar['username'] }}

install-bundler:
  cmd.run:
    - name: rvm gemset use global && gem install bundler
    - user: {{ pillar['username'] }}
