#!/bin/bash

# Global Variables
gitcmd=$(which git)
veildir=$(dirname ${0})

# Title Function
func_title(){
  # Clear (For Prettyness)
  clear

  # Print Title
  echo '================================================================'
  echo '               MonStream00 GIT Updater (Thanks Veil)                 '
  echo '================================================================'
}

# Veil Framework Clone Function
func_install(){
  func_title
  cd ${veildir}
  echo '[*] Cloning Repos'
  if [ ! -d "Veil" ]; then
  	${gitcmd} clone https://github.com/Veil-Framework/Veil
  	cd Veil && ./Install.sh -c
  	ln -s ~/GitHub/Veil/Veil-Evasion/Veil-Evasion.py /usr/sbin/veil-evasion
  	cd ..
  fi
  if [ ! -d "cortana-scripts" ]; then
  	${gitcmd} clone https://github.com/rsmudge/cortana-scripts
  fi
  if [ ! -d "chuckle" ]; then 
  	${gitcmd} clone https://github.com/nccgroup/chuckle
  fi
  if [ ! -d "impacket" ]; then
  	${gitcmd} clone https://github.com/CoreSecurity/impacket
  	cd impacket/examples
  	ln -s smbrelayx.py /usr/sbin/smbrelayx.py
  	cd ../..
  fi
  if [ ! -d "Empire" ]; then
  	${gitcmd} clone https://github.com/PowerShellEmpire/Empire
  	cd Empire/setup && ./install.sh
  	cd ..
  fi
  if [ ! -d "creepy" ]; then
	pip install -U pytz python-qt flickrapi python-instagram yapsy tweepy google-api-python-client python-dateutil configobj dominate
  	${gitcmd} clone https://github.com/ilektrojohn/creepy.git
  fi
  echo
  echo '[*] All Repos Cloned!'
}

# Veil Framework Clone Function
func_update(){
  func_title
  cd ${veildir}
  echo '[*] Updating Repos'
  echo '[*] Updating Veil'
  cd Veil && ${gitcmd} pull && ./Install.sh -u
  cd ..
  echo ' [*] Updating Cortana Scripts'
  cd cortana-scripts && ${gitcmd} pull
  cd ..
  echo '[*] Updating Empire'
  cd Empire && ${gitcmd} pull
  cd ..
  echo '[*] Updating Chuckle'
  cd chuckle && ${gitcmd} pull
  cd ..
  echo '[*] Updating impacket'
  cd impacket && ${gitcmd} pull
  cd ..
  echo '[*] Updating creepy'
  cd creepy && ${gitcmd} pull
  cd ..
  echo
  echo '[*] All Repos Cloned!'
}


# Select Function and Menu Statement
func_title
case ${1} in
  -c)
    echo
    func_install
    ;;
  -u)
    echo
    func_update
    ;;
  *)
    echo
    echo "[Usage]...: ${0} [OPTION]"
    echo '[Options].: -c = Clone Repos'
    echo '            -u = Update Repos'
    echo
esac
