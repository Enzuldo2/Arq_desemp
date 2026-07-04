import sys, io, random, math
from mpi4py import MPI
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

NUCLEOS_FISICOS = 6  # nucleos fisicos da maquina, limita o speedup ideal na tabela

def monte_carlo_loop(semente, n):
    # calcula acertos usando loop sequencial puro, ponto a ponto
    random.seed(semente)
    acertos = 0
    for _ in range(n):
        x, y = random.random(), random.random()
        if x*x + y*y <= 1.0:
            acertos += 1
    return acertos

def monte_carlo_numpy(semente, n):
    # calcula acertos usando numpy vetorizado: gera todos os pontos de uma vez
    rng = np.random.default_rng(semente)
    p = rng.random((n, 2))
    return int(np.sum(p[:,0]**2 + p[:,1]**2 <= 1.0))

def rodar_mpi(comm, rank, size, sementes, TAM_BLOCO, N_TOTAL, processos_alvo, tempo_serial, func):
    # executa o benchmark MPI para cada valor de p em processos_alvo
    lista_p, lista_tempos, lista_pi = [], [], []
    for p in processos_alvo:
        if p > size:
            if rank == 0:
                print(f"  AVISO: p={p} pulado ({size} disponiveis)")
            continue
        # divide os processos: os primeiros p trabalham, os demais ficam ociosos
        cor = 0 if rank < p else MPI.UNDEFINED
        sub = comm.Split(cor, rank)
        if cor == 0:
            sr = sub.Get_rank()
            n_blocos = len(sementes) // p
            b_ini, b_fim = sr * n_blocos, sr * n_blocos + n_blocos
            #Para sincronização, garantindo que os processos comecem ao mesmo tempo
            sub.Barrier()
            t0 = MPI.Wtime()
            # cada processo calcula seu conjunto de blocos
            acertos = sum(func(sementes[b], TAM_BLOCO) for b in range(b_ini, b_fim))
            t_local = MPI.Wtime() - t0
            # coleta soma global de acertos e o maior tempo entre os processos
            acertos_total = sub.reduce(acertos, op=MPI.SUM, root=0)
            t_max = sub.reduce(t_local, op=MPI.MAX, root=0)
            if sr == 0:
                pi = 4.0 * acertos_total / N_TOTAL
                sp = tempo_serial / t_max if t_max > 0 else 0
                lista_p.append(p)
                lista_tempos.append(t_max)
                lista_pi.append(pi)
                print(f"  p={p:3d}  ->  {t_max:.4f}s  |  Speedup: {sp:.4f}x")
        if sub != MPI.COMM_NULL:
            sub.Free()
        #Impede que alguns processos avancem para a próxima iteração enquanto alguns ainda estão terminando de ser executados na atual iteração
        comm.Barrier()

    return lista_p, lista_tempos, lista_pi

