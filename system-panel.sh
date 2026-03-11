#!/usr/bin/env bash
# ===============================
# Painel de Monitoramento do Sistema
# Exibe informações em tempo real sobre usuários, data/hora, CPU, memória,
# armazenamento, rede e temperatura.
# ===============================

set -u

DEFAULT_INTERVAL=5
PING_TARGET="8.8.8.8"

usage() {
	cat <<USAGE
Uso: $(basename "$0") [opções]

Opções:
  -i, --intervalo SEG   Intervalo de atualização em segundos (padrão: ${DEFAULT_INTERVAL})
  -t, --target HOST     Host/IP para teste de conectividade (padrão: ${PING_TARGET})
  -h, --help            Exibe esta ajuda
USAGE
}

interval="$DEFAULT_INTERVAL"
target="$PING_TARGET"

while [[ $# -gt 0 ]]; do
	case "$1" in
	-i|--intervalo)
		interval="${2:-}"
		shift 2
		;;
	-t|--target)
		target="${2:-}"
		shift 2
		;;
	-h|--help)
		usage
		exit 0
		;;
	*)
		echo "Opção inválida: $1" >&2
		usage >&2
		exit 1
		;;
	esac
done

if ! [[ "$interval" =~ ^[1-9][0-9]*$ ]]; then
	echo "Intervalo inválido: '$interval'. Use um inteiro positivo." >&2
	exit 1
fi

print_section() {
	printf '\n== %s ==\n' "$1"
}

has_cmd() {
	command -v "$1" >/dev/null 2>&1
}

cleanup() {
	echo
	echo "Encerrando monitoramento..."
}

trap cleanup INT TERM

while true; do
	clear
	printf 'System Panel - %s\n' "$(hostname)"
	printf 'Atualizado em: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')"

	print_section "Usuários ativos"
	who || echo "Não foi possível coletar usuários ativos."

	print_section "CPU / Uptime"
	uptime || echo "Não foi possível coletar informações de CPU/uptime."

	print_section "Memória"
	if has_cmd free; then
		free -h | awk 'NR==1 || /^Mem:/ || /^Swap:/'
	else
		echo "Comando 'free' indisponível."
	fi

	print_section "Armazenamento"
	if has_cmd df; then
		df -h --output=source,size,used,avail,pcent,target | awk 'NR==1 || $1 ~ /^\/dev\//'
	else
		echo "Comando 'df' indisponível."
	fi

	print_section "Rede"
	if has_cmd ip; then
		ip -br a | awk '$1 != "lo"'
	else
		echo "Comando 'ip' indisponível."
	fi

	if has_cmd ping; then
		if ping -c1 -W1 "$target" >/dev/null 2>&1; then
			echo "Conectividade ($target): Online"
		else
			echo "Conectividade ($target): Offline"
		fi
	else
		echo "Comando 'ping' indisponível."
	fi

	print_section "Temperatura"
	if has_cmd sensors; then
		sensors | awk '/Core|Package id|temp[0-9]+/'
	else
		echo "Pacote lm-sensors não encontrado (comando 'sensors')."
	fi

	printf '\nPróxima atualização em %ss (Ctrl+C para sair)\n' "$interval"
	sleep "$interval"
done
