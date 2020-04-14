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
                        echo -e "\nInstalling a pre-defined configuration ..."
                        cat $RRC/data/tmpl.Rprofile > $RVE/.Rprofile
			echo -e " - New file: $RVE/.Rprofile"
                        echo -e "Done.\n"
                fi
        else
                echo -e "\nCan't find $RRC/data/tmpl.Rprofile\n"
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
                echo -e "\nInstalling a pre-defined configuration ..."
                if [[ -f $HOME/.Rprofile ]]; then
                        mv $HOME/.Rprofile $HOME/.Rprofile.old
                        echo -e " - Old file: $HOME/.Rprofile.old"
                fi
                cat $RRC/data/tmpl.Rprofile > $HOME/.Rprofile
                echo -e " - New file: $HOME/.Rprofile"
                echo -e "Done.\n"
		sepline
        else
                sepline
		echo -e "\nCan't find $RRC/data/tmpl.Rprofile\n"
		sepline
        fi
}
