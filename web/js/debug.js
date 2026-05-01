// debug.js - 支持日志回放、完整时空图显示和Vivado风格波形图

class DebugInterface {
    constructor() {
        this.asmInstructions = [];
        this.currentPC = 0x10000;
        this.registers = new Array(32).fill(0);
        this.breakpoints = new Set();
        this.currentGraphMode = 'pipeline';
        this.errorOccurred = false;
        this.errorLine = -1;
        this.isRunning = false;
        
        this.memory = {};
        
        this.regChangeHistory = [];
        this.currentALUOp = null;
        this.currentALUResult = 0;
        this.lastMemoryAccess = null;
        
        this.isFullscreen = false;
        
        this.pipelineStages = {
            if_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            id_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            ex_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            mem_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            wb_stage: { valid: false, pc: 0, inst: null, cycle: -1 }
        };
        
        this.waveformHistory = [];
        this.executionHistory = [];
        this.currentCycle = 0;
        
        this.executionLog = null;
        this.logStepIndex = 0;
        this.isReplaying = false;
        
        this.waveformCursors = [];
        this.tracedSignals = [];
        this.signalHistory = {};
        this.waveformCanvas = null;
        this.waveformCtx = null;
        this._skipAutoScroll = false;
        
        this.example1Log = null;
        this.example2Log = null;
        
        // ========== 自定义指令支持 ==========
        this.customInstructions = [];
        this.customHandlers = {};
        this.pendingNextPC = null;
        
        this.registers[2] = 0x1F000;
        this.registers[1] = 0x10000;
        this.registers[3] = 0x138F0;
        this.registers[8] = 0x1F000;
        
        this.initEventListeners();
        this.initCanvas();
        this.loadAssemblyCode();
        this.initRegisters();
        this.initFullscreenEvents();
        this.initWaveform();
        this.loadExampleLogs();
        this.loadCustomInstructions();
        
        this.updateRegistersDisplay();
        this.displayAssembly();
        this.drawCPUDiagram();
        this.drawPipelineDiagram();
        this.highlightCurrentInstruction(false);
        
        this.startAnimationLoop();
    }
    
    // ========== 自定义指令方法 ==========
    
