# Mesh PDI – Processamento de Imagens em Rede em Malha (NoC)

## Overview
Este projeto implementa uma rede em malha (Network-on-Chip - NoC) com topologia 4x4 em Verilog, projetada para a aplicação de operações morfológicas (dilatação e erosão) em imagens binárias de forma distribuída. O objetivo é validar o uso de NoCs para coordenar fluxos de dados de alto desempenho e processamento estruturado em *streaming* com baixa latência em hardware reconfigurável (FPGA DE10).

## Project Description
Baseado no relatório da prática 4 (`Relatorio4_ArquiteturaAltoDesempenho.txt`), a arquitetura é estruturada em três níveis principais:
1. **Roteador (`router.v`)** – Roteador com cinco interfaces bidirecionais (Norte, Sul, Leste, Oeste e Local) operando com o algoritmo de roteamento XY (comunicação horizontal prioritária) e com caminho em serpente (*serpentine path*) para tráfego contínuo. Possui um barramento de 6 bits: `[5:4]` coordenada X, `[3:2]` coordenada Y, `[1]` indicador de validade (*Valid*) e `[0]` carga útil (*Pixel*). Possui arbitragem por prioridade fixa (`Core` > `Leste-Oeste` > `Norte-Sul`).
2. **Interfaces de Rede (`packeger.v` e `despackeger.v`)** – O empacotador insere coordenadas estáticas de destino aos pixels brutos. O desempacotador extrai a carga útil e a flag de validação na saída da NoC.
3. **Núcleo de Processamento (`core.v`)** – Cada um dos 16 nós possui um *core* acoplado à porta Local. O módulo usa *line buffers* (registradores de deslocamento de 256 bits) para obter uma janela móvel de 3x3 pixels. A filtragem é selecionável: Filtro de Mínimo (Erosão via AND lógico) ou Filtro de Máximo (Dilatação via OR lógico).

A integração *Top-Level* permite flexibilidade para configurar em qual linha da matriz os pacotes serão desviados para processamento ativo.

## How to Compile with Quartus
1. **Abrir o Projeto** – No Altera Quartus Prime, vá em **File → Open Project** e selecione o arquivo de projeto correspondente na pasta `mesh_pdi` (por exemplo, `mesh_pdi.qpf`).
2. **Configurar o Dispositivo** – Certifique-se de que a placa alvo selecionada é a **Cyclone V (5CSEBA6U23I7)** ou a correspondente à placa DE10 usada.
3. **Verificar os Arquivos Fonte** – Assegure-se de que todos os módulos descritos (`router.v`, `core.v`, `packeger.v`, `despackeger.v` e o arquivo *Top-Level*) estejam listados no projeto.
4. **Compilar** – Clique em **Processing → Start Compilation** e aguarde a conclusão da síntese, mapeamento e geração de arquivo.
5. **Geração do SOF** – Certifique-se de que o arquivo `.sof` foi gerado com sucesso no diretório de saída.

## Programming the FPGA
1. Conecte a placa FPGA DE10 ao computador via cabo USB (USB-Blaster).
2. Abra a ferramenta **Programmer** no Quartus.
3. Adicione o arquivo de programação `.sof` gerado.
4. Selecione a opção **Program/Configure** e clique em **Start**.

## Expected Results
- O sistema processa um fluxo contínuo de vídeo em tempo real, onde as imagens ruidosas de entrada são limpas através de sucessivas dilatações e erosões operadas na malha 4x4.
- A arquitetura permite a remoção eficiente de ruídos isolados e o preenchimento de buracos na imagem binária.
- O roteamento e processamento ocorrem concorrentemente com latência mínima, ilustrando as vantagens de escalabilidade e paralelismo espacial da NoC.

---
*Projeto desenvolvido para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
