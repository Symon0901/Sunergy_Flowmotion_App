import streamlit as st


def get_pet_mood_state(energy: int, mood: int) -> str:
    """Determine pet visual state based on energy and mood."""
    avg = (energy + mood) / 2
    if avg >= 70:
        return "happy"
    elif avg >= 40:
        return "neutral"
    else:
        return "tired"


def render_pet(energy: int, mood: int, size: int = 180):
    """Render the pet SVG with appropriate expression."""
    state = get_pet_mood_state(energy, mood)

    # Color based on state
    if state == "happy":
        body_color = "#14B8A6"
        body_gradient = "#0D9488"
        cheek_color = "#F472B6"
        eye_expression = """
            <!-- Happy eyes (curved) -->
            <path d="M 65 85 Q 75 75 85 85" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
            <path d="M 115 85 Q 125 75 135 85" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
        """
        mouth = """
            <!-- Happy smile -->
            <path d="M 85 105 Q 100 120 115 105" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
        """
        cheeks = f"""
            <!-- Blush -->
            <circle cx="60" cy="100" r="8" fill="{cheek_color}" opacity="0.4"/>
            <circle cx="140" cy="100" r="8" fill="{cheek_color}" opacity="0.4"/>
        """
        bounce = "0px"
    elif state == "neutral":
        body_color = "#2DD4BF"
        body_gradient = "#14B8A6"
        eye_expression = """
            <!-- Neutral eyes (dots) -->
            <circle cx="75" cy="85" r="5" fill="white"/>
            <circle cx="125" cy="85" r="5" fill="white"/>
        """
        mouth = """
            <!-- Neutral mouth -->
            <line x1="90" y1="110" x2="110" y2="110" stroke="white" stroke-width="3" stroke-linecap="round"/>
        """
        cheeks = ""
        bounce = "0px"
    else:  # tired
        body_color = "#6B7280"
        body_gradient = "#4B5563"
        eye_expression = """
            <!-- Tired eyes (lines) -->
            <line x1="65" y1="85" x2="85" y2="85" stroke="white" stroke-width="3" stroke-linecap="round"/>
            <line x1="115" y1="85" x2="135" y2="85" stroke="white" stroke-width="3" stroke-linecap="round"/>
        """
        mouth = """
            <!-- Tired frown -->
            <path d="M 90 115 Q 100 108 110 115" stroke="white" stroke-width="3" fill="none" stroke-linecap="round"/>
        """
        cheeks = ""
        bounce = "0px"

    # Add sparkles when happy
    sparkles = ""
    if state == "happy":
        sparkles = """
            <g opacity="0.6">
                <circle cx="40" cy="50" r="3" fill="#FBBF24">
                    <animate attributeName="opacity" values="0.3;1;0.3" dur="2s" repeatCount="indefinite"/>
                </circle>
                <circle cx="160" cy="45" r="2" fill="#FBBF24">
                    <animate attributeName="opacity" values="1;0.3;1" dur="1.5s" repeatCount="indefinite"/>
                </circle>
                <circle cx="170" cy="90" r="2.5" fill="#FBBF24">
                    <animate attributeName="opacity" values="0.5;1;0.5" dur="2.5s" repeatCount="indefinite"/>
                </circle>
            </g>
        """

    svg_html = f"""
    <div class="pet-container">
        <svg width="{size}" height="{size}" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
            <defs>
                <radialGradient id="bodyGrad" cx="50%" cy="40%" r="60%">
                    <stop offset="0%" stop-color="{body_color}"/>
                    <stop offset="100%" stop-color="{body_gradient}"/>
                </radialGradient>
                <filter id="glow">
                    <feGaussianBlur stdDeviation="3" result="coloredBlur"/>
                    <feMerge>
                        <feMergeNode in="coloredBlur"/>
                        <feMergeNode in="SourceGraphic"/>
                    </feMerge>
                </filter>
            </defs>

            <!-- Shadow -->
            <ellipse cx="100" cy="175" rx="50" ry="10" fill="#000000" opacity="0.1">
                <animate attributeName="rx" values="50;45;50" dur="3s" repeatCount="indefinite"/>
                <animate attributeName="opacity" values="0.1;0.08;0.1" dur="3s" repeatCount="indefinite"/>
            </ellipse>

            {sparkles}

            <!-- Body -->
            <circle cx="100" cy="100" r="70" fill="url(#bodyGrad)" filter="url(#glow)">
                <animate attributeName="r" values="70;72;70" dur="3s" repeatCount="indefinite"/>
            </circle>

            <!-- Shine -->
            <ellipse cx="75" cy="65" rx="20" ry="12" fill="white" opacity="0.2" transform="rotate(-20 75 65)"/>

            {eye_expression}
            {mouth}
            {cheeks}

            <!-- Accessories for higher levels -->
            <g id="accessories" opacity="0">
                <!-- Crown for high level -->
                <path d="M 75 35 L 85 15 L 100 30 L 115 15 L 125 35 Z" fill="#FBBF24" stroke="#F59E0B" stroke-width="2"/>
            </g>
        </svg>
    </div>
    """

    return svg_html


