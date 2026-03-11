# System Panel

![Shell](https://img.shields.io/badge/Shell-Bash-121011?style=for-the-badge&logo=gnubash&logoColor=white)
![Status](https://img.shields.io/badge/status-active-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

## Descrição

Script em **Shell (Bash)** que cria um painel de monitoramento em tempo real no terminal. O programa exibe informações do sistema como usuários ativos, uso de CPU, memória, armazenamento, rede e temperatura.

## Melhorias implementadas nesta revisão

- ✅ Suporte a parâmetros de execução:
  - `--intervalo` para ajustar tempo de atualização
  - `--target` para trocar host de teste de conectividade
  - `--help` para ajuda rápida
- ✅ Validação de intervalo para evitar entrada inválida
- ✅ Fallbacks para comandos ausentes (`ip`, `ping`, `free`, `sensors`)
- ✅ Tratamento de encerramento com `Ctrl+C` via `trap`
- ✅ Saída com seções padronizadas e timestamp legível

---

## Estrutura

```text
README.md
LICENSE
system-panel.sh
```

---

## Funcionalidades

O painel exibe:

- Usuários logados no sistema
- Data e hora atual
- Uptime e carga da CPU
- Uso de memória RAM e swap
- Uso de armazenamento em disco
- Interfaces de rede e status de conectividade
- Temperatura do hardware (quando `lm-sensors` estiver disponível)
- Atualização automática por intervalo configurável

---

## Uso

1. Dê permissão de execução ao script:

```bash
chmod +x system-panel.sh
```

2. Execute com configuração padrão:

```bash
./system-panel.sh
```

3. Exemplos de uso com opções:

```bash
./system-panel.sh --intervalo 2
./system-panel.sh --target 1.1.1.1
./system-panel.sh --intervalo 3 --target 8.8.4.4
./system-panel.sh --help
```

Para encerrar o monitoramento:

```text
Ctrl + C
```

---

## Dependências

Ferramentas base (normalmente já presentes em Linux):

```text
bash
coreutils
iproute2
iputils-ping
procps
```

Dependência opcional para temperatura:

```text
lm-sensors
```

### Instalar `lm-sensors` (Ubuntu/Debian)

```bash
sudo apt install lm-sensors
sudo sensors-detect
```

---

## Sugestões de melhorias futuras

- Exportar métricas em JSON/CSV para integração com scripts externos
- Adicionar modo `--once` para execução única (útil para automação)
- Mostrar top processos por CPU e RAM
- Adicionar destaque de cores por faixas de uso (normal/alerta/crítico)
- Criar versão com `watch`/`tput` para layout mais rico mantendo Bash puro
