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
source lib/libroaster-os.sh
source lib/libroaster-admin.sh
source lib/libroaster-build.sh

# 
# Roaster header
# call: roaster-header
#
function roaster-header {
        echo -e "\e[32mRoaster\e[0m - https://github.com/dmedri/roaster"
        echo -e "Copyright 2019-2023 Daniele Medri - GNU LGPL 2.1+"
        echo -e "Use 'roaster --help' for the available options.\n"
}

# 
# Create a new Roaster configuration file
# call: roaster-new-config
#
function roaster-new-config {
	# Get the default available configuration
	if [[ -f $RRC/data/tmpl.config ]]; then
                cat $RRC/data/tmpl.config > $RCONF/config
		set-rbtype-stable
        else
		# Set a fall-back configuration
		sepline
		echo -e "The default configuration file:\n"
		echo -e "\t$RRC/data/tmpl.config\n"
		echo -e "is not available. Setting a fall-back setup."
		sepline

                echo "MIRROR=\"https://cloud.r-project.org\"" > $RCONF/config
                echo "LOG=\"file\"" >> $RCONF/config
                echo "SVNSRV=\"https://svn.r-project.org/\"" >> $RCONF/config
                echo "RBTYPE=\"stable" >> $RCONF/config.rbtype
                echo "OPTSRV=\"\"" >> $RCONF/config
                echo "OPTSTD=\"\"" >> $RCONF/config
                echo "OPTRVE=\"\"" >> $RCONF/config
                echo "MCHECK=\"check\"" >> $RCONF/config
                echo "MAKE=\"\"" >> $RCONF/config
        fi
}

# 
# Check roaster working directories
# call: check-roaster-working-dirs
#
function check-roaster-working-dirs {
        # Create Roaster directories
	if [[ ! -d $RCO ]]; then
                mkdir -p $RCO/{src,logs,checks,infos,confs}
                roaster-new-config
        fi

        # Query available settings
        MIRROR=$(get-value MIRROR)
        SVNSRV=$(get-value SVNSRV)
        OPTSRV=$(get-value OPTSRV)
        OPTSTD=$(get-value OPTSTD)
        OPTRVE=$(get-value OPTRVE)
        MCHECK=$(get-value MCHECK)
        OPTMKE=$(get-value OPTMKE)
        RBTYPE=$(get-value-rbtype RBTYPE)
        LOG=$(get-value LOG)
}

# 
# Roaster help menu
# call: app-options
#
function app-options {
        echo -e "Get informations:"
        echo -e "\t\e[34m--status\e[0m         \tR status (online + local)\n"
        echo -e "Basic administration:"
	echo -e "\t\e[34m--setup\e[0m          \tOpen roaster config file."
        echo -e "\t\e[34m--mirrors\e[0m        \tShow mirrors by-country."
        echo -e "\t\e[34m--autoclean\e[0m      \tRemove all session files."    
        echo -e "\t\e[34m--factory-reset\e[0m  \tFactory reset.\n"
        echo -e "R environment:"
        echo -e "\t\e[34m--set-stable\e[0m     \tLatest stable release (default)."
        echo -e "\t\e[34m--set-branch\e[0m     \tThe stable branch repository (SVN)."
        echo -e "\t\e[34m--set-trunk\e[0m      \tThe unstable trunk repository (SVN).\n"
        echo -e "Build source code:"
        echo -e "\t\e[34m--build-settings\e[0m  \tShow build settings."
        echo -e "\t\e[34m--build-server\e[0m    \tConcurrent minimal versions in system."
        echo -e "\t\e[34m--build-standard\e[0m  \tCommon installation in system."
        echo -e "\t\e[34m--build-virtualenv\e[0m\tCreate a virtual environment.\n"
       	echo -e "SVN actions:"
       	echo -e "\t\e[34m--svn-repo-fetch\e[0m\tFetch svn repos (latest 2 stable + trunk)."
       	echo -e "\t\e[34m--svn-repo-update\e[0m\tUpdate local svn repos (in ~/.roaster/src/)."
       	echo -e "\t\e[34m--svn-repo-branches\e[0m\tBasic infos about most recent branches.\n"
}

#
# Roaster: summary of settings before the build stage
# call: build-settings
#
function build-settings {
        echo -e "Build settings in $RCO/config:"
        echo -e "\n\tmirror site: \e[32m$MIRROR\e[0m"
        echo -e "\t build type: \e[32m$RBTYPE\e[0m"
        echo -e "\t make tests: \e[32m$MCHECK\e[0m"
        echo -e "\t svn server: \e[32m$SVNSRV\e[0m"
        echo -e "\t   log type: \e[32m$LOG\e[0m"
        echo -e "\n\t--build-server configure options:"
        args-wrap $OPTSRV
        echo -e "\t--build-standard configure options:"
        args-wrap $OPTSTD
        echo -e "\t--build-virtualenv configure options:"
        args-wrap $OPTRVE
        echo ""
}