def render_pet_status(energy: int, mood: int, level: int, xp: int):
    """Render pet status bars and info."""
    state = get_pet_mood_state(energy, mood)

    status_text = {
        "happy": "Cozymo is feeling great!",
        "neutral": "Cozymo could use some care.",
        "tired": "Cozymo needs your help!"
    }

    html = f"""
    <div style="text-align: center; margin-bottom: 20px;">
        <div class="level-badge" style="margin-bottom: 8px;">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
            Level {level}
        </div>
        <p style="font-size: 15px; color: #64748B; margin: 0;">{status_text[state]}</p>
    </div>

    <div class="wellness-card" style="margin-bottom: 16px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
            <span style="font-size: 13px; font-weight: 500; color: #374151;">
                <svg width="16" height="16" style="vertical-align: middle; margin-right: 6px;" viewBox="0 0 24 24" fill="none" stroke="#F59E0B" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                Energy
            </span>
            <span style="font-size: 13px; font-weight: 600; color: #F59E0B;">{energy}%</span>
        </div>
        <div class="progress-container">
            <div class="progress-fill progress-energy" style="width: {energy}%;"></div>
        </div>
    </div>

    <div class="wellness-card" style="margin-bottom: 16px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
            <span style="font-size: 13px; font-weight: 500; color: #374151;">
                <svg width="16" height="16" style="vertical-align: middle; margin-right: 6px;" viewBox="0 0 24 24" fill="none" stroke="#0D9488" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
                Mood
            </span>
            <span style="font-size: 13px; font-weight: 600; color: #0D9488;">{mood}%</span>
        </div>
        <div class="progress-container">
            <div class="progress-fill progress-mood" style="width: {mood}%;"></div>
        </div>
    </div>

    <div class="wellness-card">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
            <span style="font-size: 13px; font-weight: 500; color: #374151;">
                <svg width="16" height="16" style="vertical-align: middle; margin-right: 6px;" viewBox="0 0 24 24" fill="none" stroke="#3B82F6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2v20M2 12h20"/></svg>
                XP to Next Level
            </span>
            <span style="font-size: 13px; font-weight: 600; color: #3B82F6;">{xp}/100</span>
        </div>
        <div class="progress-container">
            <div class="progress-fill progress-xp" style="width: {xp}%;"></div>
        </div>
    </div>
    """

    return html


def celebrate_animation():
    """Render a confetti celebration effect."""
    colors = ["#0D9488", "#14B8A6", "#F59E0B", "#3B82F6", "#F472B6", "#22C55E"]
    confetti_html = ""

    import random
    for i in range(30):
        left = random.randint(0, 100)
        delay = random.uniform(0, 1)
        duration = random.uniform(2, 4)
        color = random.choice(colors)

        confetti_html += f"""
        <div class="confetti" style="left: {left}%; background: {color}; animation-delay: {delay}s; animation-duration: {duration}s;"></div>
        """

    return f"""
    <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; z-index: 9999;">
        {confetti_html}
    </div>
    """
