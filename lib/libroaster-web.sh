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
# Download and un-tar the file archive of latest stable R release
# call: web-file-fetch-stable
#
function web-file-fetch-stable {
	cd $RCO/src
	if [[ ! -d "R-$VERLATEST" ]]; then
		if [[ -f $RCO/src/$SRCF ]]; then
			rm $SRCF
		fi                                                                                       
		echo "Downloading file..." \
		&& file-web-get $SRCU/$SRCF \
		&& log "downloaded $SRCU/$SRCF" \
		&& echo "Decompressing archive..." \
		&& file-untar $SRCF \
		&& log "decompressed $RCO/src/$SRCF"
		echo -e "\e[1m2) The source code is now available.\e[0m"
	else
		echo -e "\e[1m2) The source code is already available.\e[0m"
	fi
}
