#include <stdint.h>
#include <stddef.h>
#include "address_map_arm.h"
#include "sprites.h"

/* =========================================================================
 * 1. DEFINES & CONSTANTES
 * ========================================================================= */
#define SCREEN_W 320
#define SCREEN_H 240
#define BLOCK_SIZE 16
#define GRID_X0 0
#define GRID_Y0 0
#define GRID_COLS 17
#define GRID_ROWS 15
#define MAX_SNAKE_LEN (GRID_COLS * GRID_ROWS)

#define BASE_DELAY_MS 200
#define MIN_DELAY_MS 50
#define DELAY_STEP 15

// Paleta RGB565
#define COL_BG         0x0841 // Verde muito escuro
#define COL_BORDER     0x07E0 // Verde neon
#define COL_SNAKE_HEAD 0x07E0 // Verde claro
#define COL_SNAKE_BODY 0x03E0 // Verde medio
#define COL_FOOD       0xF800 // Vermelho
#define COL_PANEL_BG   0x1082 // Cinza escuro
#define COL_GAMEOVER   0xF800 // Vermelho

/* =========================================================================
 * 2. CAMADA DE HARDWARE
 * ========================================================================= */

// Desenha um pixel no buffer VGA
static inline void plot_pixel(int x, int y, uint16_t color) {
    uint32_t pixel_buf_ptr = *(volatile uint32_t *) PIXEL_BUF_CTRL_BASE;
    uint32_t pixel_ptr = pixel_buf_ptr + (y << 10) + (x << 1);
    *(volatile uint16_t *) pixel_ptr = color;
}

// Le os botoes
static inline uint32_t read_keys(void) {
    volatile uint32_t *KEY_ptr = (volatile uint32_t *) KEY_BASE;
    return (*KEY_ptr) & 0xF;
}

// Escreve char no character buffer (80x60)
static void char_buf_putc(int col, int row, char c) {
    volatile char *char_buf = (volatile char *) FPGA_CHAR_BASE;
    *(char_buf + (row << 7) + col) = c;
}

// Escreve string no character buffer
static void char_buf_puts(int col, int row, const char *s) {
    while (*s) {
        char_buf_putc(col++, row, *s++);
    }
}

// Limpa character buffer
static void char_buf_clear(void) {
    for (int y = 0; y < 60; y++) {
        for (int x = 0; x < 80; x++) {
            char_buf_putc(x, y, ' ');
        }
    }
}

// Escreve numero inteiro no char buffer (2 digitos)
static void char_buf_put_int2(int col, int row, int val) {
    char_buf_putc(col, row, '0' + (val / 10) % 10);
    char_buf_putc(col + 1, row, '0' + (val % 10));
}

// Escreve numero inteiro no char buffer (4 digitos)
static void char_buf_put_int4(int col, int row, int val) {
    char_buf_putc(col, row, '0' + (val / 1000) % 10);
    char_buf_putc(col + 1, row, '0' + (val / 100) % 10);
    char_buf_putc(col + 2, row, '0' + (val / 10) % 10);
    char_buf_putc(col + 3, row, '0' + (val % 10));
}

// ARM Private Timer Delay
static void timer_delay_ms(int ms) {
    volatile uint32_t *timer_load = (volatile uint32_t *) MPCORE_PRIV_TIMER;
    volatile uint32_t *timer_ctrl = (volatile uint32_t *) (MPCORE_PRIV_TIMER + 0x08);
    volatile uint32_t *timer_int  = (volatile uint32_t *) (MPCORE_PRIV_TIMER + 0x0C);

    *timer_ctrl = 0; // Para timer
    *timer_load = ms * 200000; // ~200 MHz
    *timer_int = 1;  // Limpa int
    *timer_ctrl = 3; // Auto-reload = 0, En = 1

    while ((*timer_int & 1) == 0) {
        // Wait
    }
    *timer_int = 1;
    *timer_ctrl = 0;
}

/* =========================================================================
 * 3. RENDERIZACAO
 * ========================================================================= */

static void fill_rect(int x0, int y0, int w, int h, uint16_t color) {
    for (int y = y0; y < y0 + h && y < SCREEN_H; y++) {
        for (int x = x0; x < x0 + w && x < SCREEN_W; x++) {
            plot_pixel(x, y, color);
        }
    }
}

static void clear_screen(uint16_t color) {
    fill_rect(0, 0, SCREEN_W, SCREEN_H, color);
}

