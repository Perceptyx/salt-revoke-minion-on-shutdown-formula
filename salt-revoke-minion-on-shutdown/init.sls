remove-minion-on-shutdown-service:
  service.enabled:
    - name: remove_minion_on_shutdown
    - enable: True
    - watch:
      - /etc/systemd/system/remove_minion_on_shutdown.service

/etc/systemd/system/remove_minion_on_shutdown.service:
  file.managed:
    - contents: |
        [Unit]
        Description=Removing salt key minion from master on shutdown

        [Service]
        Type=oneshot
        RemainAfterExit=true
        ExecStop=/usr/bin/salt-call saltutil.revoke_auth

        [Install]
        WantedBy=multi-user.target

systemctl daemon-reload:
  cmd.run
