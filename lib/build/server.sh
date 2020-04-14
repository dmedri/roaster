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
# Build: Roaster Server Installation
# call: R-build-server
#
function R-build-server {
        # Install ccache
        ccache-sys-install

        # Build
        if [[ $RBTYPE = "stable" ]]; then
                srvver="R-$VERLATEST"
        elif [[ $RBTYPE = "branch" ]]; then
                srvver="$BRANDIR"
		unset BRANNM
		unset BRANDIR
        elif [[ $RBTYPE = "trunk" ]]; then
                srvver="R-TRUNK"
        fi
        if [[ ! -d $SRV/$srvver ]]; then
                # Build
                cd $RCO/src/$srvver && log "build-server: configure" \
                && ./configure  \
                        --prefix=$SRV/$srvver \
                        --exec-prefix=$SRV/$srvver \
                        $OPTSRV \
                && log "build-server: make clean (1)" \
                && make clean \
                && log "build-server: make $OPTMAK" \
                && roaster-build-make \
                && log "build-server: make $MCHECK" \
                && roaster-build-check
                sepline
                log "build-server: make install"
                sudo make install \
                && log "build-server: make clean (2)" \
                && make clean
                sepline
		echo -e "Installation completed."

                # Add a copy of the source tree
                echo -e "\e[32mCopying the source tree in the same directory...\e[0m\n"
                sudo cp -a $RCO/src/$srvver $SRV/$srvver/src/
                echo -e "\e[32mDone.\e[0m\n"

                # add server/README
                if [[ -f $RRC/data/tmpl.server.README ]]; then
                        sudo cat $RRC/data/tmpl.server.README > $RCO/src/$srvver/README
                fi

                rprofile-sys-install


        else
                echo -e "\e[32mDirectory $SRV/$srvver already exists.\e[0m"
                echo -e "Please, remove it for a fresh build."
        fi
}
