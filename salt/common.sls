/etc/salt/minion:
  file.managed:
    - mode: 644
    - source: salt://minion

uptodate:
  pkg.uptodate:
    - refresh: True

git:
  pkg.latest
