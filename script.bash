#!/bin/bash
export LANG=en_US.UTF-8
shopt -s nullglob
derevo()
{
	local everything=($1/*)
	local dirs=($1/*/)
	
	cnt_d=$(($cnt_d+${#dirs[@]}))
	cnt_f=$(($cnt_f+$((${#everything[@]}-${#dirs[@]}))))
	
	for path in ${everything[@]}
	do
		local signs=""
		cnt_levels=$(($2+1))
		for ((j=0; j<$3; j++))
		do
			signs="$signs\u2502\u00A0\u00A0\u0020"
		done
		
		for ((j=$3; j<$2; j++))
		do
			signs="$signs\u0020\u0020\u0020\u0020"
		done
		
		if [[ $path != ${everything[-1]} ]]
		then
			signs="$signs\u251c\u2500\u2500\u0020"
		else
			signs="$signs\u2514\u2500\u2500\u0020"
			cnt_levels=$(($cnt_levels-1))
		fi
		
		divided_path=(${path//// })
		local file_name=${divided_path[-1]}
		printf "$signs$file_name\n"
		
		derevo $path $(($2+1)) $cnt_levels
	done
}
cnt_d=0
cnt_f=0
begin=$1
if [[ $begin = "" ]]
then
	begin="."
fi
printf "$begin\n"

derevo $begin 0 0

if [[ $cnt_f -eq 1 ]]
then
	end_f=""
else
	end_f="s"
fi

if [[ $cnt_d -eq 1 ]]
then
	end_d="y"
else
	end_d="ies"
fi
printf "\n$cnt_d director$end_d, $cnt_f file$end_f\n"
