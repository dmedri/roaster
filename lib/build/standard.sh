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


#
# Build: install a 'canonical' R in the system
# call: R-build-standard
#
function R-build-standard {
        # Install ccache
        ccache-sys-install

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
        log "build-standard: configure" \
        && ./configure  $OPTSTD \
        && log "build-standard: make clean (1)" \
        && make clean \
        && log "build-standard: make $OPTMAK" \
        && roaster-build-make \
        && log "build-standard: make $MCHECK" \
        && roaster-build-check
        sepline
	log "build-standard: make install"
        if [[ $BSTDASK==true ]]; then
                while true; do
                        read -p "Build done. Install now? (y/n) " yn
                        case $yn in
                                [yY]* ) sudo make install \
                                        && log "build-standard: make clean (2)" \
                                        && make clean; break;;
                                [nN]* ) echo -e "\n\e[32mNotice: installation can proceed with 'make install'.\e[0m\n"; exit;;
                                * ) echo -e "\e[32mPlease, answer (y/n).\e[0m";;
                        esac
                done
        else
                sudo make install && log "build-standard: make clean (2)" \
                && make clean
        fi

	rprofile-sys-install

	echo -e "\e[1mInstallation completed.\e[0m\n"
}

