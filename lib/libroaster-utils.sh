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
# Log session messages (default: file)
# call: log 'this that'
#
function log {
        if [[ $LOG = "file" ]]; then
                echo "$(date +'%y/%d/%m-%H:%M:%S') $1" >> $RCO/logs/$$.build
        elif [[ $lOG = "systemd" ]]; then
                echo "$1" | systemd-cat -t roaster -p info          
        elif [[ $LOG = "syslog" ]]; then
                logger "roaster: $1"
        fi  
}

# 
# Retrieve a single value from config file
# call: MIRROR=$(get-value MIRROR)
#
function get-value {
	cat $RCONF/config | grep "^$1" | awk -F '"' '{print $2}'
}

# 
# Retrieve rbtype value
# call: RBTYPE=$(get-value-rbtype)
#
function get-value-rbtype {
        cat $RCONF/config.rbtype | grep "^$1" | awk -F '"' '{print $2}'
}

#
# Checks for required commands
# call: check-cmdreq awk
# call: check-cmdreq {awk,cut,wget}
#
function check-cmdreq {
        while(($#)); do
                command -v "$1"  >/dev/null 2>&1 \
                || { echo -e >&2 "\e[31mCommand '$1' is required.\e[0m"; exit; }
                shift
        done
}

# 
# Check latest R stable release
# call check-rstable-latest
#
function check-rstable-latest {
        VERLATEST=$(wget -O- -q $SRCU/$SRCD | awk '$1 == "Release:" {print $2}')
        if ! [[ $VERLATEST =~ ^[0-9]+(\.[0-9]+){2,3}$ ]]; then
                echo -e "\e[31mProblems with online resources. Please, try later.\e[0m" && exit
        else
                echo -e "\e[32mContacting online resources...\e[0m\n"
        fi
}

#
# Download a file from the web
# call: file-web-get URL
#
function file-web-get {
        wget "$1" --quiet
}

#
# Decompress a file archive
# call: file-untar FILE
#
function file-untar {
        tar zxf "$1"
}

#
# Edit roaster config file
# call: roaster-setup
#
function roaster-setup {
	vi $RCONF/config
}

#
# Wrap words in a string
# call: args-wrap "a string to split"
#
function args-wrap {
	while(($#)); do
		echo -e "\t\t\e[34m$1\e[0m"
		shift
	done
} 

#
# Separating line
# call: sepline
#

function sepline {
	echo -e "\n\e[32m--------------------------------------------------\e[0m\n"
}

# 
# Free Memory: unsetting variables
# call: freemem
#
function freemem {
        # unsetting vars
        unset MIRROR
        unset SVNSRV
        unset RBTYPE
        unset OPTSTD
        unset OPTRVE
        unset OPTSRV
        unset BTYPE
        unset BOPTS
        unset VERLATEST
        unset LNX
        unset RCC
        unset RCO
        unset RVE
        unset LOG
}
