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
# FreeBSD: try to install dependencies
# call: check-os-freebsd-deps
#
function check-os-freebsd-deps {
	if [[ ! -f $RCO/checks/required-packages ]]; then
		log "Installing required dependencies"
		echo "1) Installing dependencies..."
		sudo pkg info -qd | xargs sudo pkg install --yes \
		&& sudo pkg install $(cat data/pkgs.freebsd) --yes \
		&& echo $(date) > $RCO/checks/required-packages
	else
		log "Dependencies already available"
		echo "1) Dependencies already available."
	fi
}
