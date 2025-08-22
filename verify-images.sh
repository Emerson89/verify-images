#!/bin/bash

kubectl version &> /dev/null
if [ $? -eq 127 ] ; then
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &> /dev/null
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl &> /dev/null
else
   echo -e "\033[1;32mkubectl já está instalado\033[0m"
fi

echo
    {
       echo -ne "\033[1;33mVerificando o contexto atual do kubeconfig\033[0m"
       for ((i = 0 ; i <= 100 ; i+=6)); do
          sleep 0.10
          echo -ne "\033[1;33m...\033[0m"
       done
       echo -n ""
       echo
    }
echo
kubectl config get-contexts |awk '{print $1, $3}'|column -t

function confirm () {
   while true; do
      echo
      read -p "Voce deseja atualizar o context? (YES(y)/NO(n)/CANCEL(c)): " yn
      case $yn in
         [Yy]* ) return 0;;
         [Nn]* ) return 1;;
         [Cc]* ) exit;;
         * ) echo "Insira YES(y), NO(n), ou CANCEL(n).";;
      esac
   done
}


if confirm; then
  echo
  echo -e "\033[1;32mSelecione o contexto desejado: \033[0m"
  echo
  echo -e "\033[1;32mCLUSTERS\033[0m"
  echo
  select contexts in $(kubectl config get-contexts |awk '{print $3}'| sed '1d') exit; do
  case $contexts in
     exit)
        break ;;
     *) 
        echo
        kubectl config use-context $contexts;
        echo
        get=`kubectl config get-contexts |awk '{print $1, $3}'|column -t`
        echo -e "\033[1;33m$get\033[0m"
        echo
        echo -ne "\033[1;33mConsultando imagens...\033[0m"
        for ((i = 0 ; i <= 100 ; i+=6)); do
           sleep 0.10
           echo -ne "\033[1;33m...\033[0m"
        done
        echo -n ""
        echo
        result=$(kubectl get pods -A -o jsonpath="{range .items[*]}namespace{':'} {.metadata.namespace}{' → '}image: {range .spec.containers[*]}{.image}{' '}{end}{'\n'}{end}")
        echo -e "$result"
        echo
        read -p "Voce deseja salvar em arquivo? (YES(y)/NO(n)/CANCEL(c)): " yn
        case $yn in
           [Yy]* ) 
           cluster=$(kubectl config get-contexts |awk '{print $3}'| sed '1d')
           echo -e "$result" 1> $cluster.txt;;
           [Nn]* ) return 1;;
           [Cc]* ) exit;;
           * ) echo "Insira YES(y), NO(n), ou CANCEL(n).";;
        esac
     esac
     break
  done
else
   echo
   echo -ne "\033[1;33mConsultando imagens...\033[0m"
   for ((i = 0 ; i <= 100 ; i+=6)); do
      sleep 0.10
      echo -ne "\033[1;33m...\033[0m"
   done
   echo -n ""
   echo
   result=$(kubectl get pods -A -o jsonpath="{range .items[*]}namespace{':'} {.metadata.namespace}{' → '}image: {range .spec.containers[*]}{.image}{' '}{end}{'\n'}{end}")
   echo -e "$result"
   echo
   read -p "Voce deseja salvar em arquivo? (YES(y)/NO(n)/CANCEL(c)): " yn
   case $yn in
      [Yy]* ) 
      cluster=$(kubectl config get-contexts |awk '{print $3}'| sed '1d')
      echo
      echo -ne "\033[1;32mInsira o nome do cluster:\033[0m "
      read clustername
      echo -e "$result" 1> $clustername.txt;;
      [Nn]* ) return 1;;
      [Cc]* ) exit;;
      * ) echo "Insira YES(y), NO(n), ou CANCEL(n).";;
   esac

fi   
  
