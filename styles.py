import streamlit as st


def load_css():
    css = """
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

    :root {
        --primary: #0D9488;
        --primary-light: #14B8A6;
        --primary-dark: #0F766E;
        --background: #F0FDFA;
        --surface: #FFFFFF;
        --text-primary: #134E4A;
        --text-secondary: #64748B;
        --border: #E2E8F0;
        --success: #22C55E;
        --warning: #F59E0B;
        --error: #EF4444;
    }

    * {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    /* Mobile container simulation */
    .main > div:first-child {
        max-width: 430px !important;
        margin: 0 auto !important;
        padding: 0 !important;
    }

    .block-container {
        max-width: 430px !important;
        margin: 0 auto !important;
        padding: 1rem 1rem 5rem 1rem !important;
        background: linear-gradient(180deg, #F0FDFA 0%, #FFFFFF 100%);
        min-height: 100vh;
    }

    /* Hide Streamlit default elements */
    header {visibility: hidden !important;}
    .stDeployButton {display: none !important;}
    #MainMenu {visibility: hidden !important;}
    footer {visibility: hidden !important;}

    /* Bottom Navigation */
    .bottom-nav {
        position: fixed;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        max-width: 430px;
        height: 64px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(12px);
        border-top: 1px solid var(--border);
        display: flex;
        justify-content: space-around;
        align-items: center;
        z-index: 1000;
        padding-bottom: env(safe-area-inset-bottom, 0);
    }

    .nav-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 4px;
        padding: 8px 16px;
        cursor: pointer;
        border: none;
        background: transparent;
        transition: all 0.15s ease;
        color: var(--text-secondary);
        font-size: 11px;
        font-weight: 500;
        flex: 1;
    }

    .nav-item:hover {
        color: var(--primary);
    }

    .nav-item.active {
        color: var(--primary);
    }

    .nav-item.active svg {
        stroke-width: 2.5;
    }

    .nav-icon {
        width: 24px;
        height: 24px;
    }

    /* Cards */
    .wellness-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 16px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        transition: all 0.2s ease;
    }

    .wellness-card:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        transform: translateY(-1px);
    }

    /* Pet float animation */
    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
    }

    .pet-container {
        animation: float 3s ease-in-out infinite;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
    }

    /* Breathe circle animation */
    @keyframes breathe {
        0%, 100% { transform: scale(1); opacity: 0.7; }
        25% { transform: scale(1.5); opacity: 1; }
        50% { transform: scale(1.5); opacity: 1; }
        75% { transform: scale(1); opacity: 0.7; }
    }

    .breathe-circle {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        background: radial-gradient(circle, var(--primary-light) 0%, var(--primary) 100%);
        animation: breathe 16s ease-in-out infinite;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 18px;
        margin: 40px auto;
        box-shadow: 0 0 40px rgba(13, 148, 136, 0.3);
    }

    /* Progress bars */
    .progress-container {
        width: 100%;
        height: 8px;
        background: #E2E8F0;
        border-radius: 999px;
        overflow: hidden;
        margin-top: 8px;
    }

    .progress-fill {
        height: 100%;
        border-radius: 999px;
        transition: width 0.5s ease;
    }

    .progress-energy { background: linear-gradient(90deg, #F59E0B, #FBBF24); }
    .progress-mood { background: linear-gradient(90deg, #0D9488, #14B8A6); }
    .progress-xp { background: linear-gradient(90deg, #3B82F6, #60A5FA); }

    /* Activity buttons */
    .activity-btn {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px;
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px;
        margin-bottom: 12px;
        cursor: pointer;
        transition: all 0.15s ease;
        width: 100%;
        text-align: left;
    }

    .activity-btn:hover {
        border-color: var(--primary);
        background: #F0FDFA;
    }

    .activity-btn:active {
        transform: scale(0.97);
    }

    .activity-icon {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: linear-gradient(135deg, var(--primary-light), var(--primary));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        flex-shrink: 0;
    }

    /* Timer display */
    .timer-display {
        font-size: 48px;
        font-weight: 700;
        color: var(--text-primary);
        text-align: center;
        font-variant-numeric: tabular-nums;
        letter-spacing: -0.02em;
    }

    /* Schedule items */
    .schedule-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px 16px;
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 10px;
        margin-bottom: 8px;
    }

    .schedule-item.completed {
        opacity: 0.6;
        background: #F0FDFA;
    }

    .schedule-checkbox {
        width: 22px;
        height: 22px;
        border-radius: 50%;
        border: 2px solid var(--primary);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        flex-shrink: 0;
    }

    .schedule-checkbox.checked {
        background: var(--primary);
    }

    /* Stats */
    .stat-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 12px;
        margin-bottom: 16px;
    }

    .stat-card {
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 16px 12px;
        text-align: center;
    }

    .stat-value {
        font-size: 24px;
        font-weight: 700;
        color: var(--primary);
    }

    .stat-label {
        font-size: 12px;
        color: var(--text-secondary);
        margin-top: 4px;
    }

    /* Confetti celebration */
    @keyframes confetti-fall {
        0% { transform: translateY(-100vh) rotate(0deg); opacity: 1; }
        100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
    }

    .confetti {
        position: fixed;
        width: 10px;
        height: 10px;
        top: -10px;
        animation: confetti-fall 3s ease-out forwards;
        z-index: 9999;
    }

    /* Page title */
    .page-title {
        font-size: 28px;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: 4px;
        letter-spacing: -0.01em;
    }

    .page-subtitle {
        font-size: 15px;
        color: var(--text-secondary);
        margin-bottom: 24px;
    }

    /* Button styles */
    .btn-primary {
        background: linear-gradient(135deg, var(--primary-light), var(--primary)) !important;
        color: white !important;
        border: none !important;
        border-radius: 10px !important;
        padding: 12px 24px !important;
        font-weight: 600 !important;
        font-size: 15px !important;
        cursor: pointer !important;
        transition: all 0.15s ease !important;
        width: 100% !important;
    }

    .btn-primary:hover {
        box-shadow: 0 4px 14px rgba(13, 148, 136, 0.4) !important;
        transform: translateY(-1px) !important;
    }

    .btn-primary:active {
        transform: scale(0.97) !important;
    }

    .btn-secondary {
        background: var(--surface) !important;
        color: var(--primary) !important;
        border: 1px solid var(--primary) !important;
        border-radius: 10px !important;
        padding: 12px 24px !important;
        font-weight: 600 !important;
        font-size: 15px !important;
        cursor: pointer !important;
        width: 100% !important;
    }

    /* Level badge */
    .level-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 4px 12px;
        background: linear-gradient(135deg, #FEF3C7, #FDE68A);
        color: #92400E;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 600;
    }

    /* Streak badge */
    .streak-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 4px 12px;
        background: linear-gradient(135deg, #FEE2E2, #FECACA);
        color: #991B1B;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 600;
    }
    </style>
    """
    st.markdown(css, unsafe_allow_html=True)
