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
# Rprofile: add ~/RVE.Rprofile
# call: rprofile-rve-install
#
function rprofile-rve-install {
        # ~/RVE/.Rprofile
        if [[ -f $RRC/data/tmpl.Rprofile ]]; then
                if [[ -d $RVE ]]; then
                        echo -e "\e[1mInstalling a pre-defined configuration ...\e[0m"
                        cat $RRC/data/tmpl.Rprofile > $RVE/.Rprofile
			echo -e "\e[32m - New file: $RVE/.Rprofile\e[0m"
                        echo -e "\e[1mDone.\e[0m"
                fi
        else
		sepline
                echo -e "\e[31mCan't find $RRC/data/tmpl.Rprofile\e[0m"
		sepline
        fi
}

# 
# Rprofile: add ~/.Rprofile (for --build-{standard,server})
# call: rprofile-sys-install
#
function rprofile-sys-install {
        # ~/.Rprofile
        if [[ -f $RRC/data/tmpl.Rprofile ]]; then
		sepline
                echo -e "\e[1mInstalling a pre-defined configuration ...\e[0m"
                if [[ -f $HOME/.Rprofile ]]; then
                        mv $HOME/.Rprofile $HOME/.Rprofile.old
                        echo -e "\e[32m - Old file: $HOME/.Rprofile.old\e[0m"
                fi
                cat $RRC/data/tmpl.Rprofile > $HOME/.Rprofile
                echo -e "\e[32m - New file: $HOME/.Rprofile\e[0m"
                echo -e "\e[1mDone.\e[0m"
		sepline
        else
                sepline
		echo -e "\e[31mCan't find $RRC/data/tmpl.Rprofile\e[0m\n"
		sepline
        fi
}
