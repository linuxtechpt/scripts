#!/usr/bin/env bash
#Data: 30-01-2021
# Instalação e configuração do protonbridge

##### Helper functions ######
BRIDGE_VERSION=1.5.7-1
##### Functions ######
function persist_install() {
	echo "Verificar o pacote $1 no sistema..."
	if command -v "$1" &> /dev/null -eq 1; then
		echo "Pacote instalado no sistema"
	else
		echo "Queres instalar o pacote $1 (y/n)?"
		read -r answer
		case "${answer}" in
			[Yy]) perform_install "$2";;
		esac
	fi
}

function download_bridge() {
echo "Queres fazer download da bridge (y/n)?"
	read -r answer
	case "${answer}" in
		[Yy])
		echo "Download do pacote protonmail-bridge..."
		if command -v apt &> /dev/null ; then
			wget -O protonmail-bridge.deb "https://protonmail.com/download/protonmail-bridge_${BRIDGE_VERSION}_amd64.deb"
		else
			wget -O protonmail-bridge.rpm "https://protonmail.com/download/protonmail-bridge-${BRIDGE_VERSION}.x86_64.rpm"
		fi
		echo "Download concluido";;
	esac
}

function perform_install() {
	if command -v apt &> /dev/null
	then
		sudo apt install -y "$1"
		return
	fi

	if command -v dnf &> /dev/null
	then
		sudo dnf install -y "$1"
		return
	fi
}
######## MAIN ########

echo "Verificar o pacote protonmail-bridge no sistema..."
if command -v protonmail-bridge &> /dev/null -eq 0; then
	echo "Bridge do Protonmail instalada"
	exit 0
else
	download_bridge
fi

# validate if is needed to install gdebi
if command -v apt
then
	persist_install "gdebi-core"
fi

if command -v apt; then
	persist_install "gpg" "gnupg"
else
	persist_install "gpg" "gnupg2"
fi

echo "Criar nova chave..."
gpg --gen-key
persist_install "pass" "pass"

echo "A instalar o pacote protonmail-bridge..."
if command -v apt; then
	sudo gdebi protonmail-bridge.deb
else
	sudo dnf localinstall -y protonmail-bridge.rpm
fi


echo "Gerar nova chave no pass..."
echo "Por favor introduza o email: "
read -r variable_mail
pass init "$variable_mail"
pass generate "email_bridge/$variable_mail"
echo "Instalação e configuração do Proton_bridge concluida!"
