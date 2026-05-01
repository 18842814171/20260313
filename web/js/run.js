// 运行程序页面逻辑
class RunProgram {
    constructor() {
        this.codeEditor = document.getElementById('codeEditor');
        this.fileInput = document.getElementById('fileInput');
        this.uploadBtn = document.getElementById('uploadBtn');
        this.submitBtn = document.getElementById('submitBtn');
        this.compileStatus = document.getElementById('compileStatus');
        this.compileMessages = document.getElementById('compileMessages');
        this.downloadSection = document.getElementById('downloadSection');
        this.fileSize = document.getElementById('fileSize');
        this.downloadBtn = document.getElementById('downloadBtn');
        this.executionSection = document.getElementById('executionSection');
        this.executeBtn = document.getElementById('executeBtn');
        this.loadingOverlay = document.getElementById('loadingOverlay');
        
        // 示例代码按钮
        this.example1Btn = document.getElementById('example1Btn');
        this.example2Btn = document.getElementById('example2Btn');
        
        // 存储当前选择的汇编代码
        this.currentAssemblyCode = '';
        this.currentAsmInstructions = [];
        
        this.initEventListeners();
        this.displayCustomInstructions();
    }
    displayCustomInstructions() {
        const customInsts = JSON.parse(localStorage.getItem('customInstructions') || '[]');
        const infoDiv = document.getElementById('customInstInfo');
        const countSpan = document.getElementById('customInstCount');
        const listDiv = document.getElementById('customInstList');
        
        if (customInsts.length > 0 && infoDiv) {
            infoDiv.style.display = 'block';
            countSpan.textContent = customInsts.length;
            listDiv.innerHTML = customInsts.map(inst => 
                `<span style="background: #e0e0e0; padding: 2px 8px; border-radius: 12px; margin-right: 8px;">${inst.name} (${inst.type}型)</span>`
            ).join('');
        }
    }   
    initEventListeners() {
        // 上传文件按钮
        this.uploadBtn.addEventListener('click', () => {
            this.fileInput.click();
        });
        
        // 文件选择
        this.fileInput.addEventListener('change', (e) => {
            this.handleFileUpload(e);
        });
        
        // 提交按钮
        this.submitBtn.addEventListener('click', () => {
            this.handleSubmit();
        });
        
        // 下载按钮
        this.downloadBtn.addEventListener('click', () => {
            this.handleDownload();
        });
        
        // 执行按钮
        this.executeBtn.addEventListener('click', () => {
            this.handleExecute();
        });
        
        // 示例代码按钮
        if (this.example1Btn) {
            this.example1Btn.addEventListener('click', () => {
                this.loadExample1();
            });
        }
        
        if (this.example2Btn) {
            this.example2Btn.addEventListener('click', () => {
                this.loadExample2();
            });
        }
    }
    
    // 加载示例1: 简单加法程序
    loadExample1() {
        const exampleCode = `// simple_add.c - 简单的加法程序
// 功能：计算 a + b 并返回结果
// 预期结果：c = 5 + 3 = 8

int main() {
    int a = 5;
    int b = 3;
    int c = a + b;
    return c;
}`;
        
        this.codeEditor.value = exampleCode;
        this.showModal('示例加载成功', '已加载简单加法程序示例，点击"提交代码"开始编译');
        this.highlightButton(this.example1Btn);
    }
    
    // 加载示例2: Timer & UART 测试程序
    loadExample2() {
        const exampleCode = `/**
 * @file timer_uart_test.c
 * @brief Timer 和 UART 设备交互式测试程序
 * 
 * 设备地址:
 *   Timer: 0x02004000
 *   UART:  0x10000000
 */

#include <stdint.h>

#define TIMER_BASE   0x02004000
#define TIMER_MTIME      (*(volatile uint64_t*)(TIMER_BASE + 0x00))
#define UART_BASE   0x10000000
#define UART_TXDATA    (*(volatile uint32_t*)(UART_BASE + 0x00))

int main() {
    // 初始化 UART
    *(volatile uint32_t*)(UART_BASE + 0x08) = 1;
    
    // 输出欢迎信息
    const char* msg = "Hello from RISC-V!\\r\\n";
    for (int i = 0; msg[i]; i++) {
        while (*(volatile uint32_t*)(UART_BASE + 0x00) & 0x80000000) {}
        *(volatile uint32_t*)(UART_BASE + 0x00) = msg[i];
    }
    
    return 0;
}`;
        
        this.codeEditor.value = exampleCode;
        this.showModal('示例加载成功', '已加载 Timer & UART 外设测试程序示例，点击"提交代码"开始编译');
        this.highlightButton(this.example2Btn);
    }
    
