import streamlit as st


def get_pet_state(energy: int, mood: int) -> str:
    avg = (energy + mood) / 2
    if avg >= 70:   return "happy"
    elif avg >= 40: return "neutral"
    else:           return "tired"


def _raw_pet_svg(energy: int, mood: int, size: int = 160) -> str:
    """Return ONLY the raw <svg>... content, no HTML wrapper."""
    state = get_pet_state(energy, mood)

    colors = {
        "happy":   {"body": "#14B8A6", "grad": "#0D9488"},
        "neutral": {"body": "#5EEAD4", "grad": "#2DD4BF"},
        "tired":   {"body": "#9CA3AF", "grad": "#6B7280"},
    }[state]

    expressions = {
        "happy": """
            <path d="M65 82 Q75 72 85 82" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
            <path d="M115 82 Q125 72 135 82" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
            <path d="M88 105 Q100 118 112 105" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
            <circle cx="58" cy="98" r="7" fill="#F472B6" opacity="0.35"/>
            <circle cx="142" cy="98" r="7" fill="#F472B6" opacity="0.35"/>
        """,
        "neutral": """
            <circle cx="75" cy="82" r="4.5" fill="white"/>
            <circle cx="125" cy="82" r="4.5" fill="white"/>
            <line x1="92" y1="108" x2="108" y2="108" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        """,
        "tired": """
            <line x1="65" y1="82" x2="85" y2="82" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
            <line x1="115" y1="82" x2="135" y2="82" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
            <path d="M92 112 Q100 106 108 112" stroke="white" stroke-width="2.5" fill="none" stroke-linecap="round"/>
        """,
    }[state]

    sparkles = """
    <g opacity="0.5">
        <circle cx="35" cy="55" r="2.5" fill="#FBBF24"><animate attributeName="opacity" values="0.2;1;0.2" dur="2s" repeatCount="indefinite"/></circle>
        <circle cx="165" cy="45" r="2" fill="#FBBF24"><animate attributeName="opacity" values="1;0.2;1" dur="1.8s" repeatCount="indefinite"/></circle>
        <circle cx="155" cy="95" r="2" fill="#FBBF24"><animate attributeName="opacity" values="0.4;1;0.4" dur="2.5s" repeatCount="indefinite"/></circle>
    </g>""" if state == "happy" else ""

    return f"""<svg width="{size}" height="{size}" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
    <defs>
        <radialGradient id="pg" cx="50%" cy="38%" r="60%">
            <stop offset="0%" stop-color="{colors['body']}"/>
            <stop offset="100%" stop-color="{colors['grad']}"/>
        </radialGradient>
        <filter id="pglow">
            <feGaussianBlur stdDeviation="2.5" result="b"/>
            <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
        </filter>
    </defs>
    <ellipse cx="100" cy="178" rx="45" ry="8" fill="#000" opacity="0.06">
        <animate attributeName="rx" values="45;42;45" dur="4s" repeatCount="indefinite"/>
    </ellipse>
    {sparkles}
    <circle cx="100" cy="100" r="68" fill="url(#pg)" filter="url(#pglow)">
        <animate attributeName="r" values="68;70;68" dur="4s" repeatCount="indefinite"/>
    </circle>
    <ellipse cx="72" cy="62" rx="18" ry="10" fill="white" opacity="0.15" transform="rotate(-18 72 62)"/>
    {expressions}
</svg>
"""


def render_pet(energy: int, mood: int, size: int = 160):
    """Render pet using st.image() with raw SVG string."""
    raw_svg = _raw_pet_svg(energy, mood, size)
    # st.image() accepts raw SVG strings in Streamlit 1.58+
    c1, c2, c3 = st.columns([1, 2, 1])
    with c2:
        st.image(raw_svg, use_container_width=False)
    # Shadow below
    s1, s2, s3 = st.columns([2, 2, 2])
    with s2:
        st.html('<div style="width:80px;height:12px;background:radial-gradient(ellipse,rgba(0,0,0,0.08) 0%,transparent 70%);border-radius:50%;margin:0 auto;"></div>')


def render_pet_status(energy: int, mood: int, level: int, xp: int):
    """Render pet status bars."""
    state = get_pet_state(energy, mood)
    msg = {"happy": "Cozymo is feeling great!", "neutral": "Cozymo could use some care.", "tired": "Cozymo needs your help!"}[state]

    st.html(f'''
    <div style="text-align:center;margin-bottom:20px;">
        <div style="display:inline-flex;align-items:center;gap:4px;padding:4px 10px;border-radius:999px;font-size:12px;font-weight:600;background:linear-gradient(135deg,#FEF3C7,#FDE68A);color:#92400E;margin-bottom:6px;">
            Lv.{level}
        </div>
        <div style="font-size:14px;color:#9CA3AF;line-height:1.55;margin:0;">{msg}</div>
    </div>
    ''')

    bars = [
        ("Energy", energy, "#F59E0B", "linear-gradient(90deg,#F59E0B,#FBBF24)"),
        ("Mood", mood, "#0D9488", "linear-gradient(90deg,#0D9488,#14B8A6)"),
        ("XP", xp, "#3B82F6", "linear-gradient(90deg,#3B82F6,#60A5FA)"),
    ]

    for label, value, color, gradient in bars:
        st.html(f'''
        <div style="background:#FFFFFF;border:1px solid #F3F4F6;border-radius:16px;padding:14px 16px;margin-bottom:10px;">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:6px;">
                <span style="font-size:12px;color:#374151;font-weight:500;">{label}</span>
                <span style="font-size:12px;font-weight:600;color:{color};">{value}%</span>
            </div>
            <div style="width:100%;height:6px;background:#F3F4F6;border-radius:999px;overflow:hidden;">
                <div style="height:100%;border-radius:999px;transition:width 0.6s ease;width:{value}%;background:{gradient};"></div>
            </div>
        </div>
        ''')


def celebrate() -> str:
    colors = ["#0D9488", "#14B8A6", "#F59E0B", "#3B82F6", "#F472B6", "#10B981"]
    import random
    pieces = ""
    for i in range(25):
        left = random.randint(0, 100)
        delay = random.uniform(0, 1.2)
        dur = random.uniform(2.5, 4)
        color = random.choice(colors)
        pieces += f'<div style="position:fixed;width:8px;height:8px;top:-10px;border-radius:2px;animation:confetti-fall 3s ease-out forwards;z-index:9999;pointer-events:none;left:{left}%;background:{color};animation-delay:{delay}s;animation-duration:{dur}s;"></div>'

    return f"""
    <style>
    @keyframes confetti-fall {{
        0% {{ transform: translateY(-20px) rotate(0deg); opacity: 1; }}
        100% {{ transform: translateY(100vh) rotate(720deg); opacity: 0; }}
    }}
    </style>
    <div style="position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:9999;">
        {pieces}
    </div>
    """
