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
# OS Linux: check the Linux derivatives and try to install dependencies
# call: check-os-linux-deps
#
function check-os-linux-deps {
	local apt=$(command -v apt-get)
	local yum=$(command -v yum)
	local pac=$(command -v pacman)

	if [[ ! -f $RCO/checks/required-packages ]]; then
		log "Installing required dependencies"
		if [[ -e $apt ]]; then
			LNX="Debian derivatives -"
			sepline
			echo -e "\e[1m1) $LNX installing dependencies...\e[0m"
			sepline
			sudo apt-get build-dep r-base --yes --quiet \
			&& sudo apt-get install $(cat data/deps/deps.debian) --yes --quiet \
			&& echo $(date) > $RCO/checks/required-packages
		elif [[ -e $yum  ]]; then
			LNX="Fedora derivatives -"
			sepline
			echo -e "\e[1m1) $LNX installing dependencies...\e[0m"
			sepline
			sudo yum builddep R -y \
			&& sudo yum install $(cat data/deps/deps.fedora) -y \
			&& echo $(date) > $RCO/checks/required-packages
		elif [[ -e $pac ]]; then
			LNX="Arch derivatives -"
			sepline
			echo -e "\e[1m1) $LNX installing dependencies...\e[0m"
			sepline
			sudo pacman -S --needed - < data/deps/deps.arch --noconfirm \
			&& sudo pacman -S $(expac -S "%E" r) --noconfirm \
			&& echo $(date) > $RCO/checks/required-packages
		else
			echo -e "\e[1m1) Unknown Linux distribution.\e[0m"
			echo "Please, install by-yourself all the needed packages."
			echo "(examples: files in 'data/deps/' directory)"
			exit;
		fi
	else
		log "Dependencies already available"
		sepline
		echo -e "\e[1m1) Dependencies already available.\e[0m"
		sepline
	fi
}


#
# Linux: show tips
# call: os-linux-tips
#
function os-linux-tips {
        # check the number of cpu cores
        local $ncpu = $(grep -c processor /proc/cpuinfo)
        if [[ $ncpu > 1 ]]; then
		sepline
		echo -e "\e[1mCPU with $ncpu Core\e[0m"
		echo -e "You should try the 'parallel' R package for better performance."
		sepline
	fi
}
