#!/bin/bash

# Copy the new cert files to the known location
cp /etc/letsencrypt/live/ourparadisefalls.com/fullchain.pem /opt/tplink/EAPController/cert/tls.crt
cp /etc/letsencrypt/live/ourparadisefalls.com/privkey.pem /opt/tplink/EAPController/cert/tls.key

# Restart the Omada Controller
systemctl restart omada-controller