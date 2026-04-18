/**
 * @file uart_interactive_test.c
 * @brief Real interactive UART test (blocking + echo)
 */

 #include <stdint.h>

 // =====================================================
 // UART 寄存器定义
 // =====================================================
 #define UART_BASE   0x10000000
 #define UART_TXDATA    (*(volatile uint32_t*)(UART_BASE + 0x00))
 #define UART_RXDATA    (*(volatile uint32_t*)(UART_BASE + 0x04))
 #define UART_TXCTRL    (*(volatile uint32_t*)(UART_BASE + 0x08))
 #define UART_RXCTRL    (*(volatile uint32_t*)(UART_BASE + 0x0C))
 #define UART_DIV       (*(volatile uint32_t*)(UART_BASE + 0x18))
 
 #define RX_EMPTY_MASK  0x80000000
 
 // =====================================================
 // UART 基础函数
 // =====================================================
 
 void uart_putc(char c) {
     UART_TXDATA = (uint32_t)c;
 }
 
 void uart_puts(const char* s) {
     while (*s) {
         uart_putc(*s++);
     }
 }
 
 void println() {
     uart_putc('\n');
 }
 
 // 阻塞读取字符（关键！）
 char uart_getc() {
     while (1) {
         uint32_t val = UART_RXDATA;
         if (!(val & RX_EMPTY_MASK)) {
             return (char)(val & 0xFF);
         }
     }
 }
 
 // 打印 hex（调试用）
 void print_hex(uint32_t val) {
     const char hex[] = "0123456789ABCDEF";
     char buf[11];
     buf[0] = '0';
     buf[1] = 'x';
     buf[10] = '\0';
 
     for (int i = 9; i >= 2; i--) {
         buf[i] = hex[val & 0xF];
         val >>= 4;
     }
 
     uart_puts(buf);
 }
 
 // =====================================================
 // 主程序
 // =====================================================
 
 int main() {
     // 初始化 UART
     UART_TXCTRL = 1;
     UART_RXCTRL = 1;
     UART_DIV = 16;
 
     uart_puts("\n=== UART INTERACTIVE TEST ===\n");
     uart_puts("Type characters and they will echo back.\n");
     uart_puts("Press ENTER to print newline.\n");
     uart_puts("Press 'q' to quit.\n\n");
 
     while (1) {
         // 等待用户输入（阻塞）
         char c = uart_getc();
 
         // 显示收到的字符
         uart_puts("You typed: ");
         uart_putc(c);
         uart_puts(" (");
         print_hex((uint32_t)c);
         uart_puts(")");
         println();
 
         // 回显（echo）
         uart_puts("Echo: ");
         uart_putc(c);
         println();
 
         // 退出条件
         if (c == 'q') {
             uart_puts("\nExiting UART test.\n");
             break;
         }
     }
 
     // 退出
     asm volatile("li a7, 93");
     asm volatile("li a0, 0");
     asm volatile("ecall");
 
     while (1);
     return 0;
 }