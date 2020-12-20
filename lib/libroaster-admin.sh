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
source lib/libroaster-mirrors.sh
source lib/libroaster-utils.sh


# Basic admin: show informations about R (online release, in system
# installations, virtual environments
# call: check-status
#
function check-status {
        echo "R - Check status"

        # Check online
        echo -e "\n\tSource code available online:\n"
        echo -e "\t\e[32m$VERLATEST\e[0m\t${SRCU}$SRCF"

        # Check for local R (standard)
        echo -e "\n\tLocal installations:\n"
        local checkr=$(command -v R)
        if [[ $checkr != "" && -e $checkr ]]; then
                verr=$(R --version | awk '$1=="R" && $2=="version" {print $3}')
		verp=$(R --version | awk '$1=="R" && $2=="version" && $4=="Patched" {print "patched (svn " $6}')
                echo -e "\t\e[32m$verr\e[0m\t$checkr (standard) $verp"
        else
                echo -e "\t\e[32m-----\e[0m\tNot available (standard)"
        fi

        # Check for an existing RVE
        local verr
	local verp
        if [[ -f $RVE/bin/R ]]; then
                verr=$($RVE/bin/R --version | awk '$1=="R" && $2=="version" {print $3}')
		verp=$($RVE/bin/R --version | awk '$1=="R" && $2=="version" && $4=="Patched" {print "patched (svn " $6}')
                echo -e "\t\e[32m$verr\e[0m\t~/RVE/bin/R (virtualenv) $verp"
        else
                echo -e "\t\e[32m-----\e[0m\tNot available (virtualenv)"
        fi

        # R server farm
	local lsadir
	local srvr
	local srvp
        echo -e "\n\tServer farm:\n"
        lsadir=$(ls -A $SRV 2>/dev/null)
        if [[ -n "$lsadir" ]]; then
                for i in $lsadir; do
                        srvr=$($SRV/$i/bin/R --version | awk '$1=="R" && $2=="version" {print $3}')
                        srvp=$($SRV/$i/bin/R --version | awk '$1=="R" && $2=="version" && $4=="Patched" {print "patched (svn " $6}')
                        echo -e "\t\e[32m$srvr\e[0m\t$SRV/$i/bin/R (server) $srvp";
                done
        else
                echo -e "\t\e[32m-----\e[0m\tNot available (server)"
        fi
        echo -e ""
}

# 
# Basic admin: clean-up all the .roaster directories from spurious files
# call roaster-autoclean
#
function roaster-autoclean {
	# Remove check files and logs
        if [[ -d $RCO ]]; then
                rm -fr $RCO/{checks,logs}/*
		echo -e "\e[32mAutoclean: done.\e[0m"
	else
		echo -e "\e[31mThe directory $RCO is missing.\e[0m"
	fi
}

# 
# Basic admin: factory reset
# call: roaster-factory-reset
#
function roaster-factory-reset {
	# Add a new config file
        if [[ -f $RCO/config ]]; then
                roaster-new-config
        fi
	
	# Remove check files and logs
        roaster-autoclean

	# Remove all files, reporitories and source code directories
	if [[ -d $RCO ]]; then
		rm -fr $RCO/{src,infos}/*
		echo -e "\e[32mFactory reset: done.\e[0m"
	fi
}