def gerar_imagens(t_s, pi_s, err_s, lp, lt, lpi, lp_np, lt_np, lpi_np):
    matplotlib.rcParams['axes.unicode_minus'] = False
    def gera(nome, titulo, subtitulo, lista_p, lista_tempos, lista_pi):
        speedups = [t_s / t for t in lista_tempos]
        erros    = [abs(math.pi - pi) for pi in lista_pi]
        fig = plt.figure(figsize=(14, 11))
        gs  = GridSpec(3, 1, figure=fig, height_ratios=[1, 0.18, 0.55])
        fig.subplots_adjust(top=0.91, bottom=0.07, left=0.09, right=0.93, hspace=0.50)
        # grafico de speedup real
        ax1 = fig.add_subplot(gs[0])
        ax1.plot(lista_p, speedups, marker='o', color='#1f77b4', linewidth=2.8, markersize=8, label='Speedup Real')
        ax1.set_title(f"Analise de Speedup - {subtitulo}", fontsize=13, fontweight='bold', pad=12)
        ax1.set_xlabel("Numero de Processos (p)", fontsize=11)
        ax1.set_ylabel("Speedup Obtido", fontsize=11)
        ax1.set_xticks(lista_p)
        ax1.grid(True, linestyle='--', alpha=0.4)
        ax1.legend(loc='upper left', fontsize=11)

        # tabela do serial
        ax2 = fig.add_subplot(gs[1])
        ax2.axis('off')
        ax2.set_title("SERIAL", fontsize=12, fontweight='bold', color='#0d3b29', loc='left', pad=8)
        t = ax2.table(cellText=[[f"{t_s:.4f}s", f"{pi_s:.6f}", f"{err_s:.7f}"]],
                      colLabels=['Tempo (s)', 'pi Estimado', 'Erro Absoluto'],
                      loc='center', cellLoc='center', bbox=[0, 0, 1, 1])
        t.auto_set_font_size(False); t.set_fontsize(11); t.scale(1.0, 2.0)
        for c in range(3):
            t[0,c].set_text_props(weight='bold', color='white'); t[0,c].set_facecolor('#27ae60')
            t[1,c].set_facecolor('#ecf0f1')
        # tabela dos resultados MPI com speedup ideal limitado aos nucleos fisicos
        ax3 = fig.add_subplot(gs[2])
        ax3.axis('off')
        ax3.set_title(f"MPI - {subtitulo.upper()}", fontsize=12, fontweight='bold', color='#0c1f3f', loc='left', pad=8)
        cols   = ['Processos (p)', 'Tempo (s)', 'Speedup Real', 'Speedup Ideal', 'Erro Absoluto', 'pi Estimado']
        linhas = [[f"{p}", f"{lista_tempos[i]:.4f}s", f"{speedups[i]:.4f}x",
                   f"{min(float(p), float(NUCLEOS_FISICOS)):.1f}x",
                   f"{erros[i]:.7f}", f"{lista_pi[i]:.6f}"]
                  for i, p in enumerate(lista_p)]
        t2 = ax3.table(cellText=linhas, colLabels=cols, loc='center', cellLoc='center', bbox=[0, 0, 1, 1])
        t2.auto_set_font_size(False); t2.set_fontsize(11); t2.scale(1.0, 2.0)
        for c in range(len(cols)):
            t2[0,c].set_text_props(weight='bold', color='white'); t2[0,c].set_facecolor('#2c3e50')
        for r in range(1, len(linhas)+1):
            for c in range(len(cols)):
                t2[r,c].set_facecolor('#ecf0f1')
        fig.suptitle(titulo, fontsize=14, fontweight='bold', y=0.97)
        plt.savefig(nome, dpi=300, bbox_inches='tight')
        plt.close()
        print(f"  Imagem salva: {nome}")
    print("\nGerando imagens...")
    gera('sem_numpy.png', 'MPI Monte Carlo pi - Sem NumPy', 'Sem NumPy', lp,    lt,    lpi)
    gera('com_numpy.png', 'MPI Monte Carlo pi - Com NumPy', 'Com NumPy', lp_np, lt_np, lpi_np)
    print("Pronto!\n")

def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()
    N_TOTAL        = 500_000_000
    NUM_BLOCOS     = 1680
    TAM_BLOCO      = N_TOTAL // NUM_BLOCOS
    processos_alvo = [2, 4, 6, 8, 10, 12, 14, 16]
    # sementes fixas garantem que serial e paralelo processam os mesmos pontos
    sementes       = [(i * 999983) + 424242 for i in range(NUM_BLOCOS)]
    tempo_serial, pi_serial, erro_serial = 0.0, 0.0, 0.0
    comm.Barrier()
    if rank == 0:
        print(f"\n{'='*65}")
        print(f"  MONTE CARLO PI - MPI  |  Pool: {size} processos  |  N: {N_TOTAL:,}")
        print(f"{'='*65}")
        print("\n  [Serial baseline...]")
        t0           = MPI.Wtime()
        acertos      = sum(monte_carlo_loop(sementes[b], TAM_BLOCO) for b in range(NUM_BLOCOS))
        tempo_serial = MPI.Wtime() - t0
        pi_serial    = 4.0 * acertos / N_TOTAL
        erro_serial  = abs(math.pi - pi_serial)
        print(f"  Tempo: {tempo_serial:.4f}s  |  pi = {pi_serial:.6f}  |  Erro: {erro_serial:.7f}")
    comm.Barrier()
    # envia o tempo serial para todos os processos usarem no calculo de speedup
    tempo_serial = comm.bcast(tempo_serial if rank == 0 else None, root=0)
    if rank == 0: print("\n  [MPI sem numpy...]")
    lp, lt, lpi = rodar_mpi(comm, rank, size, sementes, TAM_BLOCO, N_TOTAL,
                             processos_alvo, tempo_serial, monte_carlo_loop)
    if rank == 0: print("\n  [MPI com numpy...]")
    lp_np, lt_np, lpi_np = rodar_mpi(comm, rank, size, sementes, TAM_BLOCO, N_TOTAL,
                                      processos_alvo, tempo_serial, monte_carlo_numpy)
    # apenas rank 0 gera as imagens, sem salvar nenhum arquivo intermediario
    if rank == 0:
        gerar_imagens(tempo_serial, pi_serial, erro_serial, lp, lt, lpi, lp_np, lt_np, lpi_np)
    comm.Barrier()

if __name__ == "__main__":
    main()