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
# Installing ccache for R - Roaster --build-virtualenv
# call: ccache-rve-install
#
function ccache-rve-install {
        if [[ -f $RRC/data/tmpl.ccache.Makevars ]] && [[ -f $RRC/data/tmpl.ccache.conf ]]; then
                # ~/RVE/.R/Makevars
                echo -e "Installing ~/RVE/.R/Makevars ..."
                mkdir -p $RVE/.R
                cat $RRC/data/tmpl.ccache.Makevars > $RVE/.R/Makevars
                echo -e "Done.\n"

                # ~/RVE/.ccache/ccache.conf
                echo -e "Installing ~/RVE/.ccache/ccache.conf ..."
                mkdir -p $RVE/.ccache
                cat $RRC/data/tmpl.ccache.conf > $RVE/.ccache/ccache.conf
                echo -e "Done.\n"
        elif [[ ! -f $RRC/data/tmpl.ccache.Makevars ]]; then
                echo -e "Can't find 'data/tmpl.ccache.Makevars' file."
        elif [[ ! -f $RRC/data/tmpl.ccache.conf ]]; then
                echo -e "Can't find 'data/tmpl.ccache.conf' file."
        fi
}

# 
# Installing ccache for R - Roaster --build-standard and --build-server
# call: ccache-sys-install
#
function ccache-sys-install {
        if [[ -f $RRC/data/tmpl.ccache.Makevars ]] && [[ -f $RRC/data/tmpl.ccache.conf ]]; then
                # .R/Makevars
                echo -e "Installing ~/.R/Makevars ..."
                if [[ ! -f $HOME/.R/Makevars ]]; then
                        mkdir -p $HOME/.R
                        cat $RRC/data/tmpl.ccache.Makevars > $HOME/.R/Makevars
                else
                        mv $HOME/.R/Makevars $HOME/.R/Makevars.old
                        cat $RRC/data/tmpl.ccache.Makevars > $HOME/.R/Makevars
                        echo -e " - Old file: $HOME/.R/Makevars.old"
                        echo -e " - New file: $HOME/.R/Makevars"
                fi
                echo -e "Done.\n"

                # .ccache/ccache.conf
                echo -e "Installing ~/.ccache/ccache.conf ..."
                if [[ ! -f $HOME/.ccache/ccache.conf ]]; then
                        mkdir -p $HOME/.ccache
                        cat $RRC/data/tmpl.ccache.conf > $HOME/.ccache/ccache.conf
                else
                        echo -e " - Old file: $HOME/.ccache/ccache.conf.old"
                        echo -e " - New file: $HOME/.ccache/ccache.conf"
                fi
                echo -e "Done.\n"
        elif [[ ! -f $RRC/data/tmpl.ccache.Makevars ]]; then
                echo -e "Can't find 'data/tmpl.ccache.Makevars' file."
        elif [[ ! -f $RRC/data/tmpl.ccache.conf ]]; then
                echo -e "Can't find 'data/tmpl.ccache.conf' file."
        fi
}
