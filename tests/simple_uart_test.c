// Simple UART test - no crt0, direct main
void main() {
    volatile unsigned int* UART_TXCTRL = (unsigned int*)0x10000008;
    volatile unsigned int* UART_TXDATA = (unsigned int*)0x10000000;
    
    // Enable UART
    *UART_TXCTRL = 1;
    
    // Send 'A'
    *UART_TXDATA = 0x41;
    
    // Send 'B'
    *UART_TXDATA = 0x42;
    
    // Send '\n'
    *UART_TXDATA = 0x0A;
}
