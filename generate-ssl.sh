#!/bin/bash

install_ssl_Cert() {
	#git clone https://github.com/certbot/certbot.git /opt/letsencrypt > /dev/null 2>&1
	#we'll need to take email at some point
	read -p "Enter the email address that will be used in from of the authority " -r emailforacme
	echo "---> : $emailforacme"
	if [ "$emailforacme" == '' ]
	then
		echo "ERROR: email you entered is empty, will stop."
		exit
	else
		echo "email is $emailforacme ."
	fi
	echo 'install of acme commented'
	##curloutput=$(curl --insecure https://get.acme.sh | sh -s email="${emailforacme}")
	##echo "ret curl: $curloutput"
	echo "Choose your CA (todo)"
	#other user specifies the file containing dnsapitouse
	set -x
	echo "Choose your DNSRegistrar 0) Others, 1) dns_gandi_livedns, 2) dns_internetbs"
	ar_registrars=("userchoose" "dns_gandi_livedns" "dns_internetbs" "ovh")
#	possible upgrade list available dns registrar and put them in a file lastregistrar.txt, and also
#	try showing list in columns with print
	read -p "Choose (0,1,2,3) :" -r nchosen_registrar

	chosen_dnshook=${ar_registrars[${nchosen_registrar}]}
	echo "1. Hook chosen: $chosenHook"
	if [ $nchosen_registrar == 0 ]
	then
		echo "you chose hook ${chosenHook}."
		echo "what acme can handle is described here: "
		echo "https://github.com/acmesh-official/acme.sh/wiki/dnsapi"
		read -p "Please enter the hook expected by acme.sh" -r chosen_dnshook
	fi
	set +x
	#config file template
	dnsapi_configfiletpl="${chosen_dnshook}.acmesh"
	dnsapi_configfile="${dnsapi_configfiletpl}-filled"
	echo "2. Hook chosen: $chosenHook"
	[ ! -f "./${dnsapi_configfile}" ] && echo "Error: file ${dnsapi_configfile} not found."
	echo "Info: file ${dnsapi_configfile} exists."
	#for i in ${arRegistrers[@]};
	#	do echo ${i};
	#	if [ "{$i}" == 1 ]
	#done
exit;
	#./acme.sh --issue --dns dns_internetbs
	#install socat ?!
	## I assume the script is run as root
	##cd /opt/letsencrypt
	#cd /root/.acme.sh/acme.sh -
	letsencryptdomains=()
	end="false"
	i=0

	while [ "$end" != "true" ]
	do
		read -p "Enter your server's domain or done to exit: " -r domain
		if [ "$domain" != "done" ]
		then
			letsencryptdomains[$i]=$domain
		else
			end="true"
		fi
		((i++))
	done
	command="~/.acme.sh/acme.sh --issue --dns $dnsregistrar_touse certonly --standalone "
	for i in "${letsencryptdomains[@]}";
		do
			command="$command -d $i"
		done
	command="$command -n --register-unsafely-without-email --agree-tos"
	
	eval $command

}

install_ssl_Cert
