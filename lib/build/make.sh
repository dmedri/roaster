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
# Setup for 'make check'
# call: roaster-build-checks
#
function roaster-build-check {
	if [[ $MCHECK = "check-all" ]]; then
		sepline
		echo -e "\e[1mBuild tests: 'make $MCHECK'.\e[0m"
		sepline
		make check-all
	elif [[ $MCHECK = "check-devel" ]]; then
		sepline
		echo -e "\e[1mBuild tests: 'make $MCHECK'.\e[0m"
		sepline
		make check-devel
	elif [[ $MCHECK = "none" ]]; then
		sepline
		echo -e "\e[1mNo build checks.\e[0m"
		sepline
	else
		sepline
		echo -e "\e[1mBuild tests: 'make check'.\e[0m"
		sepline
		make check
	fi
}

#
# Setup for 'make'
# call: roaster-build-make
#

function roaster-build-make {
	if [[ $OPTMAK = "j2Os" ]]; then
		sepline
		echo -e "\e[1mBuilding with 'make -j2 -O -s' (2 jobs, silent).\e[0m"
		sepline
		make -j2 -O -s
	elif [[ $OPTMAK = "j4Os" ]]; then
		sepline
		echo -e "\e[1mBuilding with 'make -j4 -O -s' (4 jobs, silent).\e[0m"
		sepline
		make -j4 -O -s
	elif [[ $OPTMAK = "j8Os" ]]; then
		sepline
		echo -e "\e[1mBuilding with 'make -j8 -O -s' (8 jobs, silent).\e[0m"
		sepline
		make -j8 -O -s
	elif [[ $OPTMAK = "j4" ]]; then
		sepline
		echo -e "\e[1mBuilding with 'make -j4' (4 jobs).\e[0m"
		sepline
		make -j4
	else
		sepline
		echo -e "\e[1mBuilding with 'make' (standard).\e[0m"
		sepline
		make
	fi
}

#
# Configure
# call: roaster-build-configure
#
function roaster-build-configure {
	if [[]]; then
		echo "virtualenv"
	elif [[]]; then
		echo "standard"
	elif [[]]; then
		echo "server"
	else
		echo ""
	fi
}
