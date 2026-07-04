# Prática 6: Cálculo de Pi por Leibniz em arquitetura dual-core de memória compartilhada

## Overview
Este projeto explora o desenvolvimento de uma arquitetura multicore com memória compartilhada utilizando os kits Zybo da Xilinx (chip Zynq). O objetivo principal é acelerar o cálculo do número $\pi$ pelo método da **Série de Leibniz**, dividindo a carga de trabalho entre os dois processadores ARM Cortex-A9 presentes na placa e utilizando uma memória BRAM na FPGA para a comunicação e sincronização dos resultados.

## Project Description
A prática (referenciada como Prática 4 nos roteiros originais) envolve uma abordagem de co-design hardware/software utilizando as ferramentas Vivado e Vitis/SDK:
1. **Design de Hardware (Vivado)**:
   - Configuração do **Processing System (PS)** do Zynq, que contém o processador dual-core ARM Cortex-A9 operando a 665 MHz.
   - Instanciação de uma memória **BRAM (Block RAM)** no lado da lógica programável (**PL** - FPGA Artix-7).
   - Conexão da BRAM ao processador através de um controlador AXI e barramento `AXI SmartConnect`.

2. **Design de Software (Vitis/SDK)**:
   - O cálculo da série de Leibniz ($\pi = 4 \sum_{k=0}^{\infty} \frac{(-1)^k}{2k + 1}$) com $10.000.000$ de iterações é paralelizado dividindo a série pela metade.
   - **Core 1**: Processa a primeira metade da série (índices 0 a $N/2 - 1$). Grava o seu subtotal na BRAM (no endereço base `0x40000000`) e sinaliza a conclusão configurando uma "flag" no endereço `0x40000004`.
   - **Core 0**: Processa a segunda metade da série (índices $N/2$ a $N - 1$). Fica em *busy-wait* aguardando a flag ser ativada na BRAM pelo Core 1. Após a ativação, ele soma o seu subtotal ao subtotal do Core 1, multiplica o resultado por 4 e exibe o valor final de $\pi$.
   - **Sincronização e Cache**: Para garantir a coerência dos dados na BRAM compartilhada e evitar problemas de concorrência, o cache de dados (`Xil_DCacheDisable()`) é desabilitado em ambos os núcleos. O Core 1 grava seu resultado antes de levantar a flag, garantindo uma sincronização segura (*producer-consumer*).

## Principais Resultados e Etapas
- **Modelagem RTL / Blocos**: Criação de um sistema onde a memória da FPGA funciona como ponte de comunicação entre os núcleos de processamento.
- **Desenvolvimento Multicore Assíncrono**: Execução simultânea de rotinas C independentes (`app_core0` e `app_core1`), que não sobrepõem os endereços de memória executável, utilizando ponteiros `volatile` para acesso direto à memória física da BRAM.
- **Sincronização Bare-Metal**: O projeto comprova o ganho de desempenho alcançado pela quebra da dependência sequencial, calculando um limite computacional intenso através de um ambiente embarcado dual-core operando de forma paralela e cooperativa.

---
*Estudos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
