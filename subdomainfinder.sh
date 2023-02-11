#! /bin/bash

if [ $# -eq 0 ]
then
echo " How to use ./subdomainfinder <domain>"
echo "  Example  ./subdomainfinder  www.Example.com"
else
wget $1 2> /dev/null && less index.html | grep "href"|cut -d ":" -f 2 |cut -d "/" -f 3|cut -d '"' -f 1  | grep -v "$1" | uniq > subdomin.txt   

for sub in $(cat subdomin.txt)
do 
if [[  $(ping -c 1 $sub  2> /dev/null)  ]]
then
echo "$sub ping +++++++  " 
echo $sub >>valid.txt 
else 
echo "$sub Not found -------"
fi
done

for  ip in  $(cat valid.txt)
do
host $ip
host $ip |cut -d " " -f 4|uniq >>ipdomain.txt  

done
echo "Done................."
fi
