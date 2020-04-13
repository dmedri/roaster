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
			LNX="Debian derivatives (Debian, Ubuntu, Kali)"
			echo -e "1) $LNX installing dependencies...\n"
			sudo apt-get build-dep r-base --yes --quiet \
			&& sudo apt-get install $(cat data/deps/deps.debian) --yes --quiet \
			&& echo $(date) > $RCO/checks/required-packages
		elif [[ -e $yum  ]]; then
			LNX="Fedora derivatives (Fedora, SuSE, CentOs)"
			echo -e "1) $LNX installing dependencies...\n"
			sudo yum builddep R -y \
			&& sudo yum install $(cat data/deps/deps.fedora) -y \
			&& echo $(date) > $RCO/checks/required-packages
		elif [[ -e $pac ]]; then
			LNX="Arch derivatives (Arch, Manjaro, Antergos)"
			echo -e "1) $LNX installing dependencies...\n"
			pacman -S --needed - < data/deps/deps.arch --noconfirm \
			&& pacman -S $(expac -S "%E" r) --noconfirm \
			&& echo $(date) > $RCO/checks/required-packages
		else
			echo "1) Unknown Linux distribution."
			echo "Please, install by-yourself all the needed packages."
			echo "(examples: files in 'data/deps/' directory)"
			exit;
		fi
	else
		log "Dependencies already available"
		echo "1) Dependencies already available."
	fi
}
