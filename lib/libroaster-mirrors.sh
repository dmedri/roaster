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
# Get an updated list of mirror sites
# call: roaster-get-mirrors
#
function roaster-mirrors-update {
	# The Roaster 'infos' directory exists?
	if [[ -d $RCO/infos ]]; then
                wget -O- -q $MIRROR/$CRANM | awk -F "\"*,\"*" '{print $2,$4}' | sort | uniq > $RCO/infos/MIRRORS
                echo -e "\e[32mFile $RCO/infos/MIRRORS updated.\e[0m"
		sepline
        fi
}

#
# List mirror sites (if not available, update)
# call: roaster-mirrors-show
#
function roaster-mirrors-list {
	if [[ ! -f $RCO/infos/MIRRORS ]]; then
		roaster-mirrors-update
	else
		while true; do
			read -p "Update the list of mirror sites? (y/n) " yn
			case $yn in
				[yY]* ) roaster-mirrors-update; break;;
#				[nN]* ) exit;;
				[nN]* ) break;;
				* ) echo -e "\e[32mPlease, answer y/n.\e[0m";;
			esac
		done
	fi
	more $RCO/infos/MIRRORS
}