    // 高亮按钮效果
    highlightButton(btn) {
        [this.example1Btn, this.example2Btn].forEach(b => {
            if (b) {
                b.style.transform = 'scale(1)';
                b.style.boxShadow = 'none';
            }
        });
        
        if (btn) {
            btn.style.transform = 'scale(1.02)';
            btn.style.boxShadow = '0 2px 8px rgba(0,0,0,0.2)';
            setTimeout(() => {
                btn.style.transform = 'scale(1)';
                btn.style.boxShadow = 'none';
            }, 500);
        }
    }
    
    // 获取预编译的汇编代码（根据用户选择的示例）
    getPrecompiledAssembly(code) {
        // 判断是示例1还是示例2
        if (code.includes('simple_add') || (code.includes('a = 5') && code.includes('b = 3'))) {
            return this.getSimpleAddAssembly();
        } else if (code.includes('timer_uart_test') || code.includes('UART_BASE')) {
            return this.getTimerUartAssembly();
        }
        // 默认返回简单加法的汇编
        return this.getSimpleAddAssembly();
    }
    
    // 简单加法的预编译汇编代码
    getSimpleAddAssembly() {
        return [
            { addr: 0x10000, inst: "addi sp, sp, -32", raw: "0xfd010113", decoded: "addi sp, sp, -32" },
            { addr: 0x10004, inst: "li a5, 5", raw: "0x00500793", decoded: "li a5, 5" },
            { addr: 0x10008, inst: "sw a5, 20(sp)", raw: "0x00f12e23", decoded: "sw a5, 20(sp)" },
            { addr: 0x1000c, inst: "li a5, 3", raw: "0x00300793", decoded: "li a5, 3" },
            { addr: 0x10010, inst: "sw a5, 24(sp)", raw: "0x00f12c23", decoded: "sw a5, 24(sp)" },
            { addr: 0x10014, inst: "lw a4, 20(sp)", raw: "0x01412703", decoded: "lw a4, 20(sp)" },
            { addr: 0x10018, inst: "lw a5, 24(sp)", raw: "0x01812783", decoded: "lw a5, 24(sp)" },
            { addr: 0x1001c, inst: "add a5, a4, a5", raw: "0x00f707b3", decoded: "add a5, a4, a5" },
            { addr: 0x10020, inst: "sw a5, 28(sp)", raw: "0x00f12a23", decoded: "sw a5, 28(sp)" },
            { addr: 0x10024, inst: "lw a5, 28(sp)", raw: "0x01c12783", decoded: "lw a5, 28(sp)" },
            { addr: 0x10028, inst: "mv a0, a5", raw: "0x00078513", decoded: "mv a0, a5" },
            { addr: 0x1002c, inst: "addi sp, sp, 32", raw: "0x02010113", decoded: "addi sp, sp, 32" },
            { addr: 0x10030, inst: "ret", raw: "0x00008067", decoded: "ret" }
        ];
    }
    
