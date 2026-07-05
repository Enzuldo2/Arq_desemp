# Prática 8: Snake Game em Bare-Metal ARM com Interface VGA

## Overview
Este projeto implementa o clássico Snake Game utilizando programação bare-metal em C para o processador ARM embarcado em uma FPGA (linha SoC da Intel/Altera, como a DE1-SoC). O objetivo principal é demonstrar o controle direto de periféricos de hardware, como o buffer de pixels VGA, o buffer de caracteres, botões físicos e o timer privado do ARM.

## Project Description
A prática envolve a interação direta com endereços de memória mapeados para os componentes de hardware através do ambiente *Altera Monitor Program*:
1. **Controle de Vídeo (VGA)**:
   - **Pixel Buffer**: Utilizado para desenhar o cenário, a cobrinha e as frutas. A renderização é feita escrevendo valores de cor (RGB565) diretamente nos endereços de memória do controlador de vídeo (`PIXEL_BUF_CTRL_BASE`). Foram desenvolvidos gráficos baseados em *sprites* customizados.
   - **Character Buffer**: Utilizado para renderizar textos na tela (`FPGA_CHAR_BASE`), como a pontuação (*Score*, *High Score* e *Level*) e mensagens de *Game Over*.

2. **Interação e Temporização**:
   - **ARM Private Timer**: Utilizado para controlar a velocidade do jogo (delay) e a taxa de atualização dos quadros, que acelera progressivamente conforme o jogador avança de nível.
   - **Push Buttons**: Os botões físicos da placa (`KEY_BASE`) são lidos em *polling* contínuo para alterar a direção da cobrinha de forma responsiva.

## Principais Resultados e Etapas
- **Máquina de Estados**: O jogo é estruturado em uma máquina de estados finitos (`STATE_MENU`, `STATE_PLAYING`, `STATE_GAMEOVER`) que gerencia o fluxo da aplicação de forma contínua e as transições de tela.
- **Lógica de Jogo Completa**: Implementação robusta do sistema de colisão (com as paredes limitantes e com o próprio corpo), geração pseudoaleatória de frutas garantindo espaços vazios, progressão de dificuldade e persistência em memória do recorde (*High Score*).
- **Programação Bare-Metal**: Aplicação de conceitos fundamentais de acesso ao hardware em baixo nível (sem o uso de sistema operacional), manipulando ponteiros `volatile` para registradores físicos do sistema.

---
*Estudos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
