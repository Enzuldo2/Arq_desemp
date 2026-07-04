# Prática 7: Cálculo de π por Monte Carlo com MPI

## Overview
Cálculo aproximado de π pelo método de Monte Carlo, comparando três abordagens: execução serial, MPI com loop puro e MPI vetorizado com NumPy. O objetivo é medir o *speedup* obtido ao aumentar o número de processos.

## Project Description
O script (`pratica.py`) roda em três fases dentro do mesmo ambiente MPI:
1. **Serial** – `rank 0` executa o cálculo completo com loop puro, servindo de baseline para o speedup.
2. **MPI sem NumPy** – para cada `p` em `{2, 4, 6, 8, 10, 12, 14, 16}`, os processos dividem o trabalho via `comm.Split()` e usam o mesmo loop puro.
3. **MPI com NumPy** – mesma divisão de trabalho, mas cada processo gera e verifica os pontos de forma vetorizada com NumPy.

O total de pontos (N = 500.000.000) é dividido em 1680 blocos com sementes fixas, garantindo que todas as configurações processem exatamente os mesmos pontos. Ao final, `rank 0` gera os gráficos `sem_numpy.png` e `com_numpy.png` com o speedup real de cada configuração.

## Requirements
- Python 3 com `mpi4py`, `numpy` e `matplotlib`
- Uma implementação MPI instalada:
  - **Windows**: [Microsoft MPI (MS-MPI)](https://www.microsoft.com/en-us/download/details.aspx?id=100593)
  - **Linux**: OpenMPI ou MPICH (via gerenciador de pacotes)

## How to Run
```bash
pip install mpi4py numpy matplotlib
mpiexec -n 16 python pratica.py
```

## Principais Resultados
Os arquivos `sem_numpy.png` e `com_numpy.png` são gerados com o speedup de cada configuração de `p`. O speedup cresce até `p = 12` (limite de núcleos/threads da máquina) e a versão com NumPy é consideravelmente mais rápida em termos absolutos, por combinar paralelismo entre processos com vetorização interna.

---
*Projeto desenvolvido para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
