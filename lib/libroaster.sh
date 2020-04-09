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
source lib/libroaster-os.sh
source lib/libroaster-admin.sh
source lib/libroaster-build.sh

# 
# Roaster header
# call: roaster-header
#
function roaster-header {
        echo -e "\e[32mRoaster\e[0m - https://github.com/dmedri/roaster"
        echo -e "Copyright 2019-2020 Daniele Medri - GNU LGPL 2.1+"
        echo -e "Use 'roaster --help' for the available options.\n"
}

# 
# Create a new config file
# call: roaster-new-config
#
function roaster-new-config {
        if [[ -f $RRC/data/tmpl.config ]]; then
                cat $RRC/data/tmpl.config > $RCO/config
        else
                echo "MIRROR=\"https://cloud.r-project.org\"" > $RCO/config
                echo "LOG=\"file\"" >> $RCO/config
                echo "SVNSRV=\"https://svn.r-project.org/\"" >> $RCO/config
                echo "RBTYPE=\"stable" >> $RCO/config
                echo "OPTSRV=\"\"" >> $RCO/config
                echo "OPTSTD=\"\"" >> $RCO/config
                echo "OPTRVE=\"\"" >> $RCO/config
        fi
}

# 
# Check roaster working directories
# call: check-roaster-working-dirs
#
function check-roaster-working-dirs {
        # Create Roaster directories
	if [[ ! -d $RCO ]]; then
                mkdir -p $RCO/{src,logs,checks,infos}
                roaster-new-config
        fi

        # Query available settings
        MIRROR=$(get-value MIRROR)
        SVNSRV=$(get-value SVNSRV)
        RBTYPE=$(get-value RBTYPE)
        OPTSRV=$(get-value OPTSRV)
        OPTSTD=$(get-value OPTSTD)
        OPTRVE=$(get-value OPTRVE)
        LOG=$(get-value LOG)
}

# 
# Roaster help menuo
# call: app-options
#
function app-options {
        echo -e "\e[1mGet informations about R and mirrors:\e[0m"
        echo -e "\t\e[34m--check-status\e[0m   \tCheck available R releases."
        echo -e "\t\e[34m--mirrors\e[0m        \tList mirror sites by-country.\n"
        echo -e "\e[1mBasic administration:\e[0m"
        echo -e "\t\e[34m--autoclean\e[0m      \tRemove unuseful files."    
        echo -e "\t\e[34m--factory-reset\e[0m  \tFactory reset."
        echo -e "\t\e[34m--settings\e[0m       \tShow settings.\n"
        echo -e "\e[1mBuild source code:\e[0m"
        echo -e "\t\e[34m--build-server\e[0m    \tConcurrent minimal versions in system."
        echo -e "\t\e[34m--build-standard\e[0m  \tCommon installation in system."
        echo -e "\t\e[34m--build-virtualenv\e[0m\tCreate a virtual environment.\n"
}

#
# Roaster: summary of settings before the build stage
# call app-settings
#
function app-settings {
        # function args-wrap
        function args-wrap {
                while(($#)); do
                        echo -e "\t\t\e[34m$1\e[0m"
                        shift
                done
        }
        echo -e "\e[1mSettings in $RCO/config:\e[0m"
        echo -e "\n\tmirror site: \e[34m$MIRROR\e[0m"
        echo -e "\t build type: \e[34m$RBTYPE\e[0m"
        echo -e "\t svn server: \e[34m$SVNSRV\e[0m"
        echo -e "\t   log type: \e[34m$LOG\e[0m"
        echo -e "\n\tbuild-server options:"
        args-wrap $OPTSRV
        echo -e "\tbuild-standard options:"
        args-wrap $OPTSTD
        echo -e "\tbuild-virtualenv options:"
        args-wrap $OPTRVE
        echo ""
}

