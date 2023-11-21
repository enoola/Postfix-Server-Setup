set -x
arRegistrars=("userchoose" "dns_gandi_livedns" "dns_internetbs")
# read -p "Choose (0,1,2) :" -r chosenRegistrar
chosenRegistrar=0
chosenHook=${arRegistrars[${chosenRegistrar}]}
echo "1. Hook chosen: $chosenHook"
echo $chosenHook
set +x
