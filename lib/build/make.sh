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
function roaster-build-checks {
	if [[ $MCHECK = "check-all" ]]; then
		echo -e "\n\e[32mBuild tests: 'make check-all'.\e[0m\n"
		make check-all
	elif [[ $MCHECK = "check-devel" ]]; then
		echo -e "\n\e[32mBuild tests: 'make check-devel'.\e[0m\n"
		make check-devel
	elif [[ $MCHECK = "none" ]]; then
		echo -e "\n\e[32mNo build checks.\e[0m\n"
	else
		echo -e "\n\e[32mBuild tests: 'make check'.\e[0m\n"
		make check
	fi
}
