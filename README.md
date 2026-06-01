# Arquitetura de Desempenho – Projetos de Aula

Este repositório contém todos os projetos teóricos e práticos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026), ministrada pelo Prof. Dr. Emerson Carlos Pedrino. Os designs e simulações exploram a fundo paralelismo em CPU (SIMD/MIMD), aceleração massiva em GPU (CUDA) e lógica de hardware reconfigurável (FPGA).

## Estrutura do Repositório

- [pratica_1/](file:///c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/pratica_1/) – Estudos de concorrência, vetorização SIMD em Octave e multiprocessamento em Python aplicados à simulação de Monte Carlo e Série de Leibniz.
- [Pratica_JogoDaVida/](file:///c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/Pratica_JogoDaVida/) – Implementação acelerada em hardware do **Jogo da Vida de Conway** (matriz 64x64) com pipeline de 4 estágios, renderização VGA integrada e otimizações de indexação por fatiamento de bits (sem multiplicadores) em FPGA DE10.
- [filtro_3/](file:///c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/filtro_3/) – Sistema de processamento de vídeo em tempo real contendo filtros morfológicos de **Máximo** (Dilatação) e **Mínimo** (Erosão) em uma janela 3x3 (line buffers), além de detector de bordas **Sobel** simplificado em hardware.
- [mesh_pdi/](file:///c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/mesh_pdi/) – Rede em Malha 4x4 (Network-on-Chip - NoC) com algoritmo de roteamento XY estruturado em serpente para a aplicação distribuída e paralela de filtragem digital de imagens nos nós (cores).
- [pratica_5/](file:///c:/Users/mufas/OneDrive/Área de Trabalho/Faculdade/Arq_desemp/Arq_desemp/pratica_5/) – Benchmarks de computação paralela em GPU (NVIDIA RTX 3060) para Transformada Rápida de Fourier (FFT) tridimensional e o cálculo de Fractal do Conjunto de Mandelbrot, comparando vetorização clássica com a compilação JIT de kernels customizados (Numba CUDA).

## Compilação e Execução Geral

### Projetos de Hardware (FPGA DE10)
1. Abra o arquivo do projeto (`.qpf`) no **Intel Quartus Prime**.
2. Execute a compilação completa (**Processing → Start Compilation**).
3. Transfira o arquivo `.sof` resultante para a placa usando o **Programmer** via USB-Blaster.
4. Conecte um monitor VGA e controle as saídas por meio dos switches e push-buttons físicos.

### Projetos de Software (Software & GPU Benchmarks)
- Os códigos-fonte de benchmark da Prática 1/2 e Prática 5 encontram-se nos respectivos diretórios e podem ser executados através do terminal Python, requerendo `numpy`, `torch` (PyTorch) e `numba` para suporte à aceleração por hardware CUDA.

Consulte os arquivos `README.md` específicos dentro de cada diretório para obter detalhes avançados de implementação científica e análise de tempos de cada prática.

---
**Mantido e desenvolvido por Enzuldo2 (A Enzuldo2).**