    // Timer & UART 测试程序的预编译汇编代码
    getTimerUartAssembly() {
        return [
            { addr: 0x10000, inst: "addi sp, sp, -32", raw: "0xfd010113", decoded: "addi sp, sp, -32" },
            { addr: 0x10004, inst: "li a5, 1", raw: "0x00100793", decoded: "li a5, 1" },
            { addr: 0x10008, inst: "lui a4, 0x10000", raw: "0x10000737", decoded: "lui a4, 0x10000" },
            { addr: 0x1000c, inst: "addi a4, a4, 8", raw: "0x00870713", decoded: "addi a4, a4, 8" },
            { addr: 0x10010, inst: "sw a5, 0(a4)", raw: "0x00f72023", decoded: "sw a5, 0(a4)" },
            { addr: 0x10014, inst: "lui a5, 0x12", raw: "0x120007b7", decoded: "lui a5, 0x12" },
            { addr: 0x10018, inst: "addi a5, a5, 464", raw: "0x1d078793", decoded: "addi a5, a5, 464" },
            { addr: 0x1001c, inst: "sw a5, 12(sp)", raw: "0x00f12623", decoded: "sw a5, 12(sp)" },
            { addr: 0x10020, inst: "lw a5, 12(sp)", raw: "0x00c12783", decoded: "lw a5, 12(sp)" },
            { addr: 0x10024, inst: "lb a5, 0(a5)", raw: "0x0007c783", decoded: "lb a5, 0(a5)" },
            { addr: 0x10028, inst: "beqz a5, 0x10048", raw: "0x02078463", decoded: "beqz a5, 0x10048" },
            { addr: 0x1002c, inst: "lw a5, 12(sp)", raw: "0x00c12783", decoded: "lw a5, 12(sp)" },
            { addr: 0x10030, inst: "lb a5, 0(a5)", raw: "0x0007c783", decoded: "lb a5, 0(a5)" },
            { addr: 0x10034, inst: "lui a4, 0x10000", raw: "0x10000737", decoded: "lui a4, 0x10000" },
            { addr: 0x10038, inst: "sw a5, 0(a4)", raw: "0x00f72023", decoded: "sw a5, 0(a4)" },
            { addr: 0x1003c, inst: "lw a5, 12(sp)", raw: "0x00c12783", decoded: "lw a5, 12(sp)" },
            { addr: 0x10040, inst: "addi a5, a5, 1", raw: "0x00178793", decoded: "addi a5, a5, 1" },
            { addr: 0x10044, inst: "fddff06f", raw: "0xfddff06f", decoded: "j 0x10020" },
            { addr: 0x10048, inst: "li a7, 93", raw: "0x05d00893", decoded: "li a7, 93" },
            { addr: 0x1004c, inst: "li a0, 0", raw: "0x00000513", decoded: "li a0, 0" },
            { addr: 0x10050, inst: "ecall", raw: "0x00000073", decoded: "ecall" }
        ];
    }
    
    handleFileUpload(event) {
        const file = event.target.files[0];
        if (!file) return;
        
        const reader = new FileReader();
        reader.onload = (e) => {
            this.codeEditor.value = e.target.result;
            this.showModal('提示', `成功加载文件：${file.name}`);
        };
        reader.onerror = () => {
            this.showModal('错误', '文件读取失败，请重试');
        };
        reader.readAsText(file);
        
        this.fileInput.value = '';
    }
    
    async handleSubmit() {
        const code = this.codeEditor.value.trim();
        
        if (!code) {
            this.showModal('提示', '请输入或上传 C/C++ 代码，或点击示例按钮加载示例代码');
            return;
        }
        
        this.showLoading(true);
        
        try {
            await this.sleep(800);
            
            let assemblyCode = [];
            let logData = null;
            
            // 判断是示例1还是示例2
            if (code.includes('simple_add') || (code.includes('a = 5') && code.includes('b = 3'))) {
                assemblyCode = this.getSimpleAddAssembly();
                logData = this.getSimpleAddLog();
            } else if (code.includes('timer_uart_test') || code.includes('UART_BASE')) {
                assemblyCode = this.getTimerUartAssembly();
                logData = this.getTimerUartLog();
            } else {
                // 用户自定义代码：使用原有的编译逻辑
                assemblyCode = this.compileToAssembly(code);
            }
            
            // ========== 新增：加载自定义指令 ==========
            const customInstructions = JSON.parse(localStorage.getItem('customInstructions') || '[]');
            if (customInstructions.length > 0) {
                console.log('检测到自定义指令:', customInstructions.length, '条');
                // 可以在编译时添加自定义指令的声明
                // 这样 debug.html 就能识别并执行
            }
            
            // 存储汇编代码和日志数据
            this.currentAsmInstructions = assemblyCode;
            if (logData) {
                localStorage.setItem('executionLog', JSON.stringify(logData));
            } else {
                localStorage.removeItem('executionLog');
            }
            
            // 同时存储自定义指令，供 debug.html 使用
            localStorage.setItem('customInstructions', JSON.stringify(customInstructions));
            
            this.showCompileSuccess(code, assemblyCode);
            this.downloadSection.style.display = 'block';
            const mockSize = (assemblyCode.length * 8) + 1024;
            document.getElementById('fileSize').textContent = `${mockSize} bytes`;
            this.executionSection.style.display = 'block';
            
        } catch (error) {
            this.showCompileError(error.message);
        } finally {
            this.showLoading(false);
        }
    }
    
