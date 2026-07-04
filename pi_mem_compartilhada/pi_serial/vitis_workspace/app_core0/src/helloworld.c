#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_cache.h"

#define BRAM_BASE_ADDR 0x40000000
#define BRAM_FLAG_ADDR 0x40000004
#define TOTAL_ITERATIONS 10000000

int main() {
    init_platform();
    Xil_DCacheDisable(); // Desativa o cache para evitar problemas de leitura

    printf("\n\r[CORE 0] Iniciando calculo da segunda metade...\n\r");

    volatile float *shared_pi = (float *)BRAM_BASE_ADDR;
    volatile int *flag = (int *)BRAM_FLAG_ADDR;

    // A linha "*flag = 0;" foi removida para evitar a condição de corrida!

    float partial_sum = 0.0;
    
    // Como começamos da metade, precisamos descobrir o sinal correto
    int sign = ((TOTAL_ITERATIONS / 2) % 2 == 0) ? 1 : -1;

    // Core 0 faz a segunda metade do trabalho
    for (int n = TOTAL_ITERATIONS / 2; n < TOTAL_ITERATIONS; n++) {
        partial_sum += sign * (1.0 / (2.0 * n + 1.0));
        sign = -sign;
    }

    // Fica em loop infinito até o Core 1 levantar a bandeira na BRAM
    while (*flag == 0) {
        // Aguardando o Core 1...
    }

    // Junta as duas metades e multiplica por 4, conforme a fórmula de Leibniz
    float total_pi = 4.0 * (partial_sum + *shared_pi);

    printf("[CORE 0] --- Calculo Multicore Finalizado ---\n\r");
    printf("[CORE 0] Valor final de PI (Leibniz com %d iteracoes): %f\n\r", TOTAL_ITERATIONS, total_pi);

    cleanup_platform();
    return 0;
}