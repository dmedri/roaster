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


# Libraries
source lib/libroaster-os-linux.sh
source lib/libroaster-os-freebsd.sh
source lib/libroaster-os-macos.sh
source lib/libroaster-os-windows.sh

#
# Retrieve OS informations
# call: os-info-retrieve
#
function os-info-retrieve {
	osinfo=$(uname)
	echo -e "Running $osinfo."
	if [[ $osinfo = "Linux" ]]; then
		check-os-linux-deps
	else [[ $osinfo = "FreeBSD" ]];
		check-os-freebsd-deps
	fi
}
