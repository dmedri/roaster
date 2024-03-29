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
# MacOS: try to install dependencies
# call: check-os-macos-deps
#
function check-os-macos-deps {
	echo "Not yet supported."
	exit
}

#
# MacOs: tips
# call: os-macos-tips
#
function os-macos-tips {
	# check the number of cpu cores
	local $ncpu = $(sysctl -n hw.ncpu)
	if [[ $ncpu > 1 ]]; then
		sepline
		echo -e "\e[1mCPU with $ncpu Core\e[0m"
		echo -e "You should try the 'parallel' R package for better performance."
		sepline
	fi
}
