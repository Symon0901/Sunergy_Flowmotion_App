import streamlit as st


def load_css():
    css = """
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

    /* Phone simulation - only on desktop */
    @media (min-width: 480px) {
        body {
            background: #D1D5DB !important;
        }
        [data-testid="stAppViewContainer"] {
            max-width: 390px !important;
            margin: 0 auto !important;
            border-radius: 40px !important;
            border: 10px solid #1F2937 !important;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25) !important;
            position: relative !important;
        }
        /* Notch */
        [data-testid="stAppViewContainer"]::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 28px;
            background: #1F2937;
            border-bottom-left-radius: 18px;
            border-bottom-right-radius: 18px;
            z-index: 9999;
            pointer-events: none;
        }
    }

    /* Streamlit chrome hide */
    header {visibility: hidden !important; height: 0 !important;}
    .stDeployButton {display: none !important;}
    #MainMenu {visibility: hidden !important;}
    footer {visibility: hidden !important;}

    /* Content padding */
    .main .block-container {
        padding: 36px 20px 100px 20px !important;
        max-width: 100% !important;
    }

    /* ========== DESIGN TOKENS ========== */
    :root {
        --primary: #0D9488;
        --primary-light: #14B8A6;
        --primary-fade: rgba(13,148,136,0.08);
        --bg: #FAFAFA;
        --surface: #FFFFFF;
        --surface-raised: #F8FAFC;
        --text: #1F2937;
        --text-secondary: #9CA3AF;
        --text-muted: #D1D5DB;
        --border: #F3F4F6;
        --border-strong: #E5E7EB;
        --success: #10B981;
        --amber: #F59E0B;
    }

    * {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
        -webkit-font-smoothing: antialiased;
    }

    /* ========== BOTTOM NAV ========== */
    .bottom-nav-container {
        position: fixed;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        max-width: 370px;
        z-index: 999;
    }
    @media (max-width: 479px) {
        .bottom-nav-container { max-width: 100%; }
    }

    /* ========== TYPOGRAPHY ========== */
    .title-xl {
        font-size: 28px;
        font-weight: 700;
        color: var(--text);
        letter-spacing: -0.03em;
        line-height: 1.15;
    }
    .title-lg {
        font-size: 22px;
        font-weight: 700;
        color: var(--text);
        letter-spacing: -0.02em;
        line-height: 1.2;
    }
    .title-md {
        font-size: 17px;
        font-weight: 600;
        color: var(--text);
        letter-spacing: -0.01em;
        line-height: 1.3;
    }
    .title-sm {
        font-size: 15px;
        font-weight: 600;
        color: var(--text);
        line-height: 1.4;
    }
    .body-text {
        font-size: 14px;
        color: var(--text-secondary);
        line-height: 1.55;
    }
    .caption-text {
        font-size: 12px;
        color: var(--text-secondary);
        line-height: 1.4;
    }
    .overline-text {
        font-size: 11px;
        font-weight: 600;
        color: var(--text-secondary);
        text-transform: uppercase;
        letter-spacing: 0.06em;
    }

    /* ========== CARDS ========== */
    .card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 16px;
        margin-bottom: 12px;
    }

    /* ========== PET ========== */
    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
    }
    @keyframes pulse-glow {
        0%, 100% { opacity: 0.4; }
        50% { opacity: 0.7; }
    }
    .pet-wrap {
        animation: float 4s ease-in-out infinite;
        display: flex;
        justify-content: center;
        padding: 8px 0 16px 0;
    }
    .pet-shadow {
        width: 80px;
        height: 12px;
        background: radial-gradient(ellipse, rgba(0,0,0,0.08) 0%, transparent 70%);
        border-radius: 50%;
        margin: 0 auto;
        animation: pulse-glow 4s ease-in-out infinite;
    }

    /* ========== PROGRESS ========== */
    .progress-track {
        width: 100%;
        height: 6px;
        background: var(--border);
        border-radius: 999px;
        overflow: hidden;
    }
    .progress-fill {
        height: 100%;
        border-radius: 999px;
        transition: width 0.6s ease;
    }
    .fill-energy { background: linear-gradient(90deg, #F59E0B, #FBBF24); }
    .fill-mood { background: linear-gradient(90deg, #0D9488, #14B8A6); }
    .fill-xp { background: linear-gradient(90deg, #3B82F6, #60A5FA); }

    /* ========== BREATHE ========== */
    @keyframes breathe-cycle {
        0%, 100% { transform: scale(1); opacity: 0.5; }
        25% { transform: scale(1.5); opacity: 1; }
        50% { transform: scale(1.5); opacity: 1; }
        75% { transform: scale(1); opacity: 0.5; }
    }
    @keyframes breathe-ring {
        0%, 100% { transform: scale(1); opacity: 0.3; }
        25% { transform: scale(1.8); opacity: 0.08; }
        50% { transform: scale(1.8); opacity: 0.08; }
        75% { transform: scale(1); opacity: 0.3; }
    }
    .breathe-wrap {
        position: relative;
        width: 200px;
        height: 200px;
        margin: 0 auto;
    }
    .breathe-ring {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 140px;
        height: 140px;
        margin-top: -70px;
        margin-left: -70px;
        border-radius: 50%;
        border: 2px solid #14B8A6;
        animation: breathe-ring 16s ease-in-out infinite;
    }
    .breathe-core {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin-top: -50px;
        margin-left: -50px;
        border-radius: 50%;
        background: radial-gradient(circle at 35% 35%, #14B8A6, #0D9488);
        animation: breathe-cycle 16s ease-in-out infinite;
        box-shadow: 0 0 40px rgba(13,148,136,0.15);
    }

    /* ========== BADGES ========== */
    .badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 4px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 600;
    }
    .badge-gold {
        background: linear-gradient(135deg, #FEF3C7, #FDE68A);
        color: #92400E;
    }
    .badge-red {
        background: linear-gradient(135deg, #FEE2E2, #FECACA);
        color: #991B1B;
    }
    .badge-teal {
        background: var(--primary-fade);
        color: var(--primary-dark);
    }

    /* ========== SCHEDULE ========== */
    .schedule-row {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 14px;
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px;
        margin-bottom: 8px;
    }
    .schedule-row.done {
        opacity: 0.5;
        background: var(--surface-raised);
    }
    .schedule-dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        flex-shrink: 0;
    }
    .schedule-dot.breathe { background: #14B8A6; }
    .schedule-dot.exercise { background: #F59E0B; }
    .schedule-dot.music { background: #8B5CF6; }

    /* ========== STATS ========== */
    .stat-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
        margin-bottom: 16px;
    }
    .stat-box {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 16px 8px;
        text-align: center;
    }
    .stat-num {
        font-size: 22px;
        font-weight: 700;
        color: var(--primary);
        letter-spacing: -0.02em;
    }
    .stat-label {
        font-size: 11px;
        color: var(--text-secondary);
        margin-top: 4px;
        font-weight: 500;
    }

    /* ========== TIMER ========== */
    .timer-digits {
        font-size: 56px;
        font-weight: 700;
        color: var(--text);
        text-align: center;
        font-variant-numeric: tabular-nums;
        letter-spacing: -0.03em;
        line-height: 1;
    }

    /* ========== SCROLLBAR ========== */
    ::-webkit-scrollbar { width: 0px; background: transparent; }
    </style>
    """
    st.markdown(css, unsafe_allow_html=True)
