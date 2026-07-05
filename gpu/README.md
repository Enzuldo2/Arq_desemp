# Prática 5: Programação em GPU (MATLAB para Python)

## Overview
Este projeto implementa e avalia o desempenho de algoritmos de processamento de alto desempenho acelerados por hardware através de Unidades de Processamento Gráfico (**GPUs**). Focado na transição tecnológica do ecossistema proprietário MATLAB para o ambiente aberto **Python** utilizando **PyTorch** e **Numba JIT**, o projeto realiza a Transformada Rápida de Fourier (FFT) tridimensional e o cálculo do Fractal do **Conjunto de Mandelbrot** em uma GPU de última geração (**NVIDIA GeForce RTX 3060 Laptop GPU**).

## Project Description
A fundamentação matemática e computacional (conforme `pratica1.tex`) aborda os seguintes pontos chave:
1. **O Paradigma SIMT (Single Instruction, Multiple Threads)** – A exploração de milhares de núcleos CUDA simples executando simultaneamente tarefas repetitivas, superando o gargalo de largura de banda de memória (*memory wall*) das CPUs convencionais.
2. **Gargalo de Barramento PCIe** – Demonstração prática de que transferir dados continuamente entre CPU (Host) e GPU (Device) degrada severamente o ganho real de desempenho (*speedup*). A melhor estratégia consiste em alocar e gerar dados diretamente no device.
3. **Mapeamento do Plano Complexo de Mandelbrot**:
   - Resolução de grid $1000 \times 1000$ pixels e limite de 500 iterações avaliando o escape $|Z| > 2$ da órbita $Z_{n+1} = Z_n^2 + c$.
   - Comparação entre **GPU Vetorizada** (estilo `gpuArray` do MATLAB em PyTorch), que sofre gargalo de VRAM global por criar matrizes temporárias booleanas, e **Custom Element-wise Kernel JIT** (estilo `arrayfun` via Numba CUDA `vectorize`), que executa a recorrência inteiramente em registradores internos e cache L1 locais de cada thread, mitigando acessos à memória global.

## Resultados de Desempenho (RTX 3060 Laptop GPU)
- **Exercício 1 (FFT 3000x3000)**:
  - Tempo CPU Host (NumPy): `0.204728 s`
  - GPU Apenas Computação: `0.035245 s` (*Speedup puro de 5.81x*)
  - GPU Com Cópia de Barramento PCIe: `0.043008 s` (*Speedup cai para 4.76x due to overhead*)
  - GPU Geração Direta no Device (Otimizado): `0.013602 s` (**Speedup excepcional de 15.05x**)
- **Exercício 2 (Fractal de Mandelbrot)**:
  - CPU Serial: `41.0839 s` (*Referência*)
  - CPU Vetorizada (NumPy): `5.2300 s` (*7.9x mais rápido via SIMD de CPU*)
  - GPU Vetorizada (`gpuArray` / PyTorch): `0.2277 s` (*Speedup de 180.4x*)
  - GPU Custom Kernel (`arrayfun` / Numba CUDA JIT): `0.0185 s` (**Speedup massivo de 2220.8x** e ganho de **12.3x** sobre a própria GPU vetorizada, provando o caráter *Compute Bound* da solução compilada elemento a elemento).

---
*Estudos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