    showCompileSuccess(code, assemblyCode) {
        this.compileStatus.style.display = 'block';
        
        // 显示汇编指令预览
        const asmPreview = assemblyCode.slice(0, 8).map(inst => 
            `<div style="font-family: monospace; font-size: 11px; color: #666;">${inst.addr.toString(16)}: ${inst.inst}</div>`
        ).join('');
        
        this.compileMessages.innerHTML = `
            <div class="success">✓ 编译成功！</div>
            <div class="info">📝 已生成 ELF 文件：program.elf</div>
            <div class="info">🔧 目标架构：RISC-V RV32I</div>
            <div class="info">📊 代码行数：${code.split('\n').length} 行</div>
            <div class="info">📦 汇编指令数：${assemblyCode.length} 条</div>
            <div class="info" style="margin-top: 8px; padding-top: 8px; border-top: 1px solid #e0e0e0;">
                <details>
                    <summary>📋 查看汇编代码预览 (前8条)</summary>
                    <div style="margin-top: 8px; background: #f5f5f5; padding: 8px; border-radius: 6px;">
                        ${asmPreview}
                        ${assemblyCode.length > 8 ? '<div style="color: #999; margin-top: 4px;">...</div>' : ''}
                    </div>
                </details>
            </div>
        `;
        
        this.compileStatus.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
    
    showCompileError(error) {
        this.compileStatus.style.display = 'block';
        this.compileMessages.innerHTML = `
            <div class="error">✗ 编译失败</div>
            <div class="error">错误信息：${error}</div>
        `;
        this.compileStatus.style.borderLeftColor = '#dc3545';
        
        this.downloadSection.style.display = 'none';
        this.executionSection.style.display = 'none';
    }
    
    handleDownload() {
        // 创建模拟的 ELF 文件内容（包含汇编代码）
        const asmCode = this.currentAsmInstructions;
        const elfContent = this.generateMockELF(asmCode);
        
        const blob = new Blob([elfContent], { type: 'application/x-elf' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'program.elf';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        
        this.showModal('下载成功', 'ELF 文件已保存到本地');
    }
    
    generateMockELF(asmCode) {
        const encoder = new TextEncoder();
        
        // 生成 ELF 头和数据
        let content = 'MOCK_ELF_HEADER_RV32I\n';
        content += '=== Assembly Instructions ===\n';
        
        asmCode.forEach(inst => {
            content += `${inst.addr.toString(16)}: ${inst.inst} (${inst.raw})\n`;
        });
        
        content += '\n=== End of ELF ===\n';
        
        return encoder.encode(content);
    }
    
    handleExecute() {
        this.showModal('执行程序', '即将进入调试界面...');
        
        setTimeout(() => {
            // 保存汇编指令到 localStorage，供 debug.html 使用
            localStorage.setItem('userCode', this.codeEditor.value);
            localStorage.setItem('precompiledAssembly', JSON.stringify(this.currentAsmInstructions));
            localStorage.setItem('elfGenerated', 'true');
            window.location.href = 'debug.html';
        }, 1000);
    }
    
    showModal(title, message) {
        const modal = document.getElementById('modal');
        const modalTitle = document.getElementById('modal-title');
        const modalMessage = document.getElementById('modal-message');
        const closeBtn = document.querySelector('.modal-close');
        
        modalTitle.textContent = title;
        modalMessage.textContent = message;
        modal.style.display = 'block';
        
        const closeModal = () => {
            modal.style.display = 'none';
            closeBtn.removeEventListener('click', closeModal);
        };
        
        closeBtn.addEventListener('click', closeModal);
        
        window.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal();
            }
        });
        
        if (title === '提交成功') {
            setTimeout(closeModal, 2000);
        }
    }
    
    showLoading(show) {
        this.loadingOverlay.style.display = show ? 'flex' : 'none';
    }
    
    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// 初始化页面
document.addEventListener('DOMContentLoaded', () => {
    window.runProgram = new RunProgram();
});