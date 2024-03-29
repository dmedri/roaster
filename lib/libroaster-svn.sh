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
# SVN: in "branch" mode, it check for the stable-branch name
# call: check-svn-branch 'R-3.6.3'
#
function check-svn-branch {
        BRANNM=$(echo $1 | sed -e "s/\./-/g;s/-[0-9]$//g")
        cb=$(svn ls $SVNSRV/R/branches/ --verbose|awk '{print $6}'|grep "R-$BRANNM-branch")
        if [[ $cb="R-$BRANNM-branch" ]]; then
                echo -e "\e[32mBranch R-$BRANNM-branch available.\e[0m"
                BRANDIR="R-$BRANNM-BRANCH"
                echo -e "\e[32mLocal directory: $BRANDIR.\e[0m"
        else
                echo -e "\e[31mSomething goes wrong with the branch name.\e[0m"
		exit
        fi
}

#
# SVN: update all local repositories
# call: svn-repo-update
#
function svn-repo-update {
	cd $RCO/src
	echo -e "\e[32mSVN local repositories:\e[0m"
	for i in `ls -d {R*-B*,R-TRUNK} 2>/dev/null`; do
		cd $i
		echo -e "\n\e[32m$i: updating...\e[0m"
		svn up
		cd ..
	done;
	echo -e "\e[32mDone.\e[0m\n"
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
		sepline
		echo -e "\e[1m2) The source code is now available.\e[0m"
		sepline
	else
		cd $BRANDIR
		svn up \
		&& log "svn up"
		sepline
		echo -e "\e[1m2) The source code is now updated.\e[0m"
		sepline
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
		sepline
		echo -e "\e[1m2) The source code is now available.\e[0m"
		sepline
	else
		cd R-TRUNK
		svn up \
		&& log "svn up"
		sepline
		echo -e "\e[1m2) The source code is now updated.\e[0m"
		sepline
	fi
}

#
# SVN: fetch a defined list of repo
# call: svn-repo-fetch-all
#
function svn-repo-fetch {
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

#
# SVN: list infos about available branches
# call: svn-repo-branches
#
function svn-repo-branches {
	#latest n branches
	n=3
	br=$(svn ls $SVNSRV/R/branches|grep branch|tail -$n|sort)
	echo -e "\e[32mURL:\e[0m $SVNSRV/R/branches/\n"
	echo -e "\e[32mRelease branches (latest $n):\e[0m\n"
	for i in $br; do
		r=$(svn log $SVNSRV/R/branches/$i --stop-on-copy --quiet | tail -2 | head -1)
		echo -e "\e[32m\t$i\e[0m\n\t$r\n"
	done;
}