    loadCustomInstructions() {
        const saved = localStorage.getItem('customInstructions');
        if (saved) {
            try {
                this.customInstructions = JSON.parse(saved);
                this.registerCustomHandlers();
                console.log('已加载自定义指令:', this.customInstructions.length, '条');
            } catch(e) {
                console.error('加载自定义指令失败:', e);
            }
        }
    }

    
    registerCustomHandlers() {
        this.customHandlers = {};
        this.customInstructions.forEach(inst => {
            try {
                const opcodeNum = parseInt(inst.opcode, 2);
                
                // 将 C++ 代码转换为 JavaScript 语法
                let modifiedCode = inst.code;
                
                // 1. 替换函数参数
                modifiedCode = modifiedCode.replace(/void\s+\w+\s*\([^)]*\)/g, '');
                
                // 2. 替换变量声明
                modifiedCode = modifiedCode.replace(/uint32_t\s+/g, 'let ');
                modifiedCode = modifiedCode.replace(/int32_t\s+/g, 'let ');
                modifiedCode = modifiedCode.replace(/int\s+/g, 'let ');
                
                // 3. 替换 in 和 out
                modifiedCode = modifiedCode.replace(/\bin\./g, 'input.');
                modifiedCode = modifiedCode.replace(/\bout\./g, 'output.');
                
                // 4. 移除 C++ 特有的语法
                modifiedCode = modifiedCode.replace(/\(int32_t\)/g, '');
                modifiedCode = modifiedCode.replace(/<<\s*\d+/g, (match) => {
                    // 保留左移操作
                    return match;
                });
                
                // 5. 处理大括号
                modifiedCode = modifiedCode.replace(/^\s*\{/, '');
                modifiedCode = modifiedCode.replace(/\}\s*$/, '');
                
                // 6. 确保最后有分号
                if (!modifiedCode.trim().endsWith(';') && !modifiedCode.trim().endsWith('}')) {
                    modifiedCode += ';';
                }
                
                console.log('转换后的代码:', modifiedCode);
                
                const fn = new Function('inContext', 'outContext', `
                    const input = {
                        val_rs1: inContext.val_rs1,
                        val_rs2: inContext.val_rs2,
                        imm: inContext.imm,
                        pc: inContext.pc
                    };
                    const output = {
                        alu_result: 0,
                        reg_write: false,
                        mem_write: false,
                        mem_addr: 0,
                        mem_data: 0,
                        next_pc: 0,
                        pc_modified: false
                    };
                    
                    ${modifiedCode}
                    
                    outContext.alu_result = output.alu_result;
                    outContext.reg_write = output.reg_write;
                    outContext.mem_write = output.mem_write;
                    outContext.mem_addr = output.mem_addr;
                    outContext.mem_data = output.mem_data;
                    outContext.next_pc = output.next_pc;
                    outContext.pc_modified = output.pc_modified;
                `);
                
                this.customHandlers[opcodeNum] = fn;
                console.log('注册自定义指令成功:', inst.name, 'opcode:', inst.opcode);
            } catch(e) {
                console.error('注册自定义指令失败:', inst.name, e);
            }
        });
    }
    
    getOpcodeFromRaw(raw) {
        const rawValue = parseInt(raw, 16);
        return rawValue & 0x7F;  // 低7位是opcode
    }
    
    getRdFromRaw(raw) {
        const rawValue = parseInt(raw, 16);
        return (rawValue >> 7) & 0x1F;
    }
    
    getRs1FromRaw(raw) {
        const rawValue = parseInt(raw, 16);
        return (rawValue >> 15) & 0x1F;
    }
    
    getRs2FromRaw(raw) {
        const rawValue = parseInt(raw, 16);
        return (rawValue >> 20) & 0x1F;
    }
    
    getImmediateFromInst(instStr) {
        const match = instStr.match(/-?\d+/);
        if (match) {
            return parseInt(match[0]);
        }
        return 0;
    }
    
    loadExampleLogs() {
        this.example1Log = {
            instructions: [
                { addr: 0x100f8, inst: "auipc gp,0x4", raw: "0x00004197", decoded: "auipc gp,0x4" },
                { addr: 0x100fc, inst: "addi gp,gp,2000", raw: "0x7d018193", decoded: "addi gp,gp,2000" },
                { addr: 0x10100, inst: "li a0,0", raw: "0x00000513", decoded: "li a0,0" },
                { addr: 0x10104, inst: "beqz a0,1010c", raw: "0x00050463", decoded: "beqz a0,1010c" },
                { addr: 0x10108, inst: "csrw jvt,a0", raw: "0x01751073", decoded: "csrw jvt,a0" },
                { addr: 0x1010c, inst: "auipc a0,0x3", raw: "0x00003517", decoded: "auipc a0,0x3" },
                { addr: 0x10110, inst: "addi a0,a0,1316", raw: "0x52450513", decoded: "addi a0,a0,1316" },
                { addr: 0x10114, inst: "auipc a2,0x4", raw: "0x00004617", decoded: "auipc a2,0x4" },
                { addr: 0x10118, inst: "addi a2,a2,-1980", raw: "0x84460613", decoded: "addi a2,a2,-1980" },
                { addr: 0x1011c, inst: "sub a2,a2,a0", raw: "0x40a60633", decoded: "sub a2,a2,a0" },
                { addr: 0x10120, inst: "li a1,0", raw: "0x00000593", decoded: "li a1,0" },
                { addr: 0x10124, inst: "jal 10a88 <memset>", raw: "0x165000ef", decoded: "jal 10a88" },
                { addr: 0x10128, inst: "auipc a0,0x1", raw: "0x00001517", decoded: "auipc a0,0x1" },
                { addr: 0x1012c, inst: "addi a0,a0,-1140", raw: "0xb8c50513", decoded: "addi a0,a0,-1140" },
                { addr: 0x10130, inst: "beqz a0,10140", raw: "0x00050863", decoded: "beqz a0,10140" },
                { addr: 0x10134, inst: "auipc a0,0x2", raw: "0x00002517", decoded: "auipc a0,0x2" },
                { addr: 0x10138, inst: "addi a0,a0,-796", raw: "0xce450513", decoded: "addi a0,a0,-796" },
                { addr: 0x1013c, inst: "jal 10cb4 <atexit>", raw: "0x379000ef", decoded: "jal 10cb4" },
                { addr: 0x10140, inst: "jal 109f4 <__libc_init_array>", raw: "0x0b5000ef", decoded: "jal 109f4" },
                { addr: 0x10144, inst: "lw a0,0(sp)", raw: "0x00012503", decoded: "lw a0,0(sp)" },
                { addr: 0x10148, inst: "addi a1,sp,4", raw: "0x00410593", decoded: "addi a1,sp,4" },
                { addr: 0x1014c, inst: "slli a2,a0,0x2", raw: "0x00251613", decoded: "slli a2,a0,0x2" },
                { addr: 0x10150, inst: "addi a2,a2,4", raw: "0x00460613", decoded: "addi a2,a2,4" },
                { addr: 0x10154, inst: "add a2,a2,a1", raw: "0x00b60633", decoded: "add a2,a2,a1" },
                { addr: 0x10158, inst: "jal 101c4 <main>", raw: "0x06c000ef", decoded: "jal 101c4" },
                { addr: 0x1015c, inst: "j 100b4 <exit>", raw: "0xf59ff06f", decoded: "j 100b4" },
                { addr: 0x101c4, inst: "addi sp,sp,-32", raw: "0xfe010113", decoded: "addi sp,sp,-32" },
                { addr: 0x101c8, inst: "sw ra,28(sp)", raw: "0x00112e23", decoded: "sw ra,28(sp)" },
                { addr: 0x101cc, inst: "sw s0,24(sp)", raw: "0x00812c23", decoded: "sw s0,24(sp)" },
                { addr: 0x101d0, inst: "addi s0,sp,32", raw: "0x02010413", decoded: "addi s0,sp,32" },
                { addr: 0x101d4, inst: "li a5,5", raw: "0x00500793", decoded: "li a5,5" },
                { addr: 0x101d8, inst: "sw a5,-20(s0)", raw: "0xfef42623", decoded: "sw a5,-20(s0)" },
                { addr: 0x101dc, inst: "li a5,3", raw: "0x00300793", decoded: "li a5,3" },
                { addr: 0x101e0, inst: "sw a5,-24(s0)", raw: "0xfef42423", decoded: "sw a5,-24(s0)" },
                { addr: 0x101e4, inst: "lw a4,-20(s0)", raw: "0xfec42703", decoded: "lw a4,-20(s0)" },
                { addr: 0x101e8, inst: "lw a5,-24(s0)", raw: "0xfe842783", decoded: "lw a5,-24(s0)" },
                { addr: 0x101ec, inst: "add a5,a4,a5", raw: "0x00f707b3", decoded: "add a5,a4,a5" },
                { addr: 0x101f0, inst: "sw a5,-28(s0)", raw: "0xfef42223", decoded: "sw a5,-28(s0)" },
                { addr: 0x101f4, inst: "li a7,93", raw: "0x05d00893", decoded: "li a7,93" },
                { addr: 0x101f8, inst: "li a0,8", raw: "0x00800513", decoded: "li a0,8" },
                { addr: 0x101fc, inst: "ecall", raw: "0x00000073", decoded: "ecall" },
                { addr: 0x10200, inst: "j 10200 <main+0x3c>", raw: "0x0000006f", decoded: "j 10200" }
            ],
            registers: { x1: 0x10000, x2: 0x1F000, x3: 0x138F0, x8: 0x1F000, x10: 8, x14: 5, x15: 8 },
            exitCode: 8, totalSteps: 69, finalPC: 0x10200
        };
        
        this.example2Log = {
            instructions: [
                { addr: 0x100f8, inst: "auipc gp,0x4", raw: "0x00004197", decoded: "auipc gp,0x4" },
                { addr: 0x100fc, inst: "addi gp,gp,-1000", raw: "0xc1818193", decoded: "addi gp,gp,-1000" },
                { addr: 0x10100, inst: "li a0,0", raw: "0x00000513", decoded: "li a0,0" },
                { addr: 0x10588, inst: "li a7,93", raw: "0x05d00893", decoded: "li a7,93" },
                { addr: 0x1058c, inst: "li a0,0", raw: "0x00000513", decoded: "li a0,0" },
                { addr: 0x10590, inst: "ecall", raw: "0x00000073", decoded: "ecall" }
            ],
            registers: { x1: 0x10000, x2: 0x1efe0, x3: 0x138f0, x8: 0x1f000, x10: 0, x14: 8, x15: 0x1d2 },
            exitCode: 0, totalSteps: 323, finalPC: 0x10590
        };
    }
    
    initEventListeners() {
        document.getElementById('runFullBtn')?.addEventListener('click', () => this.runFull());
        document.getElementById('stepBtn')?.addEventListener('click', () => this.step());
        document.getElementById('resetBtn')?.addEventListener('click', () => this.reset());
        document.getElementById('switchGraphBtn')?.addEventListener('click', () => this.switchGraph());
        document.getElementById('refreshRegsBtn')?.addEventListener('click', () => this.updateRegistersDisplay());
        document.getElementById('addBreakpointBtn')?.addEventListener('click', () => this.addBreakpoint());
        document.getElementById('clearBreakpointsBtn')?.addEventListener('click', () => this.clearBreakpoints());
        document.getElementById('closeConsoleBtn')?.addEventListener('click', () => this.hideConsole());
        document.getElementById('openCodePanelBtn')?.addEventListener('click', () => this.openCodePanel());
        document.getElementById('closeCodePanelBtn')?.addEventListener('click', () => this.closeCodePanel());
        document.getElementById('reRunBtn')?.addEventListener('click', () => this.reRun());
        document.getElementById('saveAndRunBtn')?.addEventListener('click', () => this.saveAndRun());
        
        document.getElementById('fullscreenRunBtn')?.addEventListener('click', () => this.runFull());
        document.getElementById('fullscreenStepBtn')?.addEventListener('click', () => this.step());
        document.getElementById('fullscreenResetBtn')?.addEventListener('click', () => this.reset());
        
        document.getElementById('addCursorBtn')?.addEventListener('click', () => {
            if (this.currentGraphMode === 'waveform') {
                this.addWaveformCursor(this.currentCycle);
            }
        });
        
        document.getElementById('clearCursorsBtn')?.addEventListener('click', () => {
            if (this.currentGraphMode === 'waveform') {
                this.clearWaveformCursors();
            }
        });
        
        document.addEventListener('keydown', (e) => {
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                this.openCodePanel();
            }
            if (e.key === 'Escape' && this.isFullscreen) {
                this.exitFullscreen();
            }
        });
    }
    
    initFullscreenEvents() {
        const fullscreenToggleBtn = document.getElementById('fullscreenToggleBtn');
        if (fullscreenToggleBtn) {
            fullscreenToggleBtn.addEventListener('click', () => this.toggleFullscreen());
        }
    }

    toggleFullscreen() {
        if (this.isFullscreen) {
            this.exitFullscreen();
        } else {
            this.enterFullscreen();
        }
    }

    enterFullscreen() {
        this.isFullscreen = true;
        const container = document.getElementById('canvasContainer');
        const fullscreenToggleBtn = document.getElementById('fullscreenToggleBtn');
        
        document.body.classList.add('fullscreen-mode');
        if (container) container.classList.add('fullscreen');
        
        if (fullscreenToggleBtn) {
            fullscreenToggleBtn.textContent = '✕';
            fullscreenToggleBtn.title = '退出全屏';
        }
        
        setTimeout(() => { this.drawCPUDiagram(); }, 100);
    }

    exitFullscreen() {
        this.isFullscreen = false;
        const container = document.getElementById('canvasContainer');
        const fullscreenToggleBtn = document.getElementById('fullscreenToggleBtn');
        
        document.body.classList.remove('fullscreen-mode');
        if (container) container.classList.remove('fullscreen');
        
        if (fullscreenToggleBtn) {
            fullscreenToggleBtn.textContent = '⛶';
            fullscreenToggleBtn.title = '全屏';
        }
        
        setTimeout(() => { this.drawCPUDiagram(); }, 100);
    }
    
    initCanvas() {
        this.drawCPUDiagram();
        this.currentGraphMode = 'pipeline';
        const pipelineContainer = document.getElementById('pipelineContainer');
        const waveformContainer = document.getElementById('waveformContainer');
        if (pipelineContainer) pipelineContainer.style.display = 'block';
        if (waveformContainer) waveformContainer.style.display = 'none';
        this.drawPipelineDiagram();
    }
    
    roundRect(ctx, x, y, w, h, r) {
        ctx.beginPath();
        ctx.moveTo(x + r, y);
        ctx.lineTo(x + w - r, y);
        ctx.quadraticCurveTo(x + w, y, x + w, y + r);
        ctx.lineTo(x + w, y + h - r);
        ctx.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
        ctx.lineTo(x + r, y + h);
        ctx.quadraticCurveTo(x, y + h, x, y + h - r);
        ctx.lineTo(x, y + r);
        ctx.quadraticCurveTo(x, y, x + r, y);
        return ctx;
    }
    
    drawStyledComponent(ctx, x, y, w, h, color, title, data) {
        ctx.fillStyle = '#FFF8DC';
        this.roundRect(ctx, x, y, w, h, 8);
        ctx.fill();
        
        ctx.strokeStyle = color;
        ctx.lineWidth = 2;
        this.roundRect(ctx, x, y, w, h, 8);
        ctx.stroke();
        
        let titleSize, contentSize, lineHeight;
        if (this.isFullscreen) {
            titleSize = 18;
            contentSize = 14;
            lineHeight = 22;
        } else {
            titleSize = 12;
            contentSize = 10;
            lineHeight = 16;
        }
        
        ctx.fillStyle = color;
        ctx.font = 'bold ' + (this.isFullscreen ? '18px' : '11px') + ' "Segoe UI", Arial';
        ctx.fillText(title, x + (w - ctx.measureText(title).width) / 2, y + 18);
        
        ctx.font = (this.isFullscreen ? '14px' : '9px') + ' "Courier New", monospace';
        
        if (data && data.length > 0) {
            for (let i = 0; i < Math.min(3, data.length); i++) {
                const item = data[i];
                ctx.fillStyle = '#4ec9b0';
                if (item.num !== undefined) {
                    ctx.fillText(`x${item.num}=${this.formatHexShort(item.value)}`, x + 8, y + titleSize + lineHeight + i * lineHeight);
                } else if (item.text) {
                    let maxLen = this.isFullscreen ? 22 : 12;
                    let displayText = item.text.length > maxLen ? item.text.substring(0, maxLen - 2) + '..' : item.text;
                    ctx.fillText(displayText, x + 8, y + titleSize + lineHeight);
                    if (item.value !== undefined) {
                        ctx.fillStyle = '#aaa';
                        ctx.fillText(`结果: ${this.formatHexShort(item.value)}`, x + 8, y + titleSize + lineHeight + 18);
                    }
                    if (item.addr !== undefined) {
                        ctx.fillStyle = '#aaa';
                        ctx.fillText(`${this.formatHexShort(item.addr)}`, x + 8, y + titleSize + lineHeight + 16);
                    }
                }
            }
        } else {
            ctx.fillStyle = '#666';
            ctx.font = `${contentSize}px "Courier New", monospace`;
            ctx.fillText('等待执行...', x + (w - ctx.measureText('等待执行...').width) / 2, y + titleSize + lineHeight + 10);
        }
    }
    
    drawCPUDiagram() {
        const canvas = document.getElementById('cpuCanvas');
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        
        let baseWidth, baseHeight;
        if (this.isFullscreen) {
            baseWidth = 1800;
            baseHeight = 1000;
        } else {
            baseWidth = 600;
            baseHeight = 450;
        }
        
        canvas.width = baseWidth;
        canvas.height = baseHeight;
        
        const scaleX = baseWidth / 600;
        const scaleY = baseHeight / 450;
        
        const baseStageX = [30, 150, 270, 390, 510];
        const stageWidth = 80;
        const stageHeight = 50;
        const stageY = 180;
        
        this.cpuStages = [
            { name: 'IF', x: baseStageX[0] * scaleX, y: stageY * scaleY, width: stageWidth * scaleX, height: stageHeight * scaleY, color: '#4CAF50', active: false },
            { name: 'ID', x: baseStageX[1] * scaleX, y: stageY * scaleY, width: stageWidth * scaleX, height: stageHeight * scaleY, color: '#2196F3', active: false },
            { name: 'EX', x: baseStageX[2] * scaleX, y: stageY * scaleY, width: stageWidth * scaleX, height: stageHeight * scaleY, color: '#FF9800', active: false },
            { name: 'MEM', x: baseStageX[3] * scaleX, y: stageY * scaleY, width: stageWidth * scaleX, height: stageHeight * scaleY, color: '#9C27B0', active: false },
            { name: 'WB', x: baseStageX[4] * scaleX, y: stageY * scaleY, width: stageWidth * scaleX, height: stageHeight * scaleY, color: '#E91E63', active: false }
        ];
        
        ctx.fillStyle = '#e9f8f0ff';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        ctx.strokeStyle = 'rgba(100, 100, 150, 0.3)';
        ctx.lineWidth = 0.5;
        const gridSpacing = 40 * scaleX;
        for (let i = 0; i < canvas.width; i += gridSpacing) {
            ctx.beginPath();
            ctx.moveTo(i, 0);
            ctx.lineTo(i, canvas.height);
            ctx.stroke();
            ctx.beginPath();
            ctx.moveTo(0, i);
            ctx.lineTo(canvas.width, i);
            ctx.stroke();
        }
        
        const fontSize = this.isFullscreen ? 18 : 14;
        const smallFontSize = this.isFullscreen ? 14 : 11;
        
        this.cpuStages.forEach(stage => {
            if (stage.active) {
                ctx.shadowBlur = 20;
                ctx.shadowColor = stage.color;
            } else {
                ctx.shadowBlur = 0;
            }
            
            ctx.fillStyle = stage.active ? stage.color : stage.color + '66';
            this.roundRect(ctx, stage.x, stage.y, stage.width, stage.height, 8);
            ctx.fill();
            
            ctx.strokeStyle = 'rgba(255,255,255,0.3)';
            ctx.lineWidth = 1;
            this.roundRect(ctx, stage.x, stage.y, stage.width, stage.height, 8);
            ctx.stroke();
            
            ctx.fillStyle = '#333333';
            ctx.font = `bold ${fontSize}px "Segoe UI", Arial`;
            ctx.shadowBlur = 0;
            const textX = stage.x + (stage.width - ctx.measureText(stage.name).width) / 2;
            ctx.fillText(stage.name, textX, stage.y + stage.height / 2 + 5);
            
            let instInfo = this.getStageInstruction(stage.name);
            if (instInfo) {
                ctx.font = `${smallFontSize}px "Courier New", monospace`;
                ctx.fillStyle = 'rgba(57, 2, 2, 0.7)';
                
                let displayInst = instInfo;
                if (!this.isFullscreen && instInfo.length > 10) {
                    displayInst = instInfo.substring(0, 8) + '..';
                }
                const instX = stage.x + (stage.width - ctx.measureText(displayInst).width) / 2;
                ctx.fillText(displayInst, instX, stage.y + stage.height - 8);
            }
        });
        
        ctx.shadowBlur = 0;
        
        for (let i = 0; i < this.cpuStages.length - 1; i++) {
            const from = this.cpuStages[i];
            const to = this.cpuStages[i + 1];
            
            ctx.beginPath();
            ctx.moveTo(from.x + from.width, from.y + from.height/2);
            ctx.lineTo(to.x - 5, to.y + to.height/2);
            ctx.strokeStyle = from.active ? from.color : 'rgba(150,150,200,0.5)';
            ctx.lineWidth = 2;
            ctx.stroke();
            
            ctx.beginPath();
            ctx.moveTo(to.x - 5, to.y + to.height/2);
            ctx.lineTo(to.x - 12, to.y + to.height/2 - 5);
            ctx.lineTo(to.x - 12, to.y + to.height/2 + 5);
            ctx.fillStyle = from.active ? from.color : 'rgba(150,150,200,0.5)';
            ctx.fill();
        }
        
        const compY = (this.isFullscreen ? 320 : 280) * scaleY;
        const compHeight = (this.isFullscreen ? 110 : 85) * scaleY;
        const compWidth = (this.isFullscreen ? 170 : 130) * scaleX;
        
        this.drawStyledComponent(ctx, 10 * scaleX, compY, compWidth, compHeight, '#FFD700', '寄存器文件', this.getRecentlyChangedRegisters());
        this.drawStyledComponent(ctx, (this.isFullscreen ? 210 : 220) * scaleX, compY, (this.isFullscreen ? 150 : 110) * scaleX, compHeight, '#FF9800', 'ALU', 
            this.currentALUOp ? [{ text: this.currentALUOp, value: this.currentALUResult }] : []);
        this.drawStyledComponent(ctx, (this.isFullscreen ? 410 : 400) * scaleX, compY, compWidth, compHeight, '#9C27B0', '内存',
            this.lastMemoryAccess ? [{ text: `${this.lastMemoryAccess.type}`, addr: this.lastMemoryAccess.addr, data: this.lastMemoryAccess.data }] : []);
    }
    
    getStageInstruction(stageName) {
        switch(stageName) {
            case 'IF': return this.pipelineStages.if_stage.inst;
            case 'ID': return this.pipelineStages.id_stage.inst;
            case 'EX': return this.pipelineStages.ex_stage.inst;
            case 'MEM': return this.pipelineStages.mem_stage.inst;
            case 'WB': return this.pipelineStages.wb_stage.inst;
            default: return null;
        }
    }
    
    getRecentlyChangedRegisters() {
        return this.regChangeHistory.slice(0, 4);
    }
    
    recordRegChange(regNum, value) {
        this.regChangeHistory.unshift({ num: regNum, value: value });
        if (this.regChangeHistory.length > 8) {
            this.regChangeHistory.pop();
        }
    }
    
    recordALUOp(op, result) {
        this.currentALUOp = op;
        this.currentALUResult = result;
        setTimeout(() => {
            if (this.currentALUOp === op) {
                this.currentALUOp = null;
                this.drawCPUDiagram();
            }
        }, 1000);
    }
    
    recordMemoryAccess(type, addr, data) {
        this.lastMemoryAccess = { type, addr, data };
        setTimeout(() => {
            if (this.lastMemoryAccess && this.lastMemoryAccess.addr === addr) {
                this.lastMemoryAccess = null;
                this.drawCPUDiagram();
            }
        }, 1500);
    }
    
    recordWaveformHistory() {
        this.waveformHistory.push({
            cycle: this.currentCycle,
            if: this.pipelineStages.if_stage.valid,
            id: this.pipelineStages.id_stage.valid,
            ex: this.pipelineStages.ex_stage.valid,
            mem: this.pipelineStages.mem_stage.valid,
            wb: this.pipelineStages.wb_stage.valid
        });
        
        while (this.waveformHistory.length > 40) {
            this.waveformHistory.shift();
        }
    }
    
    drawPipelineDiagram() {
        const canvas = document.getElementById('pipelineCanvas');
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        
        const pipelineContainer = document.getElementById('pipelineContainer');
        const waveformContainer = document.getElementById('waveformContainer');
        
        if (this.currentGraphMode === 'pipeline') {
            if (pipelineContainer) pipelineContainer.style.display = 'block';
            if (waveformContainer) waveformContainer.style.display = 'none';
            this.drawPipelineTiming(ctx);
        } else {
            if (pipelineContainer) pipelineContainer.style.display = 'none';
            if (waveformContainer) waveformContainer.style.display = 'flex';
            const maxRecordedCycle = this.getMaxRecordedCycle();
            if (maxRecordedCycle > 0 || this.currentCycle > 0) {
                this.drawWaveformDisplay();
            } else {
                this.drawEmptyWaveform();
            }
        }
    }
    
    drawPipelineTiming(ctx) {
        const canvas = document.getElementById('pipelineCanvas');
        const container = document.getElementById('pipelineContainer');
        const stages = ['IF', 'ID', 'EX', 'MEM', 'WB'];
        
        let maxCycle = 0;
        for (const inst of this.executionHistory) {
            for (const stage of stages) {
                const cycle = inst.stageCycles[stage];
                if (cycle !== undefined && cycle > maxCycle) maxCycle = cycle;
            }
        }
        
        if (maxCycle === 0) maxCycle = this.currentCycle;
        const displayCycles = Math.max(15, maxCycle + 2);
        
        const cycleWidth = 30;
        const startX = 60;
        const startY = 40;
        const rowHeight = 44;
        const boxWidth = cycleWidth - 4;
        const boxHeight = 40;
        
        const canvasWidth = startX + displayCycles * cycleWidth + 50;
        canvas.width = canvasWidth;
        canvas.height = 400;
        
        canvas.style.width = 'auto';
        canvas.style.height = 'auto';
        
        ctx.fillStyle = '#ffffffff';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        ctx.strokeStyle = '#ddd';
        ctx.lineWidth = 0.5;
        for (let i = 0; i <= displayCycles; i++) {
            ctx.beginPath();
            ctx.moveTo(startX + i * cycleWidth, startY - 10);
            ctx.lineTo(startX + i * cycleWidth, startY + stages.length * rowHeight + 10);
            ctx.stroke();
        }
        
        for (let i = 0; i <= stages.length; i++) {
            ctx.beginPath();
            ctx.moveTo(startX - 10, startY + i * rowHeight);
            ctx.lineTo(startX + displayCycles * cycleWidth + 10, startY + i * rowHeight);
            ctx.stroke();
        }
        
        stages.forEach((stage, idx) => {
            ctx.fillStyle = '#333';
            ctx.font = 'bold 12px Arial';
            ctx.fillText(stage, 10, startY + idx * rowHeight + 25);
        });
        
        ctx.fillStyle = '#888';
        ctx.font = '10px monospace';
        for (let i = 0; i <= displayCycles; i++) {
            if (i % 2 === 0 || i === 0) {
                ctx.fillText(i, startX + i * cycleWidth - 3, startY - 8);
            }
        }
        
        const colors = ['#4CAF50', '#2196F3', '#FF9800', '#9C27B0', '#E91E63'];
        
        this.executionHistory.forEach((inst, instIdx) => {
            for (let stage = 0; stage < stages.length; stage++) {
                let cycle = inst.stageCycles[stages[stage]];
                if (cycle !== undefined && cycle >= 0 && cycle <= displayCycles) {
                    const x = startX + cycle * cycleWidth + 2;
                    const y = startY + stage * rowHeight + 2;
                    const isError = this.errorLine === inst.originalIndex;
                    ctx.fillStyle = isError ? '#f44336' : colors[stage];
                    ctx.fillRect(x, y, boxWidth, boxHeight);
                    
                    ctx.fillStyle = 'white';
                    ctx.font = '8px monospace';
                    let instNum = inst.inst ? inst.inst.substring(0, 4) : `I${instIdx+1}`;
                    if (boxWidth > 15) {
                        ctx.fillText(instNum, x + 3, y + 25);
                    }
                }
            }
        });
        
        this.drawCurrentStageHighlight(ctx, startX, startY, cycleWidth, rowHeight, boxWidth, boxHeight, displayCycles);
        
        if (canvas.width > container.clientWidth) {
            let scrollHint = document.querySelector('.pipeline-scroll-hint');
            if (!scrollHint) {
                const hint = document.createElement('div');
                hint.className = 'scroll-hint pipeline-scroll-hint';
                hint.style.cssText = 'text-align: center; font-size: 11px; color: #999; margin-top: 5px;';
                hint.innerHTML = '↔️ 左右滑动查看更多周期 ↔️';
                container.parentElement.appendChild(hint);
            }
        }
    }
    
    drawCurrentStageHighlight(ctx, startX, startY, cycleWidth, rowHeight, boxWidth, boxHeight, displayCycles) {
        const stages = ['IF', 'ID', 'EX', 'MEM', 'WB'];
        const stageColors = ['#4CAF50', '#2196F3', '#FF9800', '#9C27B0', '#E91E63'];
        
        stages.forEach((stage, idx) => {
            let isActive = false;
            let activeCycle = -1;
            switch(stage) {
                case 'IF': isActive = this.pipelineStages.if_stage.valid; activeCycle = this.pipelineStages.if_stage.cycle; break;
                case 'ID': isActive = this.pipelineStages.id_stage.valid; activeCycle = this.pipelineStages.id_stage.cycle; break;
                case 'EX': isActive = this.pipelineStages.ex_stage.valid; activeCycle = this.pipelineStages.ex_stage.cycle; break;
                case 'MEM': isActive = this.pipelineStages.mem_stage.valid; activeCycle = this.pipelineStages.mem_stage.cycle; break;
                case 'WB': isActive = this.pipelineStages.wb_stage.valid; activeCycle = this.pipelineStages.wb_stage.cycle; break;
            }
            
            if (isActive && activeCycle >= 0 && activeCycle <= displayCycles) {
                const x = startX + activeCycle * cycleWidth + 2;
                const y = startY + idx * rowHeight + 2;
                ctx.strokeStyle = stageColors[idx];
                ctx.lineWidth = 3;
                ctx.strokeRect(x, y, boxWidth, boxHeight);
            }
        });
    }
    
    switchGraph() {
        this.currentGraphMode = this.currentGraphMode === 'pipeline' ? 'waveform' : 'pipeline';
        const btn = document.getElementById('switchGraphBtn');
        const title = document.getElementById('graphTitle');
        
        const pipelineContainer = document.getElementById('pipelineContainer');
        const waveformContainer = document.getElementById('waveformContainer');
        
        if (this.currentGraphMode === 'waveform') {
            btn.textContent = '切换到时空图';
            title.textContent = '波形图';
            
            if (pipelineContainer) pipelineContainer.style.display = 'none';
            if (waveformContainer) waveformContainer.style.display = 'flex';
            
            this.refreshSignalList();
            const maxRecordedCycle = this.getMaxRecordedCycle();
            if (maxRecordedCycle > 0 || this.currentCycle > 0) {
                this.drawWaveformDisplay();
            } else {
                this.drawEmptyWaveform();
            }
        } else {
            btn.textContent = '切换到波形图';
            title.textContent = '流水线时空图';
            
            if (pipelineContainer) pipelineContainer.style.display = 'block';
            if (waveformContainer) waveformContainer.style.display = 'none';
            
            this.drawPipelineDiagram();
        }
    }
    
    // ========== 波形图功能 ==========
    
    initWaveform() {
        this.waveformCanvas = document.getElementById('waveformCanvas');
        if (!this.waveformCanvas) return;
        this.waveformCtx = this.waveformCanvas.getContext('2d');
        
        this.waveformCursors = [];
        this.tracedSignals = [];
        this.signalHistory = {};
        this._skipAutoScroll = false;
        
        this.tracedSignals = [
            { name: 'if_stage', color: '#4CAF50', width: 1 },
            { name: 'id_stage', color: '#2196F3', width: 1 },
            { name: 'ex_stage', color: '#FF9800', width: 1 },
            { name: 'mem_stage', color: '#9C27B0', width: 1 },
            { name: 'wb_stage', color: '#E91E63', width: 1 },
            { name: 'x10', color: '#00BCD4', width: 32 },
            { name: 'x15', color: '#FF5722', width: 32 }
        ];
        
        this.initSignalHistory();
        this.refreshSignalList();
        this.setupWaveformEvents();
        this.drawEmptyWaveform();
    }
    
    drawEmptyWaveform() {
        if (!this.waveformCanvas || !this.waveformCtx) return;
        
        const signalHeight = 45;
        const canvasHeight = Math.max(400, this.tracedSignals.length * signalHeight + 60);
        this.waveformCanvas.height = canvasHeight;
        this.waveformCanvas.width = 1200;
        
        const ctx = this.waveformCtx;
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, this.waveformCanvas.width, this.waveformCanvas.height);
        ctx.fillStyle = '#999';
        ctx.font = '14px Arial';
        ctx.fillText('暂无波形数据，请先运行程序', 450, canvasHeight / 2);
        
        this.updateWaveformInfo();
    }
    
    setupWaveformEvents() {
        if (!this.waveformCanvas) return;
        
        this.waveformCanvas.addEventListener('click', (e) => {
            if (this.currentGraphMode !== 'waveform') return;
            const cycle = this.getCycleFromX(e.clientX);
            if (cycle !== null && cycle >= 0) {
                this.addWaveformCursor(cycle);
            }
        });
        
        this.waveformCanvas.addEventListener('wheel', (e) => {
            if (this.currentGraphMode !== 'waveform') return;
            e.preventDefault();
            
            const container = document.getElementById('waveformCanvasPanel');
            if (!container) return;
            
            const delta = e.deltaY > 0 ? 50 : -50;
            container.scrollLeft += delta;
        });
    }
    
    getCycleFromX(clientX) {
        const container = document.getElementById('waveformCanvasPanel');
        if (!container) return null;
        
        const rect = container.getBoundingClientRect();
        let relativeX = clientX - rect.left;
        const scrollLeft = container.scrollLeft;
        const contentX = relativeX + scrollLeft;
        
        const maxRecordedCycle = this.getMaxRecordedCycle();
        const pixelsPerCycle = 40;
        let startCycle = Math.max(0, maxRecordedCycle - 30);
        const endCycle = maxRecordedCycle;
        
        if (maxRecordedCycle <= 30) {
            startCycle = 0;
        }
        
        const marginLeft = 150;
        
        const cycleX = contentX - marginLeft;
        let cycle = startCycle + cycleX / pixelsPerCycle;
        
        cycle = Math.round(cycle);
        cycle = Math.max(0, Math.min(endCycle, cycle));
        
        return cycle;
    }
    
    scrollToCycle(cycle) {
        const container = document.getElementById('waveformCanvasPanel');
        if (!container) return;
        
        const maxRecordedCycle = this.getMaxRecordedCycle();
        const displayCycles = 30;
        let startCycle = Math.max(0, maxRecordedCycle - Math.floor(displayCycles / 2));
        const endCycle = maxRecordedCycle;
        
        if (startCycle > endCycle) {
            startCycle = Math.max(0, endCycle - displayCycles);
        }
        
        const marginLeft = 150;
        const canvasWidth = this.waveformCanvas.width;
        const graphWidth = canvasWidth - marginLeft - 100;
        const cycleSpan = Math.max(1, endCycle - startCycle);
        const pixelsPerCycle = graphWidth / cycleSpan;
        
        const cycleX = marginLeft + (cycle - startCycle) * pixelsPerCycle;
        const targetScroll = cycleX - container.clientWidth / 2;
        
        if (targetScroll > 0) {
            container.scrollLeft = targetScroll;
        }
    }
    
    refreshSignalList() {
        const container = document.getElementById('signalNameList');
        if (!container) return;
        
        container.innerHTML = '';
        
        const allSignals = [
            { name: 'if_stage', display: 'IF_stage', width: 1 },
            { name: 'id_stage', display: 'ID_stage', width: 1 },
            { name: 'ex_stage', display: 'EX_stage', width: 1 },
            { name: 'mem_stage', display: 'MEM_stage', width: 1 },
            { name: 'wb_stage', display: 'WB_stage', width: 1 }
        ];
        
        for (let i = 0; i < 32; i++) {
            allSignals.push({ name: `x${i}`, display: `x${i}`, width: 32 });
        }
        
        for (const signal of allSignals) {
            const isTraced = this.tracedSignals.some(s => s.name === signal.name);
            const row = document.createElement('div');
            row.className = 'signal-name-row';
            if (isTraced) row.style.background = '#e8f5e9';
            
            row.innerHTML = `
                <span class="signal-name" data-signal="${signal.name}" data-width="${signal.width}">${signal.display}</span>
                <span class="signal-value" id="wave_val_${signal.name.replace(/[^a-zA-Z0-9]/g, '_')}">-</span>
                <span class="signal-remove" data-signal="${signal.name}">✕</span>
            `;
            
            const nameSpan = row.querySelector('.signal-name');
            nameSpan.addEventListener('click', (e) => {
                e.stopPropagation();
                const sigName = nameSpan.getAttribute('data-signal');
                const width = parseInt(nameSpan.getAttribute('data-width'));
                const idx = this.tracedSignals.findIndex(s => s.name === sigName);
                if (idx === -1) {
                    const colors = ['#4CAF50', '#2196F3', '#FF9800', '#9C27B0', '#E91E63', '#00BCD4', '#FF5722', '#795548'];
                    const color = colors[this.tracedSignals.length % colors.length];
                    this.tracedSignals.push({ name: sigName, color: color, width: width });
                    row.style.background = '#e8f5e9';
                    
                    this.initSignalHistoryForNewSignal(sigName);
                    this.fillSignalHistoryFromCurrentData(sigName);
                    
                    this.drawWaveformDisplay();
                } else {
                    this.tracedSignals.splice(idx, 1);
                    row.style.background = '';
                    this.drawWaveformDisplay();
                }
            });
            
            const removeSpan = row.querySelector('.signal-remove');
            removeSpan.addEventListener('click', (e) => {
                e.stopPropagation();
                const sigName = removeSpan.getAttribute('data-signal');
                const idx = this.tracedSignals.findIndex(s => s.name === sigName);
                if (idx !== -1) {
                    this.tracedSignals.splice(idx, 1);
                    row.style.background = '';
                    this.drawWaveformDisplay();
                }
            });
            
            container.appendChild(row);
        }
        
        if (this.currentGraphMode === 'waveform') {
            this.drawWaveformDisplay();
        }
    }
    
    initSignalHistory() {
        this.tracedSignals.forEach(signal => {
            if (!this.signalHistory[signal.name]) {
                this.signalHistory[signal.name] = [];
            }
        });
    }
    
    recordSignalValues() {
        this.tracedSignals.forEach(signal => {
            let value;
            
            if (signal.name.startsWith('x')) {
                const regNum = parseInt(signal.name.substring(1));
                value = this.registers[regNum] || 0;
            } else if (signal.name === 'if_stage') {
                value = this.pipelineStages.if_stage.valid ? 1 : 0;
            } else if (signal.name === 'id_stage') {
                value = this.pipelineStages.id_stage.valid ? 1 : 0;
            } else if (signal.name === 'ex_stage') {
                value = this.pipelineStages.ex_stage.valid ? 1 : 0;
            } else if (signal.name === 'mem_stage') {
                value = this.pipelineStages.mem_stage.valid ? 1 : 0;
            } else if (signal.name === 'wb_stage') {
                value = this.pipelineStages.wb_stage.valid ? 1 : 0;
            } else {
                value = 0;
            }
            
            if (!this.signalHistory[signal.name]) {
                this.signalHistory[signal.name] = [];
            }
            
            const existingRecord = this.signalHistory[signal.name].find(r => r.cycle === this.currentCycle);
            if (!existingRecord) {
                this.signalHistory[signal.name].push({ 
                    cycle: this.currentCycle, 
                    value: value 
                });
            }
        });
        
        this.updateSignalListValues();
        this.updateWaveformInfo(); 
        this.drawWaveformDisplay();
    }
    
    updateSignalListValues() {
        for (const signal of this.tracedSignals) {
            let value;
            if (signal.name.startsWith('x')) {
                const regNum = parseInt(signal.name.substring(1));
                value = this.registers[regNum] || 0;
            } else if (signal.name === 'if_stage') {
                value = this.pipelineStages.if_stage.valid ? 1 : 0;
            } else if (signal.name === 'id_stage') {
                value = this.pipelineStages.id_stage.valid ? 1 : 0;
            } else if (signal.name === 'ex_stage') {
                value = this.pipelineStages.ex_stage.valid ? 1 : 0;
            } else if (signal.name === 'mem_stage') {
                value = this.pipelineStages.mem_stage.valid ? 1 : 0;
            } else if (signal.name === 'wb_stage') {
                value = this.pipelineStages.wb_stage.valid ? 1 : 0;
            } else {
                value = 0;
            }
            
            const valSpan = document.getElementById(`wave_val_${signal.name.replace(/[^a-zA-Z0-9]/g, '_')}`);
            if (valSpan) {
                if (signal.width === 1) {
                    valSpan.textContent = value ? '1' : '0';
                } else {
                    valSpan.textContent = this.formatHexShort(value);
                }
            }
        }
    }
    
    drawWaveformDisplay() {
        if (!this.waveformCanvas || !this.waveformCtx) return;
        
        const maxRecordedCycle = this.getMaxRecordedCycle();
        
        if (maxRecordedCycle === 0 && this.currentCycle === 0) {
            this.drawEmptyWaveform();
            return;
        }
        
        if (this.tracedSignals.length === 0) {
            this.drawEmptyWaveform();
            return;
        }
        
        const signalHeight = 45;
        const canvasHeight = this.tracedSignals.length * signalHeight + 60;
        this.waveformCanvas.height = canvasHeight;
        
        const pixelsPerCycle = 40;
        let startCycle = Math.max(0, maxRecordedCycle - 30);
        const endCycle = maxRecordedCycle;
        
        if (maxRecordedCycle <= 30) {
            startCycle = 0;
        }
        
        const cycleSpan = Math.max(1, endCycle - startCycle);
        const marginLeft = 150;
        const marginRight = 100;
        const marginTop = 10;
        
        const canvasWidth = marginLeft + cycleSpan * pixelsPerCycle + marginRight;
        this.waveformCanvas.width = canvasWidth;
        
        const graphWidth = canvasWidth - marginLeft - marginRight;
        
        const ctx = this.waveformCtx;
        
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, canvasWidth, canvasHeight);
        
        ctx.strokeStyle = '#ddd';
        ctx.lineWidth = 0.5;
        ctx.fillStyle = '#888';
        ctx.font = '10px monospace';
        
        for (let cycle = startCycle; cycle <= endCycle; cycle++) {
            const x = marginLeft + (cycle - startCycle) * pixelsPerCycle;
            ctx.beginPath();
            ctx.moveTo(x, marginTop);
            ctx.lineTo(x, canvasHeight - 25);
            ctx.stroke();
            
            if (cycle % 5 === 0 || cycle === startCycle || cycle === endCycle) {
                ctx.fillStyle = '#888';
                ctx.fillText(cycle, x - 5, canvasHeight - 10);
            }
        }
        
        for (let idx = 0; idx < this.tracedSignals.length; idx++) {
            const signal = this.tracedSignals[idx];
            const yBase = marginTop + idx * signalHeight + signalHeight / 2;
            const history = this.signalHistory[signal.name] || [];
            
            if (history.length === 0) continue;
            
            const nameBgWidth = 130;
            ctx.fillStyle = '#f8f8f8';
            ctx.fillRect(0, marginTop + idx * signalHeight, nameBgWidth, signalHeight);
            ctx.strokeStyle = '#e0e0e0';
            ctx.strokeRect(0, marginTop + idx * signalHeight, nameBgWidth, signalHeight);
            
            ctx.fillStyle = signal.color;
            ctx.font = 'bold 13px monospace';
            ctx.fillText(signal.name, 8, yBase + 4);
            
            const currentValue = history.length > 0 ? history[history.length - 1].value : 0;
            let displayValue;
            if (signal.width === 1) {
                displayValue = currentValue ? '1' : '0';
            } else {
                displayValue = this.formatHexShort(currentValue);
            }
            ctx.fillStyle = '#000000';
            ctx.font = 'bold 12px monospace';
            ctx.fillText(displayValue, nameBgWidth - 45, yBase + 4);
            
            ctx.beginPath();
            ctx.strokeStyle = '#e0e0e0';
            ctx.moveTo(marginLeft - 5, marginTop + idx * signalHeight);
            ctx.lineTo(canvasWidth - marginRight + 5, marginTop + idx * signalHeight);
            ctx.stroke();
            
            const cycleValueMap = new Map();
            for (const record of history) {
                if (record.cycle <= endCycle) {
                    cycleValueMap.set(record.cycle, record.value);
                }
            }
            
            let lastKnownValue = 0;
            for (let cycle = startCycle; cycle <= endCycle; cycle++) {
                if (cycleValueMap.has(cycle)) {
                    lastKnownValue = cycleValueMap.get(cycle);
                }
                cycleValueMap.set(cycle, lastKnownValue);
            }
            
            if (signal.width === 1) {
                ctx.beginPath();
                ctx.strokeStyle = signal.color;
                ctx.lineWidth = 1.5;
                
                let lastX = null;
                let lastY = null;
                
                for (let cycle = startCycle; cycle <= endCycle; cycle++) {
                    const value = cycleValueMap.get(cycle) || 0;
                    const x = marginLeft + (cycle - startCycle) * pixelsPerCycle;
                    const y = yBase - (value ? 12 : -12);
                    
                    if (lastX !== null) {
                        ctx.moveTo(lastX, lastY);
                        ctx.lineTo(x, lastY);
                        ctx.moveTo(x, lastY);
                        ctx.lineTo(x, y);
                    }
                    
                    lastX = x;
                    lastY = y;
                }
                ctx.stroke();
            } else {
                ctx.font = '12px monospace';
                
                for (let cycle = startCycle; cycle <= endCycle; cycle++) {
                    const value = cycleValueMap.get(cycle) || 0;
                    const x = marginLeft + (cycle - startCycle) * pixelsPerCycle;
                    const displayVal = this.formatHexShort(value);
                    ctx.fillStyle = '#000000';
                    ctx.fillText(displayVal, x + 2, yBase + 4);
                }
            }
        }
        
        for (const cursor of this.waveformCursors) {
            if (cursor.cycle > endCycle) continue;
            const x = marginLeft + (cursor.cycle - startCycle) * pixelsPerCycle;
            if (x >= marginLeft - 10 && x <= canvasWidth - marginRight + 10) {
                ctx.beginPath();
                ctx.strokeStyle = '#f44336';
                ctx.lineWidth = 1.5;
                ctx.moveTo(x, marginTop);
                ctx.lineTo(x, canvasHeight - 25);
                ctx.stroke();
                
                ctx.fillStyle = '#e8b024ff';
                ctx.fillRect(x + 3, marginTop, 55, 18);
                ctx.fillStyle = 'white';
                ctx.font = '9px monospace';
                ctx.fillText(`T=${cursor.cycle}`, x + 6, marginTop + 13);
                
                cursor.values = [];
                for (const signal of this.tracedSignals) {
                    const history = this.signalHistory[signal.name] || [];
                    let value = 0;
                    for (let i = history.length - 1; i >= 0; i--) {
                        if (history[i].cycle <= cursor.cycle) {
                            value = history[i].value;
                            break;
                        }
                    }
                    let displayVal;
                    if (signal.width === 1) {
                        displayVal = value ? '1' : '0';
                    } else {
                        displayVal = this.formatHexShort(value);
                    }
                    cursor.values.push({ name: signal.name, value: displayVal });
                }
            }
        }
        
        this.updateCursorStatus();
        
        const container = document.getElementById('waveformCanvasPanel');
        if (container && !this._skipAutoScroll) {
            const latestX = marginLeft + (endCycle - startCycle) * pixelsPerCycle;
            const targetScroll = latestX - container.clientWidth * 0.7;
            if (targetScroll > 0 && Math.abs(container.scrollLeft - targetScroll) > 50) {
                container.scrollLeft = targetScroll;
            }
        }
        this._skipAutoScroll = false;
    }
    
    getMaxRecordedCycle() {
        let maxCycle = 0;
        for (const signal of this.tracedSignals) {
            const history = this.signalHistory[signal.name] || [];
            if (history.length > 0) {
                const lastCycle = history[history.length - 1].cycle;
                if (lastCycle > maxCycle) maxCycle = lastCycle;
            }
        }
        return Math.max(maxCycle, this.currentCycle);
    }
    
    addWaveformCursor(cycle) {
        const existing = this.waveformCursors.find(c => c.cycle === cycle);
        if (existing) {
            this.showMessage(`光标已存在于周期 ${cycle}`, 'info');
            return;
        }
        
        this.waveformCursors.push({ cycle });
        this.waveformCursors.sort((a, b) => a.cycle - b.cycle);
        
        this._skipAutoScroll = true;
        this.drawWaveformDisplay();
        this.scrollToCycle(cycle);
        
        this.showMessage(`添加光标在周期 ${cycle}`, 'info');
    }
    
    clearWaveformCursors() {
        this.waveformCursors = [];
        this.drawWaveformDisplay();
        this.updateCursorStatus();
        this.showMessage('已清除所有光标', 'success');
    }
    
    updateCursorStatus() {
        const statusSpan = document.getElementById('cursorPositions');
        if (statusSpan) {
            if (this.waveformCursors.length > 0) {
                const positions = this.waveformCursors.map(c => `T${c.cycle}`).join(', ');
                let html = `光标位置: ${positions}`;
                
                for (const cursor of this.waveformCursors) {
                    if (cursor.values) {
                        const valueStr = cursor.values.map(v => `${v.name}=${v.value}`).join(' | ');
                        html += `<br><span style="font-size: 10px; color: #070606ff;">T${cursor.cycle}: ${valueStr}</span>`;
                    }
                }
                statusSpan.innerHTML = html;
            } else {
                statusSpan.innerHTML = '光标位置: -';
            }
        }
    }
    
    updateWaveformInfo() {
        const infoSpan = document.getElementById('waveformInfo');
        if (infoSpan) {
            infoSpan.textContent = `周期: ${this.currentCycle}`;
        }
    }
    
    // ========== 汇编加载和显示 ==========
    
    loadAssemblyCode() {
        const precompiled = localStorage.getItem('precompiledAssembly');
        const executionLog = localStorage.getItem('executionLog');
        const isExample = localStorage.getItem('isExample');
        
        if (precompiled) {
            this.asmInstructions = JSON.parse(precompiled);
            localStorage.removeItem('precompiledAssembly');
        } else {
            const sourceCode = localStorage.getItem('userCode') || this.getDefaultCode();
            this.asmInstructions = this.compileToAssembly(sourceCode);
        }
        
        if (executionLog) {
            this.executionLog = JSON.parse(executionLog);
            this.isReplaying = true;
            this.logStepIndex = 0;
            console.log('进入回放模式，共', this.executionLog.totalSteps, '步');
            
            if (isExample === 'example1') {
                this.asmInstructions = this.example1Log.instructions;
            } else if (isExample === 'example2') {
                this.asmInstructions = this.example2Log.instructions;
            }
        }
        
        this.displayAssembly();
    }
    
    getDefaultCode() {
        return `int main() {\n    int a = 5;\n    int b = 3;\n    int c = a + b;\n    return c;\n}`;
    }
    
    compileToAssembly(code) {
        if (code.includes('0x20004') || (code.includes('*ptr') && code.includes('100'))) {
            return [
                { addr: 0x10000, inst: "addi sp, sp, -32", raw: "0xfd010113", decoded: "addi sp, sp, -32" },
                { addr: 0x10004, inst: "li a5, 100", raw: "0x06400793", decoded: "li a5, 100" },
                { addr: 0x10008, inst: "lui a5, 0x2000", raw: "0x200007b7", decoded: "lui a5, 0x2000" },
                { addr: 0x1000c, inst: "addi a5, a5, 4", raw: "0x00478793", decoded: "addi a5, a5, 4" },
                { addr: 0x10010, inst: "sw a5, 0(a5)", raw: "0x00f7a023", decoded: "sw a5, 0(a5)", isBad: true },
                { addr: 0x10014, inst: "li a0, 0", raw: "0x00000513", decoded: "li a0, 0" },
                { addr: 0x10018, inst: "addi sp, sp, 32", raw: "0x02010113", decoded: "addi sp, sp, 32" },
                { addr: 0x1001c, inst: "ret", raw: "0x00008067", decoded: "ret" }
            ];
        }
        
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
    
    displayAssembly() {
        const container = document.getElementById('asmList');
        if (!container) return;
        
        container.innerHTML = '';
        this.asmInstructions.forEach((inst, idx) => {
            const div = document.createElement('div');
            div.className = 'asm-item';
            if (this.breakpoints.has(inst.addr)) div.classList.add('breakpoint');
            if (this.errorLine === idx) div.classList.add('error-line');
            if (this.currentPC === inst.addr) div.classList.add('current');
            
            div.innerHTML = `
                <span class="breakpoint-icon">${this.breakpoints.has(inst.addr) ? '🔴' : '⚪'}</span>
                <span class="addr">${this.formatHex(inst.addr)}</span>
                <span class="opcode">${inst.inst.split(' ')[0]}</span>
                <span class="args">${inst.inst.split(' ').slice(1).join(' ')}</span>
            `;
            
            div.onclick = () => this.toggleBreakpoint(inst.addr);
            container.appendChild(div);
        });
    }
    
    toggleBreakpoint(addr) {
        if (this.breakpoints.has(addr)) {
            this.breakpoints.delete(addr);
        } else {
            this.breakpoints.add(addr);
        }
        this.displayAssembly();
    }
    
    addBreakpoint() {
        const currentInst = this.asmInstructions.find(i => i.addr === this.currentPC);
        if (currentInst) {
            this.toggleBreakpoint(currentInst.addr);
            this.showMessage(`断点已添加在 ${this.formatHex(currentInst.addr)}`, 'success');
        }
    }
    
    clearBreakpoints() {
        this.breakpoints.clear();
        this.displayAssembly();
        this.showMessage('所有断点已清除', 'success');
    }
    
    initRegisters() {
        const container = document.getElementById('registersGrid');
        if (!container) return;
        
        container.innerHTML = '';
        for (let i = 0; i < 32; i++) {
            const div = document.createElement('div');
            div.className = 'reg-item';
            div.id = `reg_${i}`;
            div.innerHTML = `<strong>x${i}</strong><br>0x00000000`;
            container.appendChild(div);
        }
    }
    
    updateRegistersDisplay() {
        for (let i = 0; i < 32; i++) {
            const regElem = document.getElementById(`reg_${i}`);
            if (regElem) {
                const oldText = regElem.innerHTML.split('<br>')[1] || '0x0';
                let oldValue = 0;
                if (oldText && oldText !== 'NaN' && !oldText.includes('NaN')) {
                    oldValue = parseInt(oldText, 16);
                    if (isNaN(oldValue)) oldValue = 0;
                }
                
                const newValue = this.registers[i] || 0;
                
                if (oldValue !== newValue && newValue !== undefined) {
                    this.recordRegChange(i, newValue);
                    regElem.innerHTML = `<strong>x${i}</strong><br>${this.formatHex(newValue)}`;
                    regElem.classList.add('changed');
                    setTimeout(() => regElem.classList.remove('changed'), 500);
                } else if (!regElem.innerHTML.includes(this.formatHex(newValue))) {
                    regElem.innerHTML = `<strong>x${i}</strong><br>${this.formatHex(newValue)}`;
                }
            }
        }
        
        document.getElementById('pcValue').textContent = this.formatHex(this.currentPC);
        
        const currentInst = this.asmInstructions.find(i => i.addr === this.currentPC);
        if (currentInst) {
            document.getElementById('currentInst').textContent = currentInst.inst;
            document.getElementById('rawInst').textContent = currentInst.raw;
            document.getElementById('decodedInst').textContent = currentInst.decoded;
        }
    }
    
    // ========== 指令执行 ==========
    
    async executeInstruction(inst, instIndex) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                // ========== 检查是否是自定义指令 ==========
                const rawValue = parseInt(inst.raw, 16);
                const opcodeNum = rawValue & 0x7F;
                
                const customHandler = this.customHandlers[opcodeNum];
                if (customHandler) {
                    try {
                        const rs1 = (rawValue >> 15) & 0x1F;
                        const rs2 = (rawValue >> 20) & 0x1F;
                        const rd = (rawValue >> 7) & 0x1F;
                        const imm = this.getImmediateFromInst(inst.inst);
                        
                        const inContext = {
                            val_rs1: this.registers[rs1] || 0,
                            val_rs2: this.registers[rs2] || 0,
                            imm: imm,
                            pc: this.currentPC
                        };
                        const outContext = {};
                        
                        customHandler(inContext, outContext);
                        
                        if (outContext.reg_write && rd !== 0) {
                            this.registers[rd] = outContext.alu_result;
                            this.recordRegChange(rd, outContext.alu_result);
                        }
                        
                        if (outContext.mem_write) {
                            if (!this.memory) this.memory = {};
                            this.memory[outContext.mem_addr] = outContext.mem_data;
                            this.recordMemoryAccess('写', outContext.mem_addr, outContext.mem_data);
                        }
                        
                        if (outContext.pc_modified && outContext.next_pc) {
                            this.pendingNextPC = outContext.next_pc;
                        }
                        
                        this.recordALUOp(`自定义指令 ${inst.inst}`, outContext.alu_result);
                        resolve();
                        return;
                    } catch(e) {
                        reject(new Error(`自定义指令执行错误: ${e.message}`));
                        return;
                    }
                }
                // ========== 自定义指令检查结束 ==========
                
                const parts = inst.inst.split(/\s+/);
                const op = parts[0];
                
                const getRegNum = (regName) => {
                    const regMap = {
                        'sp': 2, 's0': 8, 'fp': 8, 'ra': 1,
                        'a0': 10, 'a1': 11, 'a2': 12, 'a3': 13,
                        'a4': 14, 'a5': 15, 't0': 5, 't1': 6, 't2': 7,
                        'zero': 0, 'x0': 0
                    };
                    return regMap[regName] !== undefined ? regMap[regName] : 0;
                };
                
                try {
                    if (op === 'addi') {
                        const match = inst.inst.match(/addi\s+([^,]+),\s*([^,]+),\s*(-?\d+)/);
                        if (match) {
                            const destReg = match[1].trim();
                            const srcReg = match[2].trim();
                            const imm = parseInt(match[3]);
                            const destNum = getRegNum(destReg);
                            const srcNum = getRegNum(srcReg);
                            const srcVal = this.registers[srcNum] !== undefined ? this.registers[srcNum] : 0;
                            const result = srcVal + imm;
                            if (destNum !== 0) {
                                this.registers[destNum] = result;
                                this.recordRegChange(destNum, result);
                            }
                            this.recordALUOp(`addi ${destReg}, ${srcReg}, ${imm}`, result);
                        }
                    }
                    else if (op === 'li') {
                        const match = inst.inst.match(/li\s+([^,]+),\s*(-?\d+)/);
                        if (match) {
                            const destReg = match[1].trim();
                            const value = parseInt(match[2]);
                            const destNum = getRegNum(destReg);
                            if (destNum !== 0) {
                                this.registers[destNum] = value;
                                this.recordRegChange(destNum, value);
                            }
                            this.recordALUOp(`li ${destReg}=${value}`, value);
                        }
                    }
                    else if (op === 'sw') {
                        const match = inst.inst.match(/sw\s+([^,]+),\s*(-?\d+)\(([^)]+)\)/);
                        if (match) {
                            const srcReg = match[1].trim();
                            const offset = parseInt(match[2]);
                            const baseReg = match[3].trim();
                            const srcNum = getRegNum(srcReg);
                            const baseNum = getRegNum(baseReg);
                            const baseAddr = this.registers[baseNum] !== undefined ? this.registers[baseNum] : 0;
                            const targetAddr = baseAddr + offset;
                            const value = this.registers[srcNum] !== undefined ? this.registers[srcNum] : 0;
                            
                            if (!this.memory) this.memory = {};
                            this.memory[targetAddr] = value;
                            this.recordMemoryAccess('写', targetAddr, value);
                        }
                    }
                    else if (op === 'lw') {
                        const match = inst.inst.match(/lw\s+([^,]+),\s*(-?\d+)\(([^)]+)\)/);
                        if (match) {
                            const destReg = match[1].trim();
                            const offset = parseInt(match[2]);
                            const baseReg = match[3].trim();
                            const destNum = getRegNum(destReg);
                            const baseNum = getRegNum(baseReg);
                            const baseAddr = this.registers[baseNum] !== undefined ? this.registers[baseNum] : 0;
                            const targetAddr = baseAddr + offset;
                            
                            let value = 0;
                            if (this.memory && this.memory[targetAddr] !== undefined) {
                                value = this.memory[targetAddr];
                            }
                            
                            if (destNum !== 0) {
                                this.registers[destNum] = value;
                                this.recordRegChange(destNum, value);
                            }
                            this.recordMemoryAccess('读', targetAddr, value);
                        }
                    }
                    else if (op === 'add') {
                        const match = inst.inst.match(/add\s+([^,]+),\s*([^,]+),\s*([^,]+)/);
                        if (match) {
                            const destReg = match[1].trim();
                            const src1Reg = match[2].trim();
                            const src2Reg = match[3].trim();
                            const destNum = getRegNum(destReg);
                            const src1Num = getRegNum(src1Reg);
                            const src2Num = getRegNum(src2Reg);
                            const val1 = this.registers[src1Num] !== undefined ? this.registers[src1Num] : 0;
                            const val2 = this.registers[src2Num] !== undefined ? this.registers[src2Num] : 0;
                            const result = val1 + val2;
                            if (destNum !== 0) {
                                this.registers[destNum] = result;
                                this.recordRegChange(destNum, result);
                            }
                            this.recordALUOp(`add ${destReg}, ${src1Reg}, ${src2Reg}`, result);
                        }
                    }
                    else if (op === 'mv') {
                        const match = inst.inst.match(/mv\s+([^,]+),\s*([^,]+)/);
                        if (match) {
                            const destReg = match[1].trim();
                            const srcReg = match[2].trim();
                            const destNum = getRegNum(destReg);
                            const srcNum = getRegNum(srcReg);
                            const value = this.registers[srcNum] !== undefined ? this.registers[srcNum] : 0;
                            if (destNum !== 0) {
                                this.registers[destNum] = value;
                                this.recordRegChange(destNum, value);
                            }
                            this.recordALUOp(`mv ${destReg}, ${srcReg}`, value);
                        }
                    }
                    else if (op === 'ret') {
                        this.showMessage('程序执行完毕，ret指令', 'success');
                    }
                    
                    resolve();
                } catch (error) {
                    reject(error);
                }
            }, 100);
        });
    }
    
    updatePipelineAfterExecute(inst, instIndex) {
        const currentCycle = this.currentCycle;
        
        let existingInst = this.executionHistory.find(h => h.originalIndex === instIndex);
        
        if (!existingInst) {
            existingInst = {
                inst: inst.inst,
                originalIndex: instIndex,
                stageCycles: { IF: currentCycle }
            };
            this.executionHistory.push(existingInst);
        } else {
            existingInst.stageCycles.IF = currentCycle;
        }
        
        for (let i = 0; i < this.executionHistory.length; i++) {
            const histInst = this.executionHistory[i];
            
            if (this.pipelineStages.id_stage.inst === histInst.inst && !histInst.stageCycles.ID) {
                histInst.stageCycles.ID = currentCycle - 1;
            }
            if (this.pipelineStages.ex_stage.inst === histInst.inst && !histInst.stageCycles.EX) {
                histInst.stageCycles.EX = currentCycle - 2;
            }
            if (this.pipelineStages.mem_stage.inst === histInst.inst && !histInst.stageCycles.MEM) {
                histInst.stageCycles.MEM = currentCycle - 3;
            }
            if (this.pipelineStages.wb_stage.inst === histInst.inst && !histInst.stageCycles.WB) {
                histInst.stageCycles.WB = currentCycle - 4;
            }
        }
        
        this.pipelineStages.wb_stage = { ...this.pipelineStages.mem_stage };
        this.pipelineStages.mem_stage = { ...this.pipelineStages.ex_stage };
        this.pipelineStages.ex_stage = { ...this.pipelineStages.id_stage };
        this.pipelineStages.id_stage = { ...this.pipelineStages.if_stage };
        
        this.pipelineStages.if_stage = {
            valid: true,
            pc: this.currentPC,
            inst: inst.inst,
            cycle: currentCycle
        };
        
        while (this.executionHistory.length > 20) {
            this.executionHistory.shift();
        }
        
        this.recordWaveformHistory();
        this.updateCPUStageActive();
    }
    
    updateCPUStageActive() {
        this.cpuStages.forEach(stage => {
            switch(stage.name) {
                case 'IF': stage.active = this.pipelineStages.if_stage.valid; break;
                case 'ID': stage.active = this.pipelineStages.id_stage.valid; break;
                case 'EX': stage.active = this.pipelineStages.ex_stage.valid; break;
                case 'MEM': stage.active = this.pipelineStages.mem_stage.valid; break;
                case 'WB': stage.active = this.pipelineStages.wb_stage.valid; break;
            }
        });
    }
    
    // ========== 执行控制 ==========
    
    async step() {
        if (this.errorOccurred) {
            this.showError('程序已出错，请按 CTRL+F 修改代码后重新运行');
            return;
        }
        
        // 处理自定义指令的跳转
        if (this.pendingNextPC) {
            this.currentPC = this.pendingNextPC;
            this.pendingNextPC = null;
        }
        
        // 回放模式
        if (this.isReplaying && this.executionLog) {
            if (this.logStepIndex >= this.executionLog.totalSteps) {
                this.showMessage('程序执行完毕', 'success');
                return;
            }
            
            if (this.executionLog.registers) {
                const progress = this.logStepIndex / this.executionLog.totalSteps;
                for (const [reg, finalValue] of Object.entries(this.executionLog.registers)) {
                    const regNum = parseInt(reg.replace('x', ''));
                    if (!isNaN(regNum)) {
                        const currentValue = Math.floor(finalValue * progress);
                        this.registers[regNum] = currentValue;
                    }
                }
            }
            
            this.logStepIndex++;
            this.currentCycle++;
            this.updateRegistersDisplay();
            this.updateWaveformInfo(); 
            this.drawCPUDiagram();
            this.drawPipelineDiagram();
            this.recordSignalValues();
            
            this.showMessage(`回放模式: 步骤 ${this.logStepIndex}/${this.executionLog.totalSteps}`, 'info');
            return;
        }
        
        if (this.breakpoints.has(this.currentPC)) {
            this.showMessage(`🔴 断点命中: ${this.formatHex(this.currentPC)}，请再次点击单步继续`, 'info');
            return;
        }
        
        const currentInst = this.asmInstructions.find(i => i.addr === this.currentPC);
        if (!currentInst) {
            this.showMessage('程序执行完毕', 'success');
            return;
        }
        
        const instIndex = this.asmInstructions.findIndex(i => i.addr === this.currentPC);
        
        try {
            await this.executeInstruction(currentInst, instIndex);
            this.updatePipelineAfterExecute(currentInst, instIndex);
            
            const nextIndex = instIndex + 1;
            if (nextIndex < this.asmInstructions.length) {
                this.currentPC = this.asmInstructions[nextIndex].addr;
            } else {
                this.showMessage('程序执行完毕', 'success');
                return;
            }
            
            this.currentCycle++;
            this.updateRegistersDisplay();
            this.updateWaveformInfo();
            this.highlightCurrentInstruction(false);
            this.drawCPUDiagram();
            this.drawPipelineDiagram();
            this.recordSignalValues();
            
            if (this.breakpoints.has(this.currentPC)) {
                this.showMessage(`🔴 断点命中: ${this.formatHex(this.currentPC)}，程序已暂停`, 'info');
            }
            
        } catch (error) {
            this.handleExecutionError(error, currentInst, instIndex);
        }
    }
    
    handleExecutionError(error, inst, instIndex) {
        this.errorOccurred = true;
        this.errorLine = instIndex;
        this.isRunning = false;
        
        this.showConsole();
        
        const consoleContent = document.getElementById('consoleContent');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.innerHTML = `
            <strong>❌ ${error.message.split('\n')[0]}</strong><br>
            ${error.message.split('\n')[1] || ''}<br>
            ${error.message.split('\n')[2] || ''}<br>
            地址：${this.formatHex(inst.addr)} | 指令：${inst.inst}<br>
            原始码：${inst.raw}
        `;
        consoleContent.appendChild(errorDiv);
        
        this.drawCPUDiagram();
        this.drawPipelineDiagram();
        this.displayAssembly();
        this.highlightCurrentInstruction(true);
        
        const indicator = document.getElementById('breakpointIndicator');
        if (indicator) {
            indicator.style.display = 'block';
            setTimeout(() => { indicator.style.display = 'none'; }, 3000);
        }
        
        setTimeout(() => this.openCodePanel(), 500);
    }
    
    highlightCurrentInstruction(scrollToView = false) {
        const items = document.querySelectorAll('.asm-item');
        items.forEach((item) => {
            item.classList.remove('current');
            const addrText = item.querySelector('.addr')?.textContent;
            if (addrText === this.formatHex(this.currentPC)) {
                item.classList.add('current');
                if (scrollToView) {
                    item.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    }
    
    runFull() {
        if (this.isRunning) {
            this.showMessage('程序已在运行中', 'info');
            return;
        }
        
        if (this.isReplaying && this.executionLog) {
            this.isRunning = true;
            
            const runNext = async () => {
                if (!this.isRunning) return;
                if (this.logStepIndex >= this.executionLog.totalSteps) {
                    this.showMessage('程序执行完毕', 'success');
                    this.isRunning = false;
                    return;
                }
                
                if (this.executionLog.registers) {
                    const progress = this.logStepIndex / this.executionLog.totalSteps;
                    for (const [reg, finalValue] of Object.entries(this.executionLog.registers)) {
                        const regNum = parseInt(reg.replace('x', ''));
                        if (!isNaN(regNum)) {
                            const currentValue = Math.floor(finalValue * progress);
                            this.registers[regNum] = currentValue;
                        }
                    }
                }
                
                this.logStepIndex++;
                this.currentCycle++;
                this.updateRegistersDisplay();
                this.updateWaveformInfo(); 
                this.drawCPUDiagram();
                this.drawPipelineDiagram();
                this.recordSignalValues();
                
                this.showMessage(`回放模式: 步骤 ${this.logStepIndex}/${this.executionLog.totalSteps}`, 'info');
                
                if (this.isRunning && this.logStepIndex < this.executionLog.totalSteps) {
                    setTimeout(runNext, 200);
                } else {
                    this.isRunning = false;
                }
            };
            
            runNext();
            return;
        }
        
        this.isRunning = true;
        
        const runNext = async () => {
            if (this.errorOccurred) {
                this.isRunning = false;
                return;
            }
            if (this.breakpoints.has(this.currentPC)) {
                this.showMessage(`断点命中，暂停执行`, 'info');
                this.isRunning = false;
                return;
            }
            
            const currentInst = this.asmInstructions.find(i => i.addr === this.currentPC);
            if (!currentInst) {
                this.isRunning = false;
                return;
            }
            
            const instIndex = this.asmInstructions.findIndex(i => i.addr === this.currentPC);
            
            try {
                await this.executeInstruction(currentInst, instIndex);
                this.updatePipelineAfterExecute(currentInst, instIndex);
                
                const nextIndex = instIndex + 1;
                if (nextIndex < this.asmInstructions.length) {
                    this.currentPC = this.asmInstructions[nextIndex].addr;
                } else {
                    this.showMessage('程序执行完毕', 'success');
                    this.isRunning = false;
                    return;
                }
                
                this.currentCycle++;
                this.updateRegistersDisplay();
                this.updateWaveformInfo(); 
                this.highlightCurrentInstruction(false);
                this.drawCPUDiagram();
                this.drawPipelineDiagram();
                this.recordSignalValues();
                
                if (this.breakpoints.has(this.currentPC)) {
                    this.showMessage(`断点命中，暂停执行`, 'info');
                    this.isRunning = false;
                    return;
                }
                
            } catch (error) {
                this.handleExecutionError(error, currentInst, instIndex);
                this.isRunning = false;
                return;
            }
            
            if (!this.errorOccurred && this.currentPC && this.isRunning) {
                setTimeout(runNext, 300);
            } else {
                this.isRunning = false;
            }
        };
        runNext();
    }
    
    reset() {
        this.currentPC = 0x10000;
        this.registers.fill(0);
        this.memory = {};
        
        this.registers[2] = 0x1F000;
        this.registers[1] = 0x10000;
        this.registers[3] = 0x138F0;
        this.registers[8] = 0x1F000;
        
        this.errorOccurred = false;
        this.errorLine = -1;
        this.currentCycle = 0;
        this.updateWaveformInfo(); 
        this.executionHistory = [];
        this.waveformHistory = [];
        this.regChangeHistory = [];
        this.currentALUOp = null;
        this.lastMemoryAccess = null;
        this.isRunning = false;
        this.pendingNextPC = null;
        
        if (this.isReplaying) {
            this.logStepIndex = 0;
            this.registers.fill(0);
            this.registers[2] = 0x1F000;
            this.registers[1] = 0x10000;
            this.registers[3] = 0x138F0;
            this.registers[8] = 0x1F000;
        }
        
        this.signalHistory = {};
        this.initSignalHistory();
        this.waveformCursors = [];
        
        if (this.currentGraphMode === 'waveform') {
            this.drawEmptyWaveform();
        }
        
        this.pipelineStages = {
            if_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            id_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            ex_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            mem_stage: { valid: false, pc: 0, inst: null, cycle: -1 },
            wb_stage: { valid: false, pc: 0, inst: null, cycle: -1 }
        };
        
        this.updateRegistersDisplay();
        this.displayAssembly();
        this.drawCPUDiagram();
        this.drawPipelineDiagram();
        this.hideConsole();
        this.refreshSignalList();
        
        this.highlightCurrentInstruction(false);
        
        if (this.isReplaying) {
            this.showMessage(`回放模式已重置，共 ${this.executionLog?.totalSteps} 步`, 'info');
        } else {
            this.showMessage('程序已重置，点击"单步"或"运行"开始执行', 'info');
        }
    }
    
    startAnimationLoop() {
        setInterval(() => {
            this.drawCPUDiagram();
        }, 200);
    }
    
    // ========== 辅助方法 ==========
    
    openCodePanel() {
        const panel = document.getElementById('codePanel');
        const editorPanel = document.getElementById('codeEditorPanel');
        const sourceCode = localStorage.getItem('userCode') || this.getDefaultCode();
        
        editorPanel.innerHTML = `<textarea id="codeEditArea" style="width:100%; min-height:400px; font-family:monospace; padding:12px; background:#1e1e1e; color:#d4d4d4; border:1px solid #3e3e3e; border-radius:8px;">${this.escapeHtml(sourceCode)}</textarea>`;
        panel.style.display = 'flex';
        
        if (this.errorLine >= 0) {
            setTimeout(() => {
                const textarea = document.getElementById('codeEditArea');
                if (textarea) {
                    textarea.style.border = '2px solid #f44336';
                }
            }, 100);
        }
    }
    
    closeCodePanel() {
        document.getElementById('codePanel').style.display = 'none';
    }
    
    reRun() {
        this.reset();
        this.closeCodePanel();
        this.showMessage('程序已重新开始执行', 'success');
    }
    
    saveAndRun() {
        const textarea = document.getElementById('codeEditArea');
        if (textarea) {
            localStorage.setItem('userCode', textarea.value);
            this.asmInstructions = this.compileToAssembly(textarea.value);
            this.displayAssembly();
            this.reset();
            this.showMessage('代码已保存并重新编译，开始执行', 'success');
        }
        this.closeCodePanel();
    }
    
    showConsole() {
        const consolePanel = document.getElementById('consolePanel');
        if (consolePanel) consolePanel.style.display = 'block';
    }
    
    hideConsole() {
        const consolePanel = document.getElementById('consolePanel');
        if (consolePanel) consolePanel.style.display = 'none';
    }
    
    showMessage(msg, type) {
        const consoleContent = document.getElementById('consoleContent');
        if (!consoleContent) return;
        
        const msgDiv = document.createElement('div');
        msgDiv.style.color = type === 'error' ? '#f48771' : '#4ec9b0';
        msgDiv.style.padding = '8px';
        msgDiv.style.borderBottom = '1px solid #3e3e3e';
        msgDiv.style.fontFamily = 'monospace';
        msgDiv.style.fontSize = '12px';
        msgDiv.textContent = `[${new Date().toLocaleTimeString()}] ${msg}`;
        consoleContent.appendChild(msgDiv);
        setTimeout(() => msgDiv.remove(), 3000);
    }
    
    showError(msg) {
        this.showConsole();
        const consoleContent = document.getElementById('consoleContent');
        if (!consoleContent) return;
        
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.style.color = '#f48771';
        errorDiv.style.padding = '8px';
        errorDiv.style.borderLeft = '3px solid #f48771';
        errorDiv.style.margin = '4px 0';
        errorDiv.style.fontFamily = 'monospace';
        errorDiv.style.fontSize = '12px';
        errorDiv.textContent = msg;
        consoleContent.appendChild(errorDiv);
    }
    
    formatHex(value) {
        return `0x${(value || 0).toString(16).padStart(8, '0')}`;
    }
    
    formatHexShort(value) {
        if (value === undefined || value === null) return '0x0';
        if (value > 0xFFFF) return `0x${(value >> 16).toString(16)}...`;
        return `0x${value.toString(16)}`;
    }
    
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
    
    initSignalHistoryForNewSignal(signalName) {
        if (!this.signalHistory[signalName]) {
            this.signalHistory[signalName] = [];
        }
    }
    
    fillSignalHistoryFromCurrentData(signalName) {
        if (this.currentCycle > 0) {
            this.signalHistory[signalName] = [];
            
            for (let cycle = 0; cycle <= this.currentCycle; cycle++) {
                let value = 0;
                
                if (signalName.startsWith('x')) {
                    const regNum = parseInt(signalName.substring(1));
                    const regHistory = this.signalHistory[signalName];
                    if (regHistory && regHistory.length > 0) {
                        for (let i = regHistory.length - 1; i >= 0; i--) {
                            if (regHistory[i].cycle <= cycle) {
                                value = regHistory[i].value;
                                break;
                            }
                        }
                    } else {
                        value = this.registers[regNum] || 0;
                    }
                } else if (signalName === 'if_stage') {
                    value = this.getPipelineStageValueAtCycle('if_stage', cycle);
                } else if (signalName === 'id_stage') {
                    value = this.getPipelineStageValueAtCycle('id_stage', cycle);
                } else if (signalName === 'ex_stage') {
                    value = this.getPipelineStageValueAtCycle('ex_stage', cycle);
                } else if (signalName === 'mem_stage') {
                    value = this.getPipelineStageValueAtCycle('mem_stage', cycle);
                } else if (signalName === 'wb_stage') {
                    value = this.getPipelineStageValueAtCycle('wb_stage', cycle);
                }
                
                const lastRecord = this.signalHistory[signalName][this.signalHistory[signalName].length - 1];
                if (!lastRecord || lastRecord.value !== value) {
                    this.signalHistory[signalName].push({ cycle: cycle, value: value });
                }
            }
        } else {
            let initialValue = 0;
            if (signalName.startsWith('x')) {
                const regNum = parseInt(signalName.substring(1));
                initialValue = this.registers[regNum] || 0;
            }
            this.signalHistory[signalName] = [{ cycle: 0, value: initialValue }];
        }
    }
    
    getRegisterValueAtCycle(regNum, cycle) {
        return this.registers[regNum] || 0;
    }
    
    getPipelineStageValueAtCycle(stageName, cycle) {
        switch(stageName) {
            case 'if_stage': return this.pipelineStages.if_stage.valid ? 1 : 0;
            case 'id_stage': return this.pipelineStages.id_stage.valid ? 1 : 0;
            case 'ex_stage': return this.pipelineStages.ex_stage.valid ? 1 : 0;
            case 'mem_stage': return this.pipelineStages.mem_stage.valid ? 1 : 0;
            case 'wb_stage': return this.pipelineStages.wb_stage.valid ? 1 : 0;
            default: return 0;
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.debugInterface = new DebugInterface();
});