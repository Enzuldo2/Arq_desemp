# Prática 1 & 2: Cálculo de Pi por Monte Carlo e Série de Leibniz

## Overview
Este projeto aborda o estudo de arquiteturas de alto desempenho através da implementação de dois métodos matemáticos clássicos para estimar o valor de $\pi$: o método probabilístico de **Monte Carlo** e o método determinístico da **Série de Leibniz**. As análises contrastam a execução puramente serial com otimizações em nível de dados (**Vetorização/SIMD**) e em nível de processador (**Multiprocessamento/MIMD**) nos ambientes Octave e Python.

## Project Description
Baseado no relatório unificado das Práticas 1 e 2 (`Relatorio1_ArquiteturaAltoDesempenho.txt`), o projeto consiste na avaliação de:
1. **Método de Monte Carlo** – Amostragem estatística gerando pontos aleatórios $(x,y)$ em um quadrado unitário e verificando a fração de pontos internos ao quarto de círculo inscrito ($x^2 + y^2 \leq 1$).
2. **Série de Leibniz** – Expansão determinística alternada baseada na série de Taylor para a função $\arctan(1)$:
   $$\pi = 4 \sum_{k=0}^{\infty} \frac{(-1)^k}{2k + 1}$$
3. **Paradigmas Analisados**:
   - **Serial**: Laço de repetição procedural tradicional (laços `for` em Python e Octave). Sofre grande gargalo de interpretação da linguagem.
   - **Vetorizado (SIMD)**: Substituição dos laços explícitos por operações com vetores de uma vez (usando o núcleo nativo em Octave e a biblioteca **NumPy** em Python). Reduz o *overhead* de interpretação e dispara instruções vetoriais no processador.
   - **Multi-Core (MIMD)**: Divisão de blocos de trabalho concorrentes utilizando a biblioteca `multiprocessing` do Python em múltiplos núcleos.

## Principais Resultados de Benchmarks
- **Octave (Monte Carlo)**: O speedup da versão vetorizada atingiu **466,79x** sobre a versão serial (150.000 pontos).
- **Octave (Leibniz)**: A vetorização obteve speedups médios de **34x** a **59x** em relação à computação sequencial.
- **Python (Monte Carlo - 10M pontos)**: A versão vetorial (NumPy) foi **6,14x** mais rápida que a serial, e a paralela com 8 núcleos físicos atingiu **7,74x** de speedup global.
- **Python (Leibniz - 10M termos)**: A versão multi-core superou a vetorizada à medida que a carga computacional aumentou, atingindo um speedup de **22,06x** sobre o código serial e comprovando as previsões da **Lei de Amdahl**.

---
*Estudos desenvolvidos para a disciplina **Arquiteturas de Alto Desempenho** (UFSCar, 2026).*
