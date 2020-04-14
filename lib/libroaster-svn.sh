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
# call: check-svn-branch 'R-3.6.3'
#
function check-svn-branch {
        BRANNM=$(echo $1 | sed -e "s/\./-/g;s/-[0-9]$//g")
        cb=$(svn ls $SVNSRV/R/branches/ --verbose|awk '{print $6}'|grep "R-$BRANNM-branch")
        if [[ $cb="R-$BRANNM-branch" ]]; then
                echo -e "Branch R-$BRANNM-branch available."
                BRANDIR="R-$BRANNM-BRANCH"
                echo -e "Local directory: $BRANDIR."
        else
                echo -e "Problem with the branch name."
		exit
        fi
}

#
# SVN: update all local repositories
# call: svn-repo-update-all
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
# SVN: fetch only one repo (branch) with checks
# call svn-repo-fetch-branch 'R-3.6.3'
#
function svn-repo-fetch-branch {
	check-svn-branch $1
	cd $RCO/src
	if [[ ! -d $BRANDIR ]]; then
		svn co $SVNSRV/R/branches/R-$BRANNM-branch/ $BRANDIR \
		&& log "svn co $SVNSRV/R/branches/R-$BRANNM-branch/ $BRANDIR"
		echo -e "2) The source code is now available."
	else
		cd $BRANDIR
		svn up \
		&& log "svn up"
		echo -e "2) The source code is now updated."
	fi
}

#
# SVN: fetch only one repo (trunk) with checks
# call: svn-repo-fetch-trunk
#
function svn-repo-fetch-trunk {
	cd $RCO/src
	echo -e "Local directory: R-TRUNK."
	if [[ ! -d "R-TRUNK" ]]; then
		svn co $SVNSRV/R/trunk R-TRUNK \
		&& log "svn co $SVNSRV/R/trunk R-TRUNK"
		echo -e "2) The source code is now available."
	else
		cd R-TRUNK
		svn up \
		&& log "svn up"
		echo -e "2) The source code is now updated."
	fi
}

#
# SVN: fetch a defined list of repo
# call: svn-repo-fetch-all
#
function svn-repo-fetch-all {
	cd $RCO/src
	# latest n branches
	n=2
	br=$(svn ls $SVNSRV/R/branches|grep branch|sed -e "s/^R-//g;s/-branch\/$/.0/g;s/-/./g"|tail -n $n)
	for i in $br; do
		svn-repo-fetch-branch $i
	done;
	# R-TRUNK
	svn-repo-fetch-trunk
}
