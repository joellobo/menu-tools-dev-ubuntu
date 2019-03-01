#!/bin/bash
## \author Hernando
## \file baixarlog.sh
## \brief Baixa os logs do ambiente de homologação ou produção do sistema SAJ-INTEGRA publicado em portalsa.supcd.spo.serpro:990
## \details Utilize: ./baixalog.sh < hom | homjdk8 | pro > < CPF usuario >
## \result Os logs serão disponibilizados em ~/saj/logs/< timestamp >

SERVIDORES=
PUBLICADORES=
if [[ $# -ne 2 ]]; then
	echo "Utilize: ./baixalog.sh < hom | homjdk8 | pro > <CPF usuario>";
	exit 1;
else
	if [[ $1 == "hom" ]]; then
		PUBLICADORES=("online+SPO_AP_04275_HOM_SIAJ" "op4_batch+SPO_AP_06907_HOM_SAJ-INTEGRA" "op3n_batch+SPO_AP_06907_HOM_SAJ-INTEGRA-OP3")
		SERVIDORES=("online+SPCDSRVV0301" "op4_batch+SPCDSRVV1804" "op3n_batch+SPCDSRVV2273")
	elif [[ $1 == "homjdk8" ]]; then
		PUBLICADORES=("online+SPO_AP_04275_HOM_PGFNSAJ013-INTERNET" "batch+SPO_AP_06907_HOM_PGFNSAJINT")
		SERVIDORES=( "batch+SPCDSRVV3002" "online+SPCDSRVV3004")
	elif [[ $1 == "pro" ]]; then
		#statements
		PUBLICADORES=("online+SPO_AP_04275_PRO_SIAJ" "op4_batch+SPO_AP_06907_PRO_SAJ-INTEGRA" "op3n_batch+SPO_AP_06907_PRO_SAJ-INTEGRA-OP3")
		SERVIDORES=( "op4_batch+10.30.116.64" "op4_batch+10.30.116.65" "op3n_batch+SPCDSRVV2274" "op3n_batch+SPCDSRVV2275" "online+10.30.116.49"
								 "online+10.30.116.50" "online+10.30.116.51" "online+10.30.116.52" "online+10.30.116.55" "online+10.30.116.56")
	else
			$0;
			exit 1;
	fi;
fi;

echo -n Password:
read -s PASS

HOST=portalsa.supcd.spo.serpro:990
LOCALDIR=~/dev/saj/logs
USER=$2
PREFIX=$1-$(date +"%Y-%m-%d-%H-%M")
# ARRAY DE SERVIDORES
PASTA_PUBLICACAO=
AMBIENTE_PUBLICADOR=
AMBIENTE_SERVIDOR=
IP=

##########################################################################
# VERIFICANDO A VERSÃO DO ARTEFATO, SE NÃO ENCONTRAR SAI DO SCRIPT
##########################################################################
if [ ! -f ~/.netrc ]; then
	touch ~/.netrc
fi

##############################################
# Verificando existencia de usuário de deploy!
##############################################
if [ $(cat ~/.netrc |grep ftp:ssl-| wc -l) != 4 ]; then
	sed '/set ftp:ssl-/d' ~/.netrc > ~/.netrc2 ; mv ~/.netrc2 ~/.netrc
	echo "set ftp:ssl-allow true" >> ~/.netrc
	echo "set ftp:ssl-force true" >> ~/.netrc
	echo "set ftp:ssl-protect-data true" >> ~/.netrc
	echo "set ftp:ssl-protect-list true" >> ~/.netrc
fi;
if [ $(cat ~/.netrc |grep ssl:verify-certificate| wc -l) != 1 ]; then
	sed '/set ssl:verify-certificate/d' ~/.netrc > ~/.netrc2 ; mv ~/.netrc2 ~/.netrc
	echo "set ssl:verify-certificate false" >> ~/.netrc
fi;

mkdir -p $LOCALDIR/$PREFIX;

for publicador in "${PUBLICADORES[@]}"
do
		PASTA_PUBLICACAO=$(echo ${publicador} | cut -d'+' -f 2)

		for servidor in "${SERVIDORES[@]}"
		do
			AMBIENTE_PUBLICADOR=$(echo ${publicador} | cut -d'+' -f 1)
			AMBIENTE_SERVIDOR=$(echo ${servidor} | cut -d'+' -f 1)

			if [[ $AMBIENTE_PUBLICADOR == $AMBIENTE_SERVIDOR ]]; then
				IP=$(echo ${servidor} | cut -d'+' -f 2)

				lftp $HOST <<- EOF
				    set ftp:ssl-allow true
				    set ftp:ssl-force true
				    set ftp:ssl-protect-data true
				    set ftp:ssl-protect-list true
				    set ssl:verify-certificate false

				    user $USER "$PASS"

						get /basic/SPO/$PASTA_PUBLICACAO/logs/app/$IP/server.log -o $LOCALDIR/$PREFIX/${servidor}-server.log
						get /basic/SPO/$PASTA_PUBLICACAO/logs/app/$IP/boot.log -o $LOCALDIR/$PREFIX/${servidor}-boot.log
				EOF
			fi
		done
done

echo "Logs em " $LOCALDIR/$PREFIX;
