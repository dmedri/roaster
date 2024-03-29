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


# Libraries
source lib/os/libroaster-os-linux.sh
source lib/os/libroaster-os-freebsd.sh
source lib/os/libroaster-os-openbsd.sh
source lib/os/libroaster-os-netbsd.sh
source lib/os/libroaster-os-macos.sh
source lib/os/libroaster-os-minix.sh
source lib/os/libroaster-os-irix.sh
source lib/os/libroaster-os-qnx.sh
source lib/os/libroaster-os-solaris.sh
source lib/os/libroaster-os-windows.sh

#
# Retrieve OS informations
# call: os-info-retrieve
#
function os-info-retrieve {
	osinfo=$(uname)
	echo -e "\e[32mRunning $osinfo.\e[0m\n"
	if [[ $osinfo = "Linux" ]]; then
		check-os-linux-deps
	elif [[ $osinfo = "FreeBSD" ]]; then
		check-os-freebsd-deps
	elif [[ $osinfo = "OpenBSD" ]]; then
		check-os-openbsd-deps
	elif [[ $osinfo = "NetBSD" ]]; then
		check-os-netbsd-deps
	elif [[ $osinfo = "Darwin" ]]; then
		check-os-macos-deps
	elif [[ $osinfo = "MINIX" ]]; then
		check-os-minix-deps
	elif [[ $osinfo = "IRIX" ]]; then
		check-os-irix-deps
	elif [[ $osinfo = "QNX" ]]; then
		check-os-qnx-deps
	elif [[ $osinfo = "SunOS" ]]; then
		check-os-solaris-deps
	else
		check-os-windows-deps
	fi
}
