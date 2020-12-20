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
# MacOS: try to install dependencies
# call: check-os-macos-deps
#
function check-os-macos-deps {
	echo "Not yet supported."
	exit
}

#
# MacOs: show the number of available CPUs
# call: check-os-macos-ncpu
#
#function check-os-macos-ncpu {
#	# number of cpu
#	local $ncpu = $(sysctl -n hw.ncpu)
#
#	# number of phisical cpu
#	local $pcpu = $(sysctl -n hw.physicalcpu)
#
#	# number of logical cpu
#	local $lcpu = $(sysctl -n hw.logicalcpu)
#
#	echo -e "MacOs - CPUs\n"
#	echo -e "  Number: $ncpu"
#	echo -e "Phisical: $pcpu"
#	echo -e " Logical: $lcpu"
#	if[$ncpu > 1]{
#		echo -e "\nTry the 'parallel' package for better performance."
#	}
#	exit
#}