static inline uint16_t rgb(uint8_t r, uint8_t g, uint8_t b) {
    return (uint16_t)(((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3));
}

static void hline(int x0, int x1, int y, uint16_t color) {
    if (y < 0 || y >= SCREEN_H) return;
    for (int x = x0; x <= x1; x++)
        if (x >= 0 && x < SCREEN_W)
            plot_pixel(x, y, color);
}

static void vline(int x, int y0, int y1, uint16_t color) {
    if (x < 0 || x >= SCREEN_W) return;
    for (int y = y0; y <= y1; y++)
        if (y >= 0 && y < SCREEN_H)
            plot_pixel(x, y, color);
}

static void draw_rect(int x0, int y0, int w, int h, uint16_t color) {
    hline(x0, x0+w-1, y0,     color);
    hline(x0, x0+w-1, y0+h-1, color);
    vline(x0,     y0, y0+h-1, color);
    vline(x0+w-1, y0, y0+h-1, color);
}

static void char_buf_put_int(int col, int row, int val) {
    char buf[8];
    int i = 7;
    buf[7] = '\0';
    if (val == 0) { char_buf_putc(col, row, '0'); return; }
    while (val > 0 && i > 0) {
        buf[--i] = (char)('0' + (val % 10));
        val /= 10;
    }
    char_buf_puts(col, row, &buf[i]);
}

static const uint8_t FONT5X7[][7] = {
    /* ' ' */ {0x00,0x00,0x00,0x00,0x00,0x00,0x00},
    /* '!' */ {0x04,0x04,0x04,0x04,0x00,0x04,0x00},
    /* '"' */ {0x0A,0x0A,0x00,0x00,0x00,0x00,0x00},
    /* '#' */ {0x0A,0x1F,0x0A,0x0A,0x1F,0x0A,0x00},
    /* '$' */ {0x04,0x0F,0x14,0x0E,0x05,0x1E,0x04},
    /* '%' */ {0x18,0x19,0x02,0x04,0x08,0x13,0x03},
    /* '&' */ {0x0C,0x12,0x14,0x08,0x15,0x12,0x0D},
    /* ''' */ {0x06,0x04,0x08,0x00,0x00,0x00,0x00},
    /* '(' */ {0x02,0x04,0x08,0x08,0x08,0x04,0x02},
    /* ')' */ {0x08,0x04,0x02,0x02,0x02,0x04,0x08},
    /* '*' */ {0x00,0x04,0x15,0x0E,0x15,0x04,0x00},
    /* '+' */ {0x00,0x04,0x04,0x1F,0x04,0x04,0x00},
    /* ',' */ {0x00,0x00,0x00,0x00,0x06,0x04,0x08},
    /* '-' */ {0x00,0x00,0x00,0x1F,0x00,0x00,0x00},
    /* '.' */ {0x00,0x00,0x00,0x00,0x00,0x06,0x06},
    /* '/' */ {0x00,0x01,0x02,0x04,0x08,0x10,0x00},
    /* '0' */ {0x0E,0x11,0x13,0x15,0x19,0x11,0x0E},
    /* '1' */ {0x04,0x0C,0x04,0x04,0x04,0x04,0x0E},
    /* '2' */ {0x0E,0x11,0x01,0x06,0x08,0x10,0x1F},
    /* '3' */ {0x1F,0x02,0x04,0x02,0x01,0x11,0x0E},
    /* '4' */ {0x02,0x06,0x0A,0x12,0x1F,0x02,0x02},
    /* '5' */ {0x1F,0x10,0x1E,0x01,0x01,0x11,0x0E},
    /* '6' */ {0x06,0x08,0x10,0x1E,0x11,0x11,0x0E},
    /* '7' */ {0x1F,0x01,0x02,0x04,0x04,0x04,0x04},
    /* '8' */ {0x0E,0x11,0x11,0x0E,0x11,0x11,0x0E},
    /* '9' */ {0x0E,0x11,0x11,0x0F,0x01,0x02,0x0C},
    /* ':' */ {0x00,0x06,0x06,0x00,0x06,0x06,0x00},
    /* ';' */ {0x00,0x06,0x06,0x00,0x06,0x04,0x08},
    /* '<' */ {0x02,0x04,0x08,0x10,0x08,0x04,0x02},
    /* '=' */ {0x00,0x00,0x1F,0x00,0x1F,0x00,0x00},
    /* '>' */ {0x10,0x08,0x04,0x02,0x04,0x08,0x10},
    /* '?' */ {0x0E,0x11,0x01,0x06,0x04,0x00,0x04},
    /* '@' */ {0x0E,0x11,0x17,0x15,0x17,0x10,0x0F},
    /* 'A' */ {0x04,0x0A,0x11,0x11,0x1F,0x11,0x11},
    /* 'B' */ {0x1E,0x11,0x11,0x1E,0x11,0x11,0x1E},
    /* 'C' */ {0x0E,0x11,0x10,0x10,0x10,0x11,0x0E},
    /* 'D' */ {0x1C,0x12,0x11,0x11,0x11,0x12,0x1C},
    /* 'E' */ {0x1F,0x10,0x10,0x1E,0x10,0x10,0x1F},
    /* 'F' */ {0x1F,0x10,0x10,0x1E,0x10,0x10,0x10},
    /* 'G' */ {0x0E,0x11,0x10,0x17,0x11,0x11,0x0F},
    /* 'H' */ {0x11,0x11,0x11,0x1F,0x11,0x11,0x11},
    /* 'I' */ {0x0E,0x04,0x04,0x04,0x04,0x04,0x0E},
    /* 'J' */ {0x07,0x02,0x02,0x02,0x02,0x12,0x0C},
    /* 'K' */ {0x11,0x12,0x14,0x18,0x14,0x12,0x11},
    /* 'L' */ {0x10,0x10,0x10,0x10,0x10,0x10,0x1F},
    /* 'M' */ {0x11,0x1B,0x15,0x15,0x11,0x11,0x11},
    /* 'N' */ {0x11,0x19,0x15,0x13,0x11,0x11,0x11},
    /* 'O' */ {0x0E,0x11,0x11,0x11,0x11,0x11,0x0E},
    /* 'P' */ {0x1E,0x11,0x11,0x1E,0x10,0x10,0x10},
    /* 'Q' */ {0x0E,0x11,0x11,0x11,0x15,0x12,0x0D},
    /* 'R' */ {0x1E,0x11,0x11,0x1E,0x14,0x12,0x11},
    /* 'S' */ {0x0F,0x10,0x10,0x0E,0x01,0x01,0x1E},
    /* 'T' */ {0x1F,0x04,0x04,0x04,0x04,0x04,0x04},
    /* 'U' */ {0x11,0x11,0x11,0x11,0x11,0x11,0x0E},
    /* 'V' */ {0x11,0x11,0x11,0x11,0x0A,0x0A,0x04},
    /* 'W' */ {0x11,0x11,0x15,0x15,0x15,0x0A,0x0A},
    /* 'X' */ {0x11,0x11,0x0A,0x04,0x0A,0x11,0x11},
    /* 'Y' */ {0x11,0x11,0x0A,0x04,0x04,0x04,0x04},
    /* 'Z' */ {0x1F,0x01,0x02,0x04,0x08,0x10,0x1F},
};

static void draw_char_scaled(int px, int py, char c, int scale, uint16_t color) {
    if (c < 32 || c > 90) return;
    const uint8_t *glyph = FONT5X7[c - 32];
    for (int row = 0; row < 7; row++) {
        for (int col = 0; col < 5; col++) {
            if (glyph[row] & (0x10 >> col)) {
                fill_rect(px + col*scale, py + row*scale, scale, scale, color);
            }
        }
    }
}

static void draw_str_scaled(int px, int py, const char *s, int scale, uint16_t color) {
    while (*s) {
        draw_char_scaled(px, py, *s, scale, color);
        px += (5 + 1) * scale;
        s++;
    }
}

static void draw_border(void) {
    // Borda fina marrom escuro separando o tabuleiro do menu
    vline(GRID_X0 + GRID_COLS * BLOCK_SIZE, 0, SCREEN_H - 1, rgb(80, 40, 20));
    vline(GRID_X0 + GRID_COLS * BLOCK_SIZE + 1, 0, SCREEN_H - 1, rgb(80, 40, 20));
}

static void draw_bg_tile(int gx, int gy) {
    int x0 = GRID_X0 + gx * BLOCK_SIZE;
    int y0 = GRID_Y0 + gy * BLOCK_SIZE;
    const uint32_t *sprite = ((gx + gy) % 2 == 0) ? bg_light_arr : bg_dark_arr;
    
    for (int sy = 0; sy < 16; sy++) {
        for (int sx = 0; sx < 16; sx++) {
            uint32_t pixel = sprite[sy * 16 + sx];
            uint8_t r = pixel & 0xFF;
            uint8_t g = (pixel >> 8) & 0xFF;
            uint8_t b = (pixel >> 16) & 0xFF;
            uint16_t c16 = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
            plot_pixel(x0 + sx, y0 + sy, c16);
        }
    }
}

static void draw_board_bg(void) {
    for (int gy = 0; gy < GRID_ROWS; gy++) {
        for (int gx = 0; gx < GRID_COLS; gx++) {
            draw_bg_tile(gx, gy);
        }
    }
}

static void draw_splash_screen(void) {
    for (int y = 0; y < SCREEN_H; y++) {
        for (int x = 0; x < SCREEN_W; x++) {
            uint32_t pixel = start_game[y * SCREEN_W + x];
            uint8_t r = pixel & 0xFF;
            uint8_t g = (pixel >> 8) & 0xFF;
            uint8_t b = (pixel >> 16) & 0xFF;
            uint16_t c16 = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
            plot_pixel(x, y, c16);
        }
    }
}

static void draw_snake_block(int gx, int gy, uint16_t color) {
    int px = GRID_X0 + gx * BLOCK_SIZE;
    int py = GRID_Y0 + gy * BLOCK_SIZE;
    fill_rect(px, py, BLOCK_SIZE, BLOCK_SIZE, color);
    // Borda escura no bloco para profundidade
    fill_rect(px + BLOCK_SIZE - 1, py, 1, BLOCK_SIZE, COL_BG);
    fill_rect(px, py + BLOCK_SIZE - 1, BLOCK_SIZE, 1, COL_BG);
}

typedef enum { DIR_UP=0, DIR_DOWN=1, DIR_LEFT=2, DIR_RIGHT=3 } Direction;
typedef struct { int x; int y; Direction dir; } Point;

static void draw_sprite(int gx, int gy, const uint32_t *sprite, Direction dir) {
    int x0 = GRID_X0 + gx * BLOCK_SIZE;
    int y0 = GRID_Y0 + gy * BLOCK_SIZE;
    
    draw_bg_tile(gx, gy);
    
    for (int sy = 0; sy < 16; sy++) {
        for (int sx = 0; sx < 16; sx++) {
            uint32_t pixel = sprite[sy * 16 + sx];
            if ((pixel & 0xFF000000) == 0) continue;
            
            uint8_t r = pixel & 0xFF;
            uint8_t g = (pixel >> 8) & 0xFF;
            uint8_t b = (pixel >> 16) & 0xFF;
            uint16_t c16 = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
            
            int dx = sx, dy = sy; // Base aponta para DIR_RIGHT
            if (dir == DIR_DOWN) {
                dx = 15 - sy; dy = sx;
            } else if (dir == DIR_LEFT) {
                dx = 15 - sx; dy = 15 - sy;
            } else if (dir == DIR_UP) {
                dx = sy; dy = 15 - sx;
            }
            
            plot_pixel(x0 + dx, y0 + dy, c16);
        }
    }
}

static int current_fruit = 0;

static void draw_food(int gx, int gy) {
    draw_sprite(gx, gy, fruits[current_fruit], DIR_RIGHT);
}

static int high_score; // Forward declaration for update_hud

static void draw_hud_bg(void) {
    // Fundo do menu marrom claro
    fill_rect(GRID_X0 + GRID_COLS * BLOCK_SIZE + 2, 0, SCREEN_W, SCREEN_H, rgb(150, 100, 60));
}

static void update_hud(int score, int level) {
    char_buf_puts(72, 5, "SCORE");
    char_buf_put_int4(73, 7, score);
    
    char_buf_puts(69, 12, "HIGH SCORE");
    char_buf_put_int4(73, 14, high_score);
    
    char_buf_puts(72, 19, "LEVEL");
    char_buf_put_int2(74, 21, level);
}

/* =========================================================================
 * 4. LOGICA DO JOGO
 * ========================================================================= */

static Point snake[MAX_SNAKE_LEN];
static int snake_head;
static int snake_tail;
static int snake_len;

static Direction current_dir;
static Direction next_dir;

static Point food_pos;

typedef enum { STATE_MENU, STATE_PLAYING, STATE_GAMEOVER } GameState;
static GameState state = STATE_MENU;

static int score = 0;
static int level = 1;
static int foods_eaten = 0;
static int delay_ms = BASE_DELAY_MS;

static int high_score = 0;
static int new_record = 0;

static uint32_t rng_seed = 12345;
static uint32_t lcg_rand(void) {
    rng_seed = rng_seed * 1664525u + 1013904223u;
    return rng_seed;
}

static void food_spawn(void) {
    current_fruit = lcg_rand() % 5;
    int ok = 0;
    while (!ok) {
        food_pos.x = lcg_rand() % GRID_COLS;
        food_pos.y = lcg_rand() % GRID_ROWS;
        ok = 1;
        // Verifica se nao esta sobre a cobra
        int i = snake_tail;
        for (int count = 0; count < snake_len; count++) {
            if (snake[i].x == food_pos.x && snake[i].y == food_pos.y) {
                ok = 0;
                break;
            }
            i = (i + 1) % MAX_SNAKE_LEN;
        }
    }
    draw_food(food_pos.x, food_pos.y);
}

static void snake_init(void) {
    snake_len = 3;
    snake_head = 2;
    snake_tail = 0;
    
    for (int i = 0; i < 3; i++) {
        snake[i].x = GRID_COLS / 2 - 2 + i;
        snake[i].y = GRID_ROWS / 2;
        snake[i].dir = DIR_RIGHT;
        if (i == 2) draw_sprite(snake[i].x, snake[i].y, snake_head_arr, snake[i].dir);
        else if (i == 0) draw_sprite(snake[i].x, snake[i].y, snake_tail_arr, snake[i].dir);
        else draw_sprite(snake[i].x, snake[i].y, snake_body_arr, snake[i].dir);
    }
    
    current_dir = DIR_RIGHT;
    next_dir = DIR_RIGHT;
    
    score = 0;
    level = 1;
    foods_eaten = 0;
    delay_ms = BASE_DELAY_MS;
    
    update_hud(score, level);
    food_spawn();
}

static void update_direction(void) {
    uint32_t keys = read_keys();
    if ((keys & 1) && current_dir != DIR_LEFT) next_dir = DIR_RIGHT;      // KEY0
    if ((keys & 2) && current_dir != DIR_RIGHT)    next_dir = DIR_LEFT;      // KEY1
    if ((keys & 4) && current_dir != DIR_UP)  next_dir = DIR_DOWN;        // KEY2
    if ((keys & 8) && current_dir != DIR_DOWN)  next_dir = DIR_UP;     // KEY3
}

static int snake_move(void) {
    current_dir = next_dir;
    Point next_pos = snake[snake_head];
    
    switch (current_dir) {
        case DIR_UP:    next_pos.y--; break;
        case DIR_DOWN:  next_pos.y++; break;
        case DIR_LEFT:  next_pos.x--; break;
        case DIR_RIGHT: next_pos.x++; break;
    }
    
    // Check parede
    if (next_pos.x < 0 || next_pos.x >= GRID_COLS || 
        next_pos.y < 0 || next_pos.y >= GRID_ROWS) {
        return 1; // Colisao (Game Over)
    }
    
    // Check propria cobra
    int i = snake_tail;
    for (int count = 0; count < snake_len; count++) {
        if (snake[i].x == next_pos.x && snake[i].y == next_pos.y) {
            return 1; // Colisao (Game Over)
        }
        i = (i + 1) % MAX_SNAKE_LEN;
    }
    
    // Move
    draw_sprite(snake[snake_head].x, snake[snake_head].y, snake_body_arr, snake[snake_head].dir);
    
    int ate_food = (next_pos.x == food_pos.x && next_pos.y == food_pos.y);
    
    if (ate_food) {
        snake_len++;
        score += 10;
        foods_eaten++;
        if (foods_eaten % 5 == 0) {
            level++;
            if (delay_ms > MIN_DELAY_MS) delay_ms -= DELAY_STEP;
        }
        update_hud(score, level);
    } else {
        // Apaga tail antiga
        draw_bg_tile(snake[snake_tail].x, snake[snake_tail].y);
        snake_tail = (snake_tail + 1) % MAX_SNAKE_LEN;
        // Desenha nova tail
        draw_sprite(snake[snake_tail].x, snake[snake_tail].y, snake_tail_arr, snake[snake_tail].dir);
    }
    
    snake_head = (snake_head + 1) % MAX_SNAKE_LEN;
    next_pos.dir = current_dir;
    snake[snake_head] = next_pos;
    draw_sprite(snake[snake_head].x, snake[snake_head].y, snake_head_arr, snake[snake_head].dir);
    
    if (ate_food) {
        food_spawn();
    }
    
    return 0; // Ok
}

/* =========================================================================
 * 5. MAQUINA DE ESTADOS & MAIN
 * ========================================================================= */

static void draw_gameover(void) {
    /* Limpa a tela inteira (pixels) e o char buffer */
    fill_rect(0, 0, SCREEN_W, SCREEN_H, 0x0000); // COL_BLACK
    char_buf_clear();

    /* Caixa principal — altura aumentada para caber high score e new record */
    fill_rect(10, 52, 300, 150, rgb(20, 0, 30));
    draw_rect(10, 52, 300, 150, COL_GAMEOVER);
    draw_rect(12, 54, 296, 146, rgb(180, 0, 0));

    /* "GAME OVER" centralizado (escala 3: 9*18=162px; x=(320-162)/2=79) */
    draw_str_scaled(79, 62, "GAME OVER", 3, COL_GAMEOVER);

    /* Pontuacao final */
    char_buf_puts(32, 28, "FINAL SCORE:");
    char_buf_put_int(45, 28, score);

    /* Melhor pontuacao */
    char_buf_puts(32, 30, "HIGH  SCORE:");
    char_buf_put_int(45, 30, high_score);

    /* Banner de novo recorde (so aparece se bateu o high score) */
    if (new_record) {
        /* Destaque em amarelo-ouro usando VGA bitmap (escala 2) */
        /* "NEW RECORD!!!" = 13 chars * 12px = 156px; x=(320-156)/2 = 82 */
        draw_str_scaled(82, 134, "NEW RECORD!!!", 2, rgb(255, 210, 50)); // COL_GOLD
    }

    /* Instrucao para reiniciar */
    char_buf_puts(28, 39, "PRESS BUTTON TO RESTART");
}

int main(void) {
    int frame_counter = 0;
    
    while (1) {
        switch (state) {
            case STATE_MENU:
                char_buf_clear();
                draw_splash_screen();
                
                while (read_keys() == 0) {
                    if ((frame_counter / 5) % 2 == 0) {
                        char_buf_puts(25, 40, "PRESS ANY BUTTON TO START");
                    } else {
                        char_buf_puts(25, 40, "                         ");
                    }
                    timer_delay_ms(100);
                    frame_counter++;
                    rng_seed += frame_counter; // Usa tempo no menu como seed
                }
                
                // Espera soltar botoes
                while (read_keys() != 0);
                
                state = STATE_PLAYING;
                break;
                
            case STATE_PLAYING:
                clear_screen(COL_BG);
                draw_board_bg();
                char_buf_clear();
                draw_border();
                draw_hud_bg();
                
                snake_init();
                
                while (state == STATE_PLAYING) {
                    update_direction();
                    if (snake_move()) {
                        if (score > high_score) {
                            high_score = score;
                            new_record = 1;
                        } else {
                            new_record = 0;
                        }
                        state = STATE_GAMEOVER;
                    }
                    
                    if (state == STATE_GAMEOVER) break;

                    // Divide o delay total em pequenos passos de 10ms para ler os botões continuamente
                    int elapsed = 0;
                    while (elapsed < delay_ms) {
                        update_direction();
                        int step = (delay_ms - elapsed > 10) ? 10 : (delay_ms - elapsed);
                        timer_delay_ms(step);
                        elapsed += step;
                    }
                }
                break;
                
            case STATE_GAMEOVER:
                // Pisca head
                for (int i=0; i<3; i++) {
                    draw_snake_block(snake[snake_head].x, snake[snake_head].y, COL_GAMEOVER);
                    timer_delay_ms(200);
                    draw_sprite(snake[snake_head].x, snake[snake_head].y, snake_head_arr, snake[snake_head].dir);
                    timer_delay_ms(200);
                }
                
                draw_gameover();
                
                // Limpa buffer de botoes para evitar skip instantaneo
                while (read_keys() != 0);
                
                // Aguarda botao para reiniciar
                while (read_keys() == 0) {
                    timer_delay_ms(50);
                }
                
                // Espera o botao ser solto para nao pular a tela do menu acidentalmente
                while (read_keys() != 0);
                
                state = STATE_MENU;
                break;
        }
    }
    return 0;
}
