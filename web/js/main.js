// main.js - 主控制逻辑
class OpenCPUUI {
    constructor() {
        this.modal = document.getElementById('modal');
        this.modalClose = document.querySelector('.modal-close');
        this.initEventListeners();
    }

    initEventListeners() {
        // 为所有菜单按钮添加点击事件
        const buttons = document.querySelectorAll('.menu-btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const page = btn.getAttribute('data-page');
                this.handleNavigation(page);
            });
        });

        // 模态框关闭事件
        if (this.modalClose) {
            this.modalClose.addEventListener('click', () => {
                this.closeModal();
            });
        }

        // 点击模态框背景关闭
        window.addEventListener('click', (e) => {
            if (e.target === this.modal) {
                this.closeModal();
            }
        });
    }

    handleNavigation(page) {
        switch(page) {
            case 'run':
                // 后端注意，此为虚拟数据，请修改：run页面已实现，直接跳转
                window.location.href = 'run_0501.html';
                break;
            case 'custom-inst':
                window.location.href = 'custom-inst.html';
                break;
            case 'peripheral':
                window.location.href = 'peripheral.html';
                break;
            case 'storage':
                window.location.href = 'map_plotter.html';
                break;
            case 'terminal':
                window.location.href = 'terminal.html';
                break;
            case 'memory-config':
                // 后端注意，此为虚拟数据，请修改：内存配置功能待后端实现
                this.showModal('修改内存配置', '内存配置功能正在开发中，敬请期待！\n\n后续将支持：\n• 地址映射\n• 内存大小调整');
                break;
            case 'exit':
                this.handleExit();
                break;
            default:
                console.log('未知页面:', page);
        }
    }

    showModal(title, message) {
        if (this.modal) {
            document.getElementById('modal-title').textContent = title;
            document.getElementById('modal-message').innerHTML = message.replace(/\n/g, '<br>');
            this.modal.style.display = 'block';
        }
    }

    closeModal() {
        if (this.modal) {
            this.modal.style.display = 'none';
        }
    }

    handleExit() {
        this.showModal('退出', '确定要退出 OPENCPU 模拟器吗？\n\n点击确定关闭页面。');
        
        // 后端注意，此为虚拟数据，请修改：退出确认按钮逻辑
        const confirmBtn = document.createElement('button');
        const modalContent = this.modal.querySelector('.modal-content');
        const existingBtns = modalContent.querySelectorAll('.modal-buttons');
        
        if (!modalContent.querySelector('.modal-buttons')) {
            const btnContainer = document.createElement('div');
            btnContainer.className = 'modal-buttons';
            btnContainer.style.cssText = 'padding: 0 24px 24px 24px; display: flex; gap: 12px; justify-content: flex-end;';
            
            const confirm = document.createElement('button');
            confirm.textContent = '确定退出';
            confirm.style.cssText = 'padding: 8px 20px; background: #dc3545; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 14px;';
            confirm.onclick = () => {
                window.close();
                // 如果 window.close() 无效，显示提示
                this.showModal('提示', '无法自动关闭页面，请手动关闭浏览器标签页。');
            };
            
            const cancel = document.createElement('button');
            cancel.textContent = '取消';
            cancel.style.cssText = 'padding: 8px 20px; background: #f0f0f0; color: #333; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; margin-right: 8px;';
            cancel.onclick = () => this.closeModal();
            
            btnContainer.appendChild(cancel);
            btnContainer.appendChild(confirm);
            modalContent.appendChild(btnContainer);
        }
    }
}

// 等待 DOM 加载完成
document.addEventListener('DOMContentLoaded', () => {
    window.app = new OpenCPUUI();
    
    // 添加键盘支持（ESC 关闭模态框）
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && window.app.modal.style.display === 'block') {
            window.app.closeModal();
        }
    });
    
    // 控制台输出欢迎信息
    console.log('OPENCPU 教育版已启动');
    console.log('RISC-V 流水线模拟器 - 可视化界面');
});

// 导出供外部使用（如果需要在控制台调试）
if (typeof module !== 'undefined' && module.exports) {
    module.exports = OpenCPUUI;
}