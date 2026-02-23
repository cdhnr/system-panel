#!/bin/bash
# ===============================
# Painel de Monitoramento do Sistema
# Exibe informações em tempo real sobre usuários, data/hora, CPU, memória, armazenamento, rede e temperatura.
# Atualiza a cada 5 segundos.
# ===============================

while true; do
	# Limpa a tela a cada iteração para atualizar as informações
	clear
	echo " System Painel "
	echo

	# Exibe usuários atualmente logados
	echo " Usuários ativos "
	who
	echo

	# Mostra data e hora atuais
	echo " Data/Hora: $(date)"
	echo

	# Mostra informações de CPU e tempo de atividade do sistema
	echo " CPU/Uptime "
	uptime
	echo

	# Exibe uso de memória RAM e swap
	echo " Memória "
	free -h | grep -E "Mem|Swap"
	echo

	# Mostra uso de armazenamento apenas para dispositivos montados
	echo " Armazenamento "
	df -h --output=source,size,used,avail,pcent,target | awk 'NR==1 || $1 ~ /^\/dev\//'
	echo

	# Exibe interfaces de rede (exceto loopback) e status da internet
	echo " Rede "
	ip -br a | grep -v "lo"
	if ping -c1 8.8.8.8 &>/dev/null; then
		echo "Internet: Online"
	else
		echo "Internet: Offline"
	fi
	echo

	# Mostra temperaturas dos sensores (necessário pacote lm-sensors)
	echo " Temperatura "
	sensors | grep -E "Core|temp"
	echo

	# Mensagem de atualização e pausa de 5 segundos
	echo "Atualiza a cada 5s (Ctrl+C para sair)"
	sleep 5
done
