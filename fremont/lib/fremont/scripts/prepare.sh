#!/usr/bin/env bash

RED="\033[31m"
YELLOW="\033[33m"
CYAN="\033[36m"
NOCOLOR="\033[0;39m"

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

configure_firewall() {
  echo "${CYAN}Configuring the UFW firewall...${NORMAL}"
  echo ""

  ufw default deny incoming
  ufw default allow outgoing
  ufw allow OpenSSH
  ufw allow http
  ufw allow https
  ufw --force enable
}

install_fail2ban() {
  echo "${CYAN}Installing and configuring fail2ban...${NORMAL}"
  echo ""

  apt install fail2ban -y
  touch /etc/fail2ban/jail.local
  tee /etc/fail2ban/jail.local > /dev/null <<STRING
[DEFAULT]
bantime = 1d
findtime = 10m
maxretry = 5

[sshd]
enabled = true
STRING

  systemctl enable fail2ban
}

install_mollyguard() {
  echo "${CYAN}Installing molly-guard...${NORMAL}"
  echo ""

  apt install molly-guard
}

create_deploy_user() {
  echo "${CYAN}Creating the 'deploy' user...${NORMAL}"
  echo ""

  useradd deploy -s /bin/bash -m
  passwd -ld deploy
  rsync --archive --chown=deploy:deploy ~/.ssh /home/deploy
}

create_admin_user() {
  echo "${CYAN}Creating the 'admin' user...${NORMAL}"
  echo ""

  useradd admin -s /bin/bash -m
  passwd -ld admin
  rsync --archive --chown=admin:admin ~/.ssh /home/admin
}

elevate_admin_user_with_passwordless_sudo() {
  echo "${CYAN}Configuring passwordless sudo for the 'admin' user...${NORMAL}"
  echo ""

  sed "s/^%admin ALL=(ALL) ALL$/%admin $(cat /etc/hostname)=(root) NOPASSWD:ALL/" \
    /etc/sudoers > /tmp/sudoers.new

  if visudo -c -f /tmp/sudoers.new; then
    cp /tmp/sudoers.new /etc/sudoers

    sed -e 's/.*PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/.*PasswordAuthentication.*/PasswordAuthentication no/' \
        -i /etc/ssh/sshd_config
    systemctl restart ssh
    passwd -ld root
  else
    echo ""
    echo "${RED}${BOLD}Something went wrong while configuring passwordless sudo access for the admin user. Please rectify the issue and then lock down your root user.${NORMAL}"
    echo ""
  fi

  rm /tmp/sudoers.new
}


## Script execution starts here....

apt update && apt -y upgrade

configure_firewall
install_fail2ban
install_mollyguard
create_deploy_user
create_admin_user
elevate_admin_user_with_passwordless_sudo

reboot.no-molly-guard