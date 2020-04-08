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
# SVN: in "branch" mode, it check for the stable-branch name
# call: check-svn-branch
#
function check-svn-branch {
        BRANNM=$(echo $VERLATEST|sed -e "s/\./-/g;s/-[0-9]$//g")
        cb=$(svn ls $SVNSRV/R/branches/ --verbose|awk '{print $6}'|grep "R-$BRANNM-branch")
        if [[ $cb="R-$BRANNM-branch" ]]; then
                echo -e "Branch R-$BRANNM-branch available."
                BRANDIR="R-$BRANNM-BRANCH"
                echo -e "Local directory: $BRANDIR."
        else
                exit
        fi
}

#
# SVN: update all local repositories
# call: svn-repo-update
#
function svn-repo-update-all {
	cd $RCO/src
	echo -e "\e[32mSVN local repositories:\e[0m"
	for i in `ls -d {R*-B*,R-TRUNK}`; do
		cd $i
		echo -e "\n\e[32m$i: updating...\e[0m"
		svn up
		cd ..
	done;
	echo -e "Done.\n"
}

#
# SVN: get a defined list of repo
# call: svn-repo-fetch
#
function svn-repo-fetch-all {
	cd $RCO/src
	for i in "R-3-6-BRANCH" "R-4-0-BRANCH" "R-TRUNK"; do
		if [[ -d $i ]]; then
			echo -e "\e[32m$i: already available.\e[0m\n"
		else
			echo -e "\e[32m$i: fetching...\e[0m"
			# need work
		fi
	done;
}
