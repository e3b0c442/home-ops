salt-master:
  pkg.latest:
    - name: salt-master
  service.running:
    - enable: True
    - require:
      - pkg: salt-master
    - listen:
      - file: /etc/salt/master

/etc/salt/master:
  file.managed:
    - mode: 640
    - source: salt://saltmaster/master.j2
    - template: jinja
    - defaults:
        user: {{ pillar['saltmaster']['gitfs-user'] }}
        password: {{ pillar['saltmaster']['gitfs-token'] }}

/etc/salt/gpgkeys:
  file.directory:
    - makedirs: True
    - dir_mode: 700

gpg.import_key:
  module.run:
    - user: salt
    - text: |-
{{ pillar['saltmaster']['gpg-priv-key'] | indent(width=8, indentfirst=True) }}

/etc/salt/pki/master:
  file.directory:
    - makedirs: True
    - dir_mode: 700

/etc/salt/pki/master/master.pem:
  file.managed:
    - mode: 400
    - source: salt://saltmaster/master.pem.j2
    - template: jinja
    - defaults:
        key: |-
{{ pillar['saltmaster']['master-priv-key'] | indent(width=12, indentfirst=True) }}

/etc/salt/pki/master/master.pub:
  file.managed:
    - mode: 644
    - source: salt://saltmaster/master.pub.j2
    - template: jinja
    - defaults:
        key: |-
{{ pillar['saltmaster']['master-pub-key'] | indent(width=12, indentfirst=True) }}