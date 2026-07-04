# Prática 3: Game of Life (Jogo da Vida de Conway) em FPGA

## Overview
Este projeto consiste na implementação acelerada em hardware do clássico autômato celular de Conway (**Jogo da Vida**), usando uma placa FPGA DE10 e renderização em tempo real via interface gráfica VGA (resolução de 640x480). O objetivo é explorar técnicas de computação de alto desempenho em hardware, incluindo pipeline de múltiplos estágios, otimizações de endereçamento de memória sem multiplicadores e controle de concorrência.

## Project Description
De acordo com o relatório da prática 3 (`Relatorio3_ArquiteturaAltoDesempenho.txt`), a implementação baseia-se em dois módulos principais executados em paralelo:
1. **Máquina de Estados Finita (FSM)** – Controla o avanço das gerações da matriz de 64x64 células (armazenada em um registrador plano de 4096 posições `[4095:0]`). O processamento ocorre em um **pipeline de 4 estágios**:
   - **Estágio 1**: Determina a localização espacial (conversão de índice plano para linha e coluna usando fatiamento de bits rápidos, eliminando divisores).
   - **Estágio 2 e 3**: Calcula as condições de contorno e realiza a soma combinacional do estado dos 8 vizinhos imediatos (vizinhança de Moore).
   - **Estágio 4**: Aplica as regras do Jogo da Vida (Solidão, Superpopulação, Sobrevivência e Reprodução) com lógica ternária e salva os novos estados no buffer futuro `next_grid` sem causar mutações na grade atual durante a leitura.
2. **Interface VGA e Controlador LifeToVGA** – Renderiza as células em blocos visuais de 6x6 pixels centralizados na tela de 640x480. Para traduzir as coordenadas bidimensionais de tela de volta para o endereço físico unidimensional da memória, o circuito utiliza a potência de 2 (64 colunas) para concatenar diretamente os bits de linha e coluna, suprimindo o uso de multiplicadores matemáticos pesados.
3. **Divisor de Frequência** – O controlador VGA opera em alta frequência (25 MHz), enquanto a evolução das gerações é reduzida via divisor de clock a fim de permitir uma taxa de atualização compatível com a visão humana.

## How to Compile with Quartus
1. **Descompactar o Arquivo** – Caso utilize a versão compactada, extraia o arquivo `Pratica_JogoDaVida.rar` no diretório do projeto.
2. **Abrir o Projeto no Quartus** – Inicie o Quartus Prime e abra o arquivo de projeto correspondente (ex: `.qpf`) dentro da pasta descompactada.
3. **Compilar o Projeto** – Clique em **Processing → Start Compilation**. Certifique-se de que a análise lógica e a síntese sejam finalizadas sem erros.
4. **Gerar Arquivo SOF** – O arquivo de programação `.sof` será gerado automaticamente após a compilação completa.

## Programming the FPGA
1. Conecte a placa DE10 à porta USB do seu computador usando o cabo USB-Blaster.
2. Abra o **Programmer** no Quartus, certifique-se de que a placa é reconhecida, selecione o arquivo `.sof` e clique em **Start**.

## Expected Results
- O monitor exibirá a grade 64x64 centralizada.
- Ao reiniciar o sistema (botão Reset), a semente inicial é configurada e passa a evoluir dinamicamente de acordo com as regras de Moore.
- A animação ocorre de forma fluida, livre de *glitches* ou perda de sincronismo, graças ao isolamento dos domínios de frequência.

---
*Projeto desenvolvido para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
