#!/bin/bash
systemctl enable watchdog-internet

chmod +x /usr/share/watchdog-internet/*  2>/dev/null || true