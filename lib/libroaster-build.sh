# This file is part of the Roaster project 
# https://github.com/dmedri/roaster/
# Copyright (c) 2019-2020 Daniele Medri.
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>.                                


# Libraries
source lib/build/virtualenv.sh
source lib/build/standard.sh
source lib/build/server.sh
source lib/build/ccache.sh
source lib/libroaster-rprofile.sh
source lib/libroaster-svn.sh
source lib/libroaster-web.sh

# 
# Build: init actions to start the task
# call: R-build-init
#
function R-build-init {
        log "Building R ($RBTYPE - $BTYPE)"

	# Evaluate OS for needed actions
	os-info-retrieve

	# Action on RBTYPE
	if [[ $RBTYPE = "stable" ]]; then
		web-file-fetch-stable
        elif [[ $RBTYPE = "branch" ]]; then
                svn-repo-fetch-branch $VERLATEST
        elif [[ $RBTYPE = "trunk" ]]; then
                svn-repo-fetch-trunk
        fi
}

# 
# Build: show build options
# call: R-build-ask
#
function R-build-ask {
        echo -e "\nInstalling R (\e[32m$RBTYPE\e[0m).\n"
        echo -e "Summary:"
        echo -e "\t\e[32m$BTYPE\e[0m"
        echo -e "\t\e[32m$BOPTS\e[0m\n"
        echo -e "Log type:"
        if [[ $LOG = "file" ]]; then
                echo -e "\t\e[32m$LOG $RCO/logs/$$.build\e[0m\n"
        else
                echo -e "\t\e[32m$LOG\e[0m\n"
        fi
        while true; do
                read -p "Are you ready to start? (y/n) " yn
                case $yn in
                        [yY]* ) echo -e "\n\e[32mOkay, let's go...\e[0m\n"; break;;
                        [nN]* ) echo -e "\n\e[32mOkay, bye.\e[0m\n"; exit;;
                        * ) echo "Please, answer (y/n).";;
                esac
        done
}
