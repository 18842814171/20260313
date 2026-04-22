/**
 * 用默认 gcc + newlib 链接时：main 返回后由 crt 调 exit → ECALL(93)。
 * 若模拟器曾给错 argv（a1 指向 argc），newlib 会在 .bss 清零等处异常循环。
 *
 * 极简/无 libc：请用 -nostdlib -T tests/rv32.ld 并自行提供 _start + ECALL。
 */
int main(void) {
    int a = 5;
    int b = 3;
    int c = a + b;
    return c;
}
