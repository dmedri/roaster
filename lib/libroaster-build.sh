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
source lib/libroaster-build-virtualenv.sh
source lib/libroaster-build-standard.sh
source lib/libroaster-build-server.sh
source lib/libroaster-build-ccache.sh
source lib/libroaster-rprofile.sh
source lib/libroaster-svn.sh

# 
# Build: init actions to start the task
# call: R-build-init
#
function R-build-init {
        log "Building R ($RBTYPE - $BTYPE)"

        # Check OS infos and try to install dependencies
        function check-os-deps {
                local apt=$(command -v apt-get)
                local yum=$(command -v yum)
                local pac=$(command -v pacman)

                if [[ ! -f $RCO/checks/required-packages ]]; then
                        log "Installing required dependencies"
                        if [[ -e $apt ]]; then
                                LNX="Debian derivatives (Debian, Ubuntu, Kali)"
                                echo -e "1) $LNX installing dependencies...\n"
                                sudo apt-get build-dep r-base --yes --quiet \
                                && sudo apt-get install $(cat data/pkgs.debian) --yes --quiet \
                                && echo $(date) > $RCO/checks/required-packages
                        elif [[ -e $yum  ]]; then
                                LNX="Fedora derivatives (Fedora, SuSE, CentOs)"
                                echo -e "1) $LNX installing dependencies...\n"
                                sudo yum builddep R -y \
                                && sudo yum install $(cat data/pkgs.redhat) -y \
                                && echo $(date) > $RCO/checks/required-packages
                        elif [[ -e $pac ]]; then
                                LNX="Arch derivatives (Arch, Manjaro, Antergos)"
                                echo -e "1) $LNX installing dependencies...\n"
                                pacman -S --needed - < data/pkgs.arch --noconfirm \
                                && pacman -S $(expac -S "%E" r) --noconfirm \
                                && echo $(date) > $RCO/checks/required-packages
                        else
                                echo "1) Unknown Linux distribution."
                                echo "Please, install by-yourself all the needed packages."
                                exit;
                        fi
                else
                        log "Dependencies already available"
                        echo "1) Dependencies already available."
                fi
        }

        # Check latest stable release and download it
        function download-wget-stable {
                cd $RCO/src
                if [[ ! -d "R-$VERLATEST" ]]; then
                        if [[ -f $RCO/src/$SRCF ]]; then
                                rm $SRCF
                        fi
                        wget $SRCU/$SRCF --quiet \
                        && log "downloaded $SRCU/$SRCF" \
                        && tar zxf $SRCF \
                        && log "decompressed $RCO/src/$SRCF" \
                        echo -e "2) The source code is now available."
                else
                        echo -e "2) The source code is already available."
                fi
        }

        # Check svn repository and checkout from master
        function download-svn-branch {
                check-svn-branch
                cd $RCO/src
                if [[ ! -d $BRANDIR ]]; then
                        svn co $SVNSRV/R/branches/R-$BRANNM-branch/ $BRANDIR \
                        && log "svn co $SVNSRV/R/branches/R-$BRANNM-branch/ $BRANDIR" \
                        echo -e "2) The source code is now available."
                else
                        cd $BRANDIR
                        svn up \
                        && log "svn up" \
                        echo -e "2) The source code is now updated."
                fi
        }

        # Check svn repository and checkout from master
        function download-svn-trunk {
                cd $RCO/src
                if [[ ! -d "R-TRUNK" ]]; then
                        svn co $SVNSRV/R/trunk R-TRUNK \
                        && log "svn co $SVNSRV/R/trunk R-TRUNK" \
                        echo -e "2) The source code is now available."
                else
                        cd R-TRUNK
                        svn up \
                        && log "svn up" \
                        echo -e "2) The source code is now updated."
                fi
        }
        check-os-deps
        if [[ $RBTYPE = "stable" ]]; then
                download-wget-stable
        elif [[ $RBTYPE = "branch" ]]; then
                download-svn-branch
        elif [[ $RBTYPE = "trunk" ]]; then
                download-svn-trunk
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
