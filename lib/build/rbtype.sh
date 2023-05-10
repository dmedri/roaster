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
# Set RBTYPE to 'stable'
# call: set-rbtype-stable
#
function set-rbtype-stable {
	# Set config.rbtype
	echo "RBTYPE=\"stable\"" > $RCONF/config.rbtype
	sepline
	echo -e "\e[1mWill be installed a stable R environment.\e[0m"
        echo -e "The source code archive will be downloaded from the"
	echo -e "official server (latest stable release)"                                                
	sepline
}

#
# Set RBTYPE to 'branch'
# call: set-rbtype-branch
#
function set-rbtype-branch {
        # Set config.rbtype
        echo "RBTYPE=\"branch\"" > $RCONF/config.rbtype
        sepline
        echo -e "\e[1mWill be installed a stable R environment.\e[0m"                                                
        echo -e "The source code will be fetched from SVN server"
	echo -e "using the branch repository (next minor release)"                                                
        sepline
}

#
# Set RBTYPE to 'trunk'
# call: set-rbtype-trunk
#
function set-rbtype-trunk {
        # Set config.rbtype
        echo "RBTYPE=\"trunk\"" > $RCONF/config.rbtype
        sepline
        echo -e "\e[1mWill be installed an unstable R environment.\e[0m"                                                
        echo -e "The source code will be fetched from SVN server"
	echo -e "using the trunk repository (next major release)"
        sepline
}
