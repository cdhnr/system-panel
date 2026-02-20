#!/bin/bash

while true; do
	clear
	echo " System Painel "
	echo

	echo " Usuários ativos "
	who
	echo

	echo " Data/Hora: $(date)"
	echo

	echo " CPU/Uptime "
	uptime
	echo

	echo " Memória "
	free -h | grep -E "Mem|Swap"
	echo

	echo " Armazenamento "
	df -h --output=source,size,used,avail,pcent,target | awk 'NR==1 || $1 ~ /^\/dev\//'
	echo

	echo " Rede "
	ip -br a | grep -v "lo"
	if ping -c1 8.8.8.8 &>/dev/null; then
		echo "Internet: Online"
	else
		echo "Internet: Offline"
	fi
	echo

	echo " Temperatura "
	sensors | grep -E "Core|temp"
	echo

	echo "Atualiza a cada 5s (Ctrl+C para sair)"
	sleep 5
done
