#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____  ____   __  ______  __    ______
   / __ \/  _/  / / / / __ \/ /   / ____/
  / /_/ // /___/ /_/ / / / / /   / __/   
 / ____// /___/ __  / /_/ / /___/ /___   
/_/   /___/  /_/ /_/\____/_____/_____/   
 
EOF
}
header_info
echo -e "Loading..."
APP="Pihole"
var_disk="10"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID="105"
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="192.168.1.105/24"
  GATE="192.168.1.1"
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="yes"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /etc/pihole ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP}"
set +e
pihole -up
msg_ok "Updated ${APP}"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}/admin${CL} \n"
