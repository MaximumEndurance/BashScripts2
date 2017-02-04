#!/bin/bash

# Some extensions in myopen.cfg have been changed duo to incompatibility of paths in my system
if [ $# -ne 1 ]
then
echo "Please enter file name. Thank You!"
exit		#  is being maintained as return status for failure
fi

file="myopen.cfg"
file_to_execute=$1
colon_location=0
ext_arr=()
loc_arr=()


while read -r line;
do
colon_location=`expr index "$line" :`
ext_arr+=(${line:0:colon_location-1})
loc_arr+=(${line:colon_location})

done < $file

# At this stage, extensions have been stored independently in ext_arr
# and paths in system directory in loc_arr

dot_location_in_file_name=`expr index "$file_to_execute" .`
file_ext="${file_to_execute:$dot_location_in_file_name}"

loop_count=0
avail_ch=()

for my_ext in "${ext_arr[@]}" 
do

if [ $my_ext == $file_ext ]
then
avail_ch+=(${loc_arr[$loop_count]})

fi
let loop_count=loop_count+1
done

# checking for no of extensions. If no of extensions are > 1 prompt a Menu
echo ${avail_ch[@]}
if [ ${#avail_ch[@]} -eq 1 ]
then
${avail_ch[0]} $file_to_execute
elif [ "${#avail_ch[@]}" -eq 0 ]
then
## Add new entry

echo -e "\n\nSorry! myopen does not recognise this extension\n\n"
echo -e "\nPlease enter path of script to execute .$file_ext files\n"

read new_path
$new_path $file_to_execute
if [ pgrep -x `basename $new_path` > /dev/null ] # Checking if file executed successfully
then
if [ -e $file_to_execute ]
then
echo "$file_ext:$new_path" >> $file
echo -e "\n\n$file_ext:$new_path has been successfully updated\n\n" 
fi
else
echo -e "Oops! $new_path seems to be a little incompatible with $file\n\n"
fi

else

echo "Whoa! There seem to be multiple programs available for executing $file"
echo "$USER, please choose the program that you want to use"

local_counter=0
for possible_ext in "${avail_ch[@]}"
do 
echo "($local_counter+1) : $possible_ext"
let local_counter=local_counter+1
done

read ch

echo Executing using ${avail_ch[$ch-1]}
${avail_ch[$ch-1]} $file_to_execute &
fi
 



  


