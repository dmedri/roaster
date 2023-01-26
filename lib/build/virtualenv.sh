# This file is part of the Roaster project 
# https://github.com/dmedri/roaster/
# Copyright (c) 2019-2023 Daniele Medri.
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


# 
# Build Option for virtual environment
# call: R-build-virtualenv
#
function R-build-virtualenv {
        # Create virtualenv directory
        if [[ -d $RVE ]]; then
                echo -e "\e[32mThe directory RVE already exists.\e[0m"
                while true; do
                        read -p "Backup the old directory and proceed? (y/n) " yn
                        case $yn in
                                [yY]* ) mv ~/RVE ~/RVE.backup-$(date +"%y%m%d%H%M"); break;;
                                [nN]* ) echo -e "\e[31mOkay, bye.\e[0"; exit;;
                                * ) echo -e "\e[32mPlease, answer (y/n).\e[0m";;
                        esac
                done
        fi
        # Add the workspace directory
        mkdir -p $RVE/workspace

        # Install ccache in ~/RVE
        ccache-rve-install

        # Add ~/RVE/.Rprofile
	rprofile-rve-install

        # Add ~/RVE/README
        if [[ -d $RVE ]]; then
                if [[ -f $RRC/data/tmpl.virtualenv.README ]]; then
                        cat $RRC/data/tmpl.virtualenv.README > $RVE/README
                fi
        fi

        # Build
        if [[ $RBTYPE = "stable" ]]; then
                cd $RCO/src/R-$VERLATEST
        elif [[ $RBTYPE = "branch" ]]; then
                cd $RCO/src/$BRANDIR
		unset BRANNM
		unset BRANDIR
        elif [[ $RBTYPE = "trunk" ]]; then
                cd $RCO/src/R-TRUNK
        fi
        log "build-virtualenv: configure" \
        && ./configure \
                --prefix=$RVE \
                --exec-prefix=$RVE \
                --disable-rpath $OPTRVE \
                && log "build-virtualenv: make clean (1)" \
                && make clean \
                && log "build-virtualenv: make $OPTMAK" \
                && roaster-build-make \
                && log "build-virtualenv: make $MCHECK" \
                && roaster-build-check \
                && log "build-virtualenv: make install" \
                && make install \
                && log "build-virtualenv: make clean (2)" \
                && make clean 
		sepline

        # Add RVE/bin/activate
        if [[ -d $RVE/bin ]]; then
                if [[ -f $RRC/data/tmpl.activate ]]; then
			echo -e "\e[1mInstallation completed.\e[0m\n\n"
                        echo -e "\e[32mR Virtual Environment\e[0m"
                        cat $RRC/data/tmpl.activate > $RVE/bin/activate
                        echo -e "\e[32m enable: \$ source $RVE/bin/activate\e[0m"
                        echo -e "\e[32mdisable: \$ deactivate\e[0m\n"
                fi
        else
                echo -e "\e[31mSomething goes wrong...\e[0m"
                echo -e "\e[31mPlease, remove the ~/RVE directory.\e[0m"
        fi
}
