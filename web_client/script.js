// 頁面加載完成後的初始化
document.addEventListener('DOMContentLoaded', function() {
    initializeAnimations();
    initializeContactActions();
    initializeSocialActions();
    initializeScrollEffects();
});

// 初始化動畫效果
function initializeAnimations() {
    // 為所有區段添加進入視窗時的動畫
    const sections = document.querySelectorAll('section');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    });

    sections.forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';
        section.style.transition = 'all 0.6s ease-out';
        observer.observe(section);
    });
}

// 初始化聯絡方式動作
function initializeContactActions() {
    const contactItems = document.querySelectorAll('.contact-item');
    
    contactItems.forEach(item => {
        item.addEventListener('click', function(e) {
            // 添加點擊反饋
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = 'scale(1)';
            }, 150);
        });
        
        // 添加觸摸反饋（移動設備）
        item.addEventListener('touchstart', function() {
            this.style.transform = 'scale(0.95)';
        });
        
        item.addEventListener('touchend', function() {
            this.style.transform = 'scale(1)';
        });
    });
}

// 初始化社交媒體動作
function initializeSocialActions() {
    const socialItems = document.querySelectorAll('.social-item');
    
    socialItems.forEach(item => {
        item.addEventListener('click', function(e) {
            // 添加點擊反饋
            this.style.transform = 'translateY(-5px) scale(1.05)';
            setTimeout(() => {
                this.style.transform = 'translateY(-5px) scale(1)';
            }, 200);
        });
    });
}

// 初始化滾動效果
function initializeScrollEffects() {
    let ticking = false;
    
    function updateParallax() {
        const scrolled = window.pageYOffset;
        const parallax = document.querySelector('.card-header');
        
        if (parallax) {
            const speed = scrolled * 0.5;
            parallax.style.transform = `translateY(${speed}px)`;
        }
        
        ticking = false;
    }
    
    function requestTick() {
        if (!ticking) {
            requestAnimationFrame(updateParallax);
            ticking = true;
        }
    }
    
    window.addEventListener('scroll', requestTick);
}

// 添加平滑滾動到頂部功能
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

// 添加返回頂部按鈕
function addScrollToTopButton() {
    const button = document.createElement('button');
    button.innerHTML = '<i class="fas fa-arrow-up"></i>';
    button.className = 'scroll-to-top';
    button.style.cssText = `
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        font-size: 18px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        opacity: 0;
        visibility: hidden;
        z-index: 1000;
    `;
    
    document.body.appendChild(button);
    
    // 顯示/隱藏按鈕
    window.addEventListener('scroll', () => {
        if (window.pageYOffset > 300) {
            button.style.opacity = '1';
            button.style.visibility = 'visible';
        } else {
            button.style.opacity = '0';
            button.style.visibility = 'hidden';
        }
    });
    
    // 點擊事件
    button.addEventListener('click', scrollToTop);
    
    // 懸停效果
    button.addEventListener('mouseenter', () => {
        button.style.transform = 'scale(1.1)';
        button.style.boxShadow = '0 8px 25px rgba(0, 0, 0, 0.3)';
    });
    
    button.addEventListener('mouseleave', () => {
        button.style.transform = 'scale(1)';
        button.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.2)';
    });
}

// 添加載入動畫
function addLoadingAnimation() {
    const loader = document.createElement('div');
    loader.className = 'page-loader';
    loader.innerHTML = `
        <div class="loader-content">
            <div class="loader-spinner"></div>
            <p>載入中...</p>
        </div>
    `;
    
    loader.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        transition: opacity 0.5s ease;
    `;
    
    document.body.appendChild(loader);
    
    // 頁面載入完成後隱藏載入器
    window.addEventListener('load', () => {
        setTimeout(() => {
            loader.style.opacity = '0';
            setTimeout(() => {
                loader.remove();
            }, 500);
        }, 1000);
    });
}

// 添加載入器樣式
function addLoaderStyles() {
    const style = document.createElement('style');
    style.textContent = `
        .loader-content {
            text-align: center;
            color: white;
        }
        
        .loader-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top: 3px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .scroll-to-top:hover {
            transform: scale(1.1) !important;
        }
    `;
    
    document.head.appendChild(style);
}

// 初始化所有功能
function initializeAll() {
    addLoaderStyles();
    addLoadingAnimation();
    addScrollToTopButton();
    
    // 延遲初始化其他功能，確保頁面完全載入
    setTimeout(() => {
        initializeAnimations();
        initializeContactActions();
        initializeSocialActions();
        initializeScrollEffects();
    }, 1000);
}

// 啟動應用
initializeAll();

// 添加鍵盤快捷鍵支持
document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + K 滾動到頂部
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
        e.preventDefault();
        scrollToTop();
    }
    
    // ESC 鍵關閉任何可能的彈出窗口
    if (e.key === 'Escape') {
        // 這裡可以添加關閉彈出窗口的邏輯
    }
});

// 添加觸摸手勢支持（移動設備）
let touchStartY = 0;
let touchEndY = 0;

document.addEventListener('touchstart', function(e) {
    touchStartY = e.touches[0].clientY;
});

document.addEventListener('touchend', function(e) {
    touchEndY = e.changedTouches[0].clientY;
    handleSwipe();
});

function handleSwipe() {
    const swipeThreshold = 100;
    const diff = touchStartY - touchEndY;
    
    if (Math.abs(diff) > swipeThreshold) {
        if (diff > 0) {
            // 向上滑動
            console.log('向上滑動');
        } else {
            // 向下滑動
            console.log('向下滑動');
        }
    }
}

// 性能優化：防抖函數
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// 優化滾動事件
const optimizedScrollHandler = debounce(function() {
    // 滾動相關的邏輯
}, 16); // 約60fps

window.addEventListener('scroll', optimizedScrollHandler);

// 添加錯誤處理
window.addEventListener('error', function(e) {
    console.error('頁面錯誤:', e.error);
});

// 添加離線檢測
window.addEventListener('offline', function() {
    console.log('網路連接已斷開');
    // 可以在這裡顯示離線提示
});

window.addEventListener('online', function() {
    console.log('網路連接已恢復');
    // 可以在這裡隱藏離線提示
});
