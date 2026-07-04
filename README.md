# Arquitetura de Desempenho – Projetos de Aula

Este repositório contém todos os projetos teóricos e práticos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026), ministrada pelo Prof. Dr. Emerson Carlos Pedrino. Os designs e simulações exploram a fundo paralelismo em CPU (SIMD/MIMD), aceleração massiva em GPU (CUDA) e lógica de hardware reconfigurável (FPGA).

## Estrutura do Repositório

- Projeto 1: Estudos de concorrência, vetorização SIMD em Octave e multiprocessamento em Python aplicados à simulação de Monte Carlo e Série de Leibniz.
- Projeto 2: Implementação acelerada em hardware do **Jogo da Vida de Conway** (matriz 64x64) com pipeline de 4 estágios, renderização VGA integrada e otimizações de indexação por fatiamento de bits (sem multiplicadores) em FPGA DE10.
- Projeto 3: Sistema de processamento de vídeo em tempo real contendo filtros morfológicos de **Máximo** (Dilatação) e **Mínimo** (Erosão) em uma janela 3x3 (line buffers), além de detector de bordas **Sobel** simplificado em hardware.
- Projeto 4: Rede em Malha 4x4 (Network-on-Chip - NoC) com algoritmo de roteamento XY estruturado em serpente para a aplicação distribuída e paralela de filtragem digital de imagens nos nós (cores).
- Projeto 5:
- Projeto 6: Implementação de arquitetura dual-core de memória compartilhada em FPGA Xilinx Zynq para aceleração do cálculo de Pi pela **Série de Leibniz**. Utiliza dois núcleos bare-metal ARM Cortex-A9 com divisão do processamento e sincronização de dados via comunicação por BRAM compartilhada.
- Projeto 7: Cálculo do valor de **π** pelo método de Monte Carlo com paralelismo em memória distribuída via **MPI** (mpi4py), comparando execução serial, MPI com loop puro e MPI vetorizado com NumPy (SIMD).

## Compilação e Execução Geral

### Projetos de Hardware (FPGA DE10)
1. Abra o arquivo do projeto (`.qpf`) no **Intel Quartus Prime**.
2. Execute a compilação completa (**Processing → Start Compilation**).
3. Transfira o arquivo `.sof` resultante para a placa usando o **Programmer** via USB-Blaster.
4. Conecte um monitor VGA e controle as saídas por meio dos switches e push-buttons físicos.

### Projetos de Software (Software & GPU Benchmarks)
- Os códigos-fonte de benchmark da Prática 1/2 e Prática 5 encontram-se nos respectivos diretórios e podem ser executados através do terminal Python, requerendo `numpy`, `torch` (PyTorch) e `numba` para suporte à aceleração por hardware CUDA.

Consulte os arquivos `README.md` específicos dentro de cada diretório para obter detalhes avançados de implementação científica e análise de tempos de cada prática.

