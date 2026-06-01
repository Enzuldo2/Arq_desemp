# Filtro 3 – Morfologia de Imagens

## Overview
Este projeto implementa filtros morfológicos **máximo** e **mínimo** (dilatação e erosão) para imagens binárias em uma placa FPGA DE10. O objetivo é demonstrar o ganho de desempenho obtido ao mover a filtragem de imagens do domínio de software para hardware reconfigurável, processando um fluxo de vídeo em tempo real.

## Project Description
O relatório da prática 2 (Relatório2_ArquiteturaAltoDesempenho.txt) descreve a implementação de um sistema de filtragem espacial 3×3 que opera diretamente no fluxo de pixels fornecido por um controlador VGA. As principais funcionalidades são:
- **Filtro de Mínimo (Erosão)** – porta lógica AND de múltiplas entradas que produz `1` somente se todos os vizinhos são `1`.
- **Filtro de Máximo (Dilatação)** – porta lógica OR que produz `1` se ao menos um vizinho é `1`.
- **Detecção de Bordas (Sobel simplificado)** – cálculo de gradientes usando operações de deslocamento em vez de multiplicação.
- **Comutação de visualização** – chaves físicas permitem alternar entre a imagem original e a filtrada.

O pipeline utiliza **line buffers** (registradores de deslocamento) para manter as linhas anteriores da imagem, permitindo a formação da janela 3×3 em cada ciclo de clock.

## How to Compile with Quartus
1. **Open the Project** – In Quartus Prime, select **File → Open Project** and navigate to `c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/filtro_3/filtro_3.qpf` (the project file generated previously).
2. **Set the Device** – Ensure the target device is **Cyclone V (10CL016YU256)**, which matches the DE10 board.
3. **Add Sources** – The Verilog source files (`filtro.v`, `router.v`, `core.v`, `vga_sync.v`, etc.) should already be listed under *Files*.
4. **Compile** – Click **Processing → Start Compilation**. Wait for the synthesis, fitting and assembly steps to complete without errors.
5. **Generate Programming File** – After a successful compile, go to **File → Convert Programming Files** and generate a `.sof` file.

## Programming the FPGA
1. Connect the DE10 board via USB‑Blaster.
2. Open **Programmer**, add the generated `.sof` file, select the hardware device, and click **Start**.

## Running the Design
- Power the board; the VGA connector will output a 640×480 video signal.
- Use the on‑board switches to select: original image, minimum filter, maximum filter, or Sobel edge detection.
- Observe the processed image on a monitor. The filters operate at the full pixel clock (≈25 MHz), providing real‑time processing.

## Expected Results
- **Erosão** removes isolated white noise and shrinks objects.
- **Dilatação** expands white regions and fills small holes.
- **Sobel** highlights edges with a gradient approximation.
- Switching between modes is instantaneous, demonstrating the low latency of the hardware pipeline.

---
*All Verilog files and the Quartus project were developed for the **Arquitetura de Alto Desempenho** course (UFSCar, 2026).*
