# System Panel

![Shell](https://img.shields.io/badge/Shell-Bash-121011?style=for-the-badge&logo=gnubash&logoColor=white)
![Status](https://img.shields.io/badge/status-active-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

## Descrição

Script em **Shell (Bash)** que cria um painel de monitoramento em tempo real no terminal. O programa exibe informações do sistema como usuários ativos, uso de CPU, memória, armazenamento, rede e temperatura, atualizando automaticamente a cada 5 segundos.

O objetivo é fornecer uma visualização rápida e leve do estado da máquina diretamente no terminal.

> Atenção: a leitura de temperatura requer o pacote `lm-sensors` instalado no sistema.

---

## Estrutura sugerida de pastas

```
README.md
LICENSE
└── system-panel.sh
```

---

## Funcionalidades

O painel exibe:

- Usuários logados no sistema
- Data e hora atual
- Uptime e carga da CPU
- Uso de memória RAM e swap
- Uso de armazenamento em disco
- Interfaces de rede e status da internet
- Temperatura do hardware
- Atualização automática a cada 5 segundos

---

## Instalação (passo a passo)

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/system-panel.git
cd system-panel
```

2. Dê permissão de execução ao script:

```bash
chmod +x system-panel.sh
```

3. Execute:

```bash
./system-panel.sh
```

Para encerrar o monitoramento:

```
Ctrl + C
```

---

## Dependências

Ferramentas utilizadas (geralmente já presentes em Linux):

```
bash
coreutils
iproute2
lm-sensors (opcional)
```

### Instalar lm-sensors (Ubuntu/Debian)

```bash
sudo apt install lm-sensors
sudo sensors-detect
```

---

## Funcionamento interno

O script executa um loop infinito que:

1. Limpa o terminal
2. Coleta métricas do sistema com comandos nativos
3. Exibe os dados organizados em painel
4. Aguarda 5 segundos
5. Repete o processo

Esse ciclo mantém o monitoramento em tempo real.

---

## Boas práticas implementadas

- Uso de comandos nativos leves
- Atualização periódica controlada
- Verificação de conectividade com internet
- Filtragem de informações relevantes
- Exibição organizada para leitura rápida

---
