#!/bin/bash
#Data: 30-01-2021
# Instalação e configuração do protonbridge

echo "1 | Verificar o pacote protonmail-bridge no sistema..."
which protonmail-bridge &> /dev/null 
if [ $? -eq 0 ] 
  then
	  echo "Pacote instalado no sistema"
  else
	  echo "Queres instalar o pacote protonmail-bridge (y/n)?"
	  read -r answer
	  case "${answer}" in
		  [Yy])
	          echo "Download do pacote protonmail-bridge..."
		  wget https://protonmail.com/download/protonmail-bridge_1.5.7-1_amd64.deb
		  echo "Download concluido"
esac
fi
echo "2 | Verificar o pacote gdebi-core no sistema..."
which gdebi &> /dev/null
if [ $? -eq 0 ] 
  then
	  echo "Pacote já instalado no sistema!"
  else
	  echo "gdebi não está instalado!"
	  echo "Queres instalar o pacote gdebi (y/n)?"
	  read -r answer
	  case "${answer}" in
		  [Yy])
	          echo "A instalar o pacote gdebi..."
		  sudo apt install gdebi-core -y
		  echo "Instalação o pacote gdebi concluida"
esac
fi
cd #HOME/Transferências/
echo "3 | Verificar a instalação do protonmail-bridge no sistema..."
  which protonmail-bridge &> /dev/null
if [ $? -eq 0 ]
  then
          echo "Instalação do pacote protonmail-bridge concluida!"
  else
	  echo "3 | A instalar o pacote protonmail-bridge..."
          sudo gdebi protonmail-bridge_1.5.7-1_amd64.deb -y
  else
	  sudo gdebi-gtk protonmail-bridge_1.5.7-1_amd64.deb -y
fi
echo "4 | Verificar pacote gnupg no sistema..."
whereis gnupg &> /dev/null
if [ $? -eq 0 ]
  then
	  echo "Instalação do pacote gnupg concluida!"
  else
	  echo "4 | A instalar o pacote gnupg..."
	  sudo apt install gnupg
fi
	  echo "Criar nova chave..."
	  gpg --gen-key
echo "5 | A Verificar o pacote pass no sistema..."
which pass &> /dev/null
if [ $? -eq 0 ]
  then
	  echo "Pacote pass já está instalado no sistema!"
  else
	  echo "Pacote pass não está instalado!"
	  echo "Queres instalar o pacote pass (y/n)?"
	  read -r answer
	  case "${answer}" in 
		  [Yy])
	          echo "A instalar o pacote pass..."
		  sudo apt install pass -y
esac
fi
which pass &> /dev/null
if [ $? -eq 0 ]
  then
	  echo "Instalação do pacote pass concluida!"
  else
	  echo "Erro na instalação!"
fi
echo "5 | Gerar nova chave no pass..."
read -p "Por favor introduza o email: "  variable_mail
pass init $variable_mail
pass generate email_bridge/$variable_mail \15
echo "Instalação e configuração do Proton_bridge concluida!"



