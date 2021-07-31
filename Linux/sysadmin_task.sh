#!/bin/bash# Variables
output_file=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777 2> /dev/null)
user_files=('/etc/passwd' '/etc/shadow')
commands=('date' 'uname -a' 'hostname -s')# Script# make a research directory in home if it doesn't currently exist
if [ ! -d $HOME/research ]
then
	mkdir $HOME/research
fi# delete previous output
if [ -f output_file ]
then
	rm $output_file
fi# intro text for audit script and date/time
echo -e "quick audit script" > $output_file
date >> $output_file
echo >> $output_file# add machine info to output file
echo "Machine type info:" >> $output_file
echo $MACHTYPE >> $output_file# add username info to output file
echo -e "Uname info: $(uname -a)\n" >> $output_file# add ip and network info to output file
echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1)\n" >> $output_file
echo "Hostname: $(hostname -s)" >> $output_file
echo "DNS Servers: " >> $output_file
cat /etc/resolv.conf >> $output_file#add memory and CPU info to output file
echo "Memory info: " >> $output_file
free >> $output_file
echo -e "\nCPU Info:" >> $output_file
lscpu | grep CPU >> $output_file
echo -e "\nDisk Usage: " >> $output_file
df -H | head -2 >> $output_file# add current user to output file
echo -e "\nWho is logged in: \n$(who)\n" >> $output_file# add all 777 permissioned files in /home to output file
echo -e "\nexec Files:" >> $output_file
sudo find /home -type f -perm 777 >> $output_file# add top 10 currently running processes to output file
echo -e "\nTop 10 processes" >> $output_file
ps aux --sort -%mem | awk {'print $1,$2,$3,$4,$11'} | head >> $output_file# check permissions of passwd and shadow
echo -e "the permissions of sensitive files are: \n" >> $output_file
for file in ${user_files[@]};
do
	ls -l $file >> $output_file
done# display check for sudo permissions
for user in $(ls /home);
do
	sudo -lU $user >> $output_file
done#display list of commands
for x in {0..2}
do
	results=$(${commands[$x]})
	echo -e "Results of \"${commands[$x]}\" command:" >> $output_file
	echo $results >> $output_file
	echo >> $output_file
done
