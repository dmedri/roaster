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
# Installing ccache for R - Roaster --build-virtualenv
# call: ccache-rve-install
#
function ccache-rve-install {
	sepline
        if [[ -f $RRC/data/tmpl.ccache.Makevars ]] && [[ -f $RRC/data/tmpl.ccache.conf ]]; then
                # ~/RVE/.R/Makevars
                echo -e "\e[1mInstalling ~/RVE/.R/Makevars ...\e[0m"
                mkdir -p $RVE/.R
                cat $RRC/data/tmpl.ccache.Makevars > $RVE/.R/Makevars
                echo -e "\e[1mDone.\e[0m\n"

                # ~/RVE/.ccache/ccache.conf
                echo -e "\e[1mInstalling ~/RVE/.ccache/ccache.conf ...\e[0m"
                mkdir -p $RVE/.ccache
                cat $RRC/data/tmpl.ccache.conf > $RVE/.ccache/ccache.conf
                echo -e "\e[1mDone.\e[0m"
        elif [[ ! -f $RRC/data/tmpl.ccache.Makevars ]]; then
                echo -e "\e[31mCan't find 'data/tmpl.ccache.Makevars' file.\e[0m"
        elif [[ ! -f $RRC/data/tmpl.ccache.conf ]]; then
                echo -e "\e[31mCan't find 'data/tmpl.ccache.conf' file.\e[0m"
        fi
	sepline
}

# 
# Installing ccache for R - Roaster --build-standard and --build-server
# call: ccache-sys-install
#
function ccache-sys-install {
	sepline
        if [[ -f $RRC/data/tmpl.ccache.Makevars ]] && [[ -f $RRC/data/tmpl.ccache.conf ]]; then
		# .R/Makevars
                echo -e "\e[1mInstalling ~/.R/Makevars ...\e[0m"
                if [[ ! -f $HOME/.R/Makevars ]]; then
                        mkdir -p $HOME/.R
                        cat $RRC/data/tmpl.ccache.Makevars > $HOME/.R/Makevars
                else
                        mv $HOME/.R/Makevars $HOME/.R/Makevars.old
                        cat $RRC/data/tmpl.ccache.Makevars > $HOME/.R/Makevars
                        echo -e "\e[32m - Old file: $HOME/.R/Makevars.old\e[0m"
                        echo -e "\e[32m - New file: $HOME/.R/Makevars\e[0m"
                fi
                echo -e "\e[1mDone.\e[0m\n"

                # .ccache/ccache.conf
                echo -e "\e[1mInstalling ~/.ccache/ccache.conf ...\e[0m"
                if [[ ! -f $HOME/.ccache/ccache.conf ]]; then
                        mkdir -p $HOME/.ccache
                        cat $RRC/data/tmpl.ccache.conf > $HOME/.ccache/ccache.conf
                else
                        echo -e "\e[32m - Old file: $HOME/.ccache/ccache.conf.old\e[0m"
                        echo -e "\e[32m - New file: $HOME/.ccache/ccache.conf\e[0m"
                fi
                echo -e "\e[1mDone.\e[0m"
        elif [[ ! -f $RRC/data/tmpl.ccache.Makevars ]]; then
		echo -e "\e[31mCan't find 'data/tmpl.ccache.Makevars' file.\e[0m"
        elif [[ ! -f $RRC/data/tmpl.ccache.conf ]]; then
                echo -e "\e[31mCan't find 'data/tmpl.ccache.conf' file.\e[0m"
        fi
	sepline
}
