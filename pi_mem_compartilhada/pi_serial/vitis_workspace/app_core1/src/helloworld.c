#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_cache.h"

// Endereços da nossa BRAM configurada no Vivado
#define BRAM_BASE_ADDR 0x40000000
#define BRAM_FLAG_ADDR 0x40000004
#define TOTAL_ITERATIONS 10000000

int main() {
    init_platform();
    Xil_DCacheDisable(); // Desativa o cache para evitar problemas de sincronia

    // Ponteiros apontando diretamente para a memória física da BRAM
    volatile float *shared_pi = (float *)BRAM_BASE_ADDR;
    volatile int *flag = (int *)BRAM_FLAG_ADDR;

    float partial_sum = 0.0;
    int sign = 1;

    // Core 1 faz a primeira metade do trabalho
    for (int n = 0; n < TOTAL_ITERATIONS / 2; n++) {
        partial_sum += sign * (1.0 / (2.0 * n + 1.0));
        sign = -sign;
    }

    // Salva o resultado na BRAM e avisa que terminou
    *shared_pi = partial_sum;
    *flag = 1;

    // --- PRINT ADICIONADO AQUI ---
    printf("[CORE 1] Core 1 finalizou! Subtotal calculado: %f\n\r", partial_sum);

    cleanup_platform();
    return 0;
}