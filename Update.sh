#!/bin/bash

#docker pull empireproject/empire
#docker images -a
#docker run -ti empireproject/empire
#docker run -ti --entrypoint bash empireproject/empire 
#Create Persistent Storage
#docker create -v /opt/Empire --name data empireproject/empire
#docker run -ti --volumes-from data -p 10.0.0.207:80:80 empireproject/empire
#https://blog.obscuritylabs.com/docker-command-controll-c2/

# Global Variables
gitcmd=$(which git)
veildir=$(dirname ${0})

# Title Function
func_title(){
  # Clear (For Prettyness)
  clear

  # Print Title
  echo '================================================================'
  echo '               MonStream00 GIT Updater (Thanks Veil)            '
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
  if [ ! -d "metasploit-framework" ]; then
  	${gitcmd} clone https://github.com/rapid7/metasploit-framework.git
  	cd metasploit-framework
  	apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev openjdk-7-jre git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev curl zlib1g-dev libpq-dev libpcap-dev
  	bundle install
  	cd ..
  fi
  if [ ! -d "beef" ]; then
        sudo apt-get install build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion
        bash < <(curl -sk https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
        echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc

        source ~/.bashrc
        source $HOME/.rvm/scripts/rvm

        rvm install 2.1.5
        rvm use 2.1.5 --default

        echo "Downloading BeEF.."
        ${gitcmd} clone https://github.com/beefproject/beef.git
        cd beef

        echo "Installing Ruby Gems"
        ufw disable
        gem install bundler
        bundle install
        ufw enable
        cd ..
  fi
  if [ ! -d "chuckle" ]; then 
  	${gitcmd} clone https://github.com/nccgroup/chuckle
  fi
  if [ ! -d "VPNPivot" ]; then 
  	${gitcmd} clone https://github.com/0x36/VPNPivot.git
  fi
  if [ ! -d "social-engineer-toolkit" ]; then 
  	${gitcmd} clone https://github.com/trustedsec/social-engineer-toolkit.git
  fi
  if [ ! -d "Responder" ]; then 
  	${gitcmd} clone https://github.com/SpiderLabs/Responder.git
  fi
  if [ ! -d "dnscat2" ]; then 
  	${gitcmd} clone https://github.com/iagox86/dnscat2.git
  	apt-get install ruby-dev
  	cd dnscat2/server/
  	gem install bundler
  	bundle install
  fi
  if [ ! -d "impacket" ]; then
  	${gitcmd} clone https://github.com/CoreSecurity/impacket
  	cd impacket/examples
  	ln -s smbrelayx.py /usr/sbin/smbrelayx.py
  	cd ../..
  fi
  if [ ! -d "ZackAttack" ]; then
  	${gitcmd} clone https://github.com/urbanesec/ZackAttack.git
  fi
  if [ ! -d "Empire" ]; then
  	${gitcmd} clone https://github.com/EmpireProject/Empire.git
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
  if [ -d "Veil" ]; then
  	echo '[*] Updating Veil'
  	cd Veil && ${gitcmd} pull && ./Install.sh -u
  	cd ..
  fi
  if [ -d "dnscat2" ]; then
  	echo '[*] Updating dnscat2'
  	cd dnscat2 && ${gitcmd} pull 
  	cd ..
  fi
  if [ -d "Responder" ]; then
  	echo '[*] Updating Responder'
  	cd Responder && ${gitcmd} pull 
  	cd ..
  fi
  if [ -d "beef" ]; then
  	echo '[*] Updating beef'
  	cd beef && ${gitcmd} pull 
  	cd ..
  fi
  if [ -d "VPNPivot" ]; then
  	echo '[*] Updating VPNPivot'
  	cd VPNPivot && ${gitcmd} pull 
  	cd ..
  fi
  if [ -d "metasploit-framework" ]; then
  	echo ' [*] Updating Metasploit-Framework'
  	cd metasploit-framework && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "cortana-scripts" ]; then
  	echo ' [*] Updating Cortana Scripts'
  	cd cortana-scripts && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "ZackAttack" ]; then
  	echo ' [*] Updating ZackAttack'
  	cd ZackAttack && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "social-engineer-toolkit" ]; then
  	echo ' [*] Updating Social-Engineer-Toolkit'
  	cd social-engineer-toolkit && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "Empire" ]; then
  	echo '[*] Updating Empire'
  	cd Empire && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "chuckle" ]; then
  	echo '[*] Updating Chuckle'
  	cd chuckle && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "impacket" ]; then
  	echo '[*] Updating impacket'
  	cd impacket && ${gitcmd} pull
  	cd ..
  fi
  if [ -d "creepy" ]; then
  	echo '[*] Updating creepy'
  	cd creepy && ${gitcmd} pull
  	cd ..
  fi
  echo
  echo '[*] All Repos Cloned!'
}


# Select Function and Menu Statement
func_title
case ${1} in
  -i)
    echo
    func_install
    ;;
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
    echo '[Options].: -i = Clone Repos'
    echo '            -c = Clone Repos'
    echo '            -u = Update Repos'
    echo
esac
