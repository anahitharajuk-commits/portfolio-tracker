document.addEventListener('DOMContentLoaded', () => {
    
    // ==========================================================================
    // 6.1 & 6.4 DYNAMIC PERSISTENT DARK MODE
    // ==========================================================================
    const themeToggle = document.querySelector('#theme-toggle');
    const body = document.body;

    // Read local browser memory on startup
    const savedTheme = localStorage.getItem('portfolio-theme');

    // Apply saved theme state immediately if it exists
    if (savedTheme === 'dark') {
        body.classList.add('dark');
        if (themeToggle) themeToggle.textContent = '☀️';
    } else {
        body.classList.remove('dark');
        if (themeToggle) themeToggle.textContent = '🌙';
    }
    
    if (themeToggle) {
        themeToggle.addEventListener('click', () => {
            body.classList.toggle('dark');
            const isDark = body.classList.contains('dark');
            
            // Write selection permanently to device storage
            localStorage.setItem('portfolio-theme', isDark ? 'dark' : 'light');
            themeToggle.textContent = isDark ? '☀️' : '🌙';
        });
    }

    // ==========================================================================
    // 6.2 BACK-TO-TOP BUTTON LOGIC
    // ==========================================================================
    const toTop = document.querySelector('#to-top');
    
    if (toTop) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 300) {
                toTop.classList.add('show');
            } else {
                toTop.classList.remove('show');
            }
        });

        toTop.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // ==========================================================================
    // 6.3 SCROLL REVEAL (INTERSECTION OBSERVER)
    // ==========================================================================
    const revealItems = document.querySelectorAll('.reveal');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.15
    });

    revealItems.forEach((item) => observer.observe(item));
});
