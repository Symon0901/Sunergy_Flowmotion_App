"""
Lucide-style SVG icons. Never use emoji.
Stroke width: 2px, stroke-linecap: round, stroke-linejoin: round.
"""


def _svg(path: str, size: int = 24, color: str = "currentColor", fill: str = "none") -> str:
    return f'<svg width="{size}" height="{size}" viewBox="0 0 24 24" fill="{fill}" stroke="{color}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">{path}</svg>'


# Navigation
ICON_HOME = _svg('<path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>')
ICON_ACTIVITY = _svg('<path d="M22 12h-4l-3 9L9 3l-3 9H2"/>')
ICON_WIND = _svg('<path d="M12.8 19.6A2 2 0 1 0 14 16H2"/><path d="M17.5 8a2.5 2.5 0 1 1 2 4H2"/><path d="M9.8 4.4A2 2 0 1 1 11 8H2"/>')
ICON_CALENDAR = _svg('<rect width="18" height="18" x="3" y="4" rx="2"/><line x1="16" x2="16" y1="2" y2="6"/><line x1="8" x2="8" y1="2" y2="6"/><line x1="3" x2="21" y1="10" y2="10"/>')
ICON_USER = _svg('<path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>')

# Actions
ICON_CHECK = _svg('<polyline points="20 6 9 17 4 12"/>')
ICON_CHECK_CIRCLE = _svg('<path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>')
ICON_CIRCLE = _svg('<circle cx="12" cy="12" r="10"/>')
ICON_PLUS = _svg('<path d="M5 12h14"/><path d="M12 5v14"/>')
ICON_SETTINGS = _svg('<path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z"/><circle cx="12" cy="12" r="3"/>')
ICON_X = _svg('<path d="M18 6 6 18"/><path d="m6 6 12 12"/>')
ICON_ARROW_RIGHT = _svg('<path d="M5 12h14"/><path d="m12 5 7 7-7 7"/>')
ICON_ARROW_LEFT = _svg('<path d="m12 19-7-7 7-7"/><path d="M19 12H5"/>')

# Stats
ICON_FLAME = _svg('<path d="M12 2c0 2.5-1.5 4-1.5 6.5a3 3 0 0 0 1.5 2.5 3 3 0 0 0 3-3c0-2-1.5-3.5-1.5-5.5 0 2.5 1.5 4 1.5 6.5a5 5 0 0 1-1.5 3.5 5 5 0 0 0-1.5-3.5c0-2.5 1.5-4 1.5-6.5 0 2.5-1.5 4-1.5 6.5a5 5 0 0 0 1.5 3.5A5 5 0 0 1 12 22a5 5 0 0 1-1.5-3.5c0-2.5 1.5-4 1.5-6.5 0 2-1.5 3.5-1.5 5.5a3 3 0 0 0 3 3 3 3 0 0 0 1.5-2.5C13.5 6 12 4.5 12 2z"/>')
ICON_ZAP = _svg('<polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>')
ICON_HEART = _svg('<path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>')
ICON_STAR = _svg('<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>')
ICON_TRENDING_UP = _svg('<polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/>')
ICON_CLOCK = _svg('<circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>')

# Activity types
ICON_TIMER = _svg('<line x1="10" x2="14" y1="2" y2="2"/><line x1="12" x2="15" y1="14" y2="11"/><circle cx="12" cy="14" r="8"/>')
ICON_MUSIC = _svg('<path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/>')
ICON_SUN = _svg('<circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/><path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/><path d="M2 12h2"/><path d="M20 12h2"/><path d="m6.34 17.66-1.41 1.41"/><path d="m19.07 4.93-1.41 1.41"/>')
ICON_MOON = _svg('<path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/>')

# Misc
ICON_LIGHTBULB = _svg('<path d="M15 14c.2-1 .7-1.7 1.5-2.5 1-.9 1.5-2.2 1.5-3.5A6 6 0 0 0 6 8c0 1 .2 2.2 1.5 3.5.7.7 1.3 1.5 1.5 2.5"/><path d="M9 18h6"/><path d="M10 22h4"/>')
ICON_INFO = _svg('<circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/>')
ICON_PLAY = _svg('<polygon points="5 3 19 12 5 21 5 3"/>')
ICON_PAUSE = _svg('<rect width="4" height="16" x="6" y="4"/><rect width="4" height="16" x="14" y="4"/>')
ICON_CHEVRON_RIGHT = _svg('<path d="m9 18 6-6-6-6"/>')
ICON_CHEVRON_DOWN = _svg('<path d="m6 9 6 6 6-6"/>')
ICON_SEARCH = _svg('<circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/>')
ICON_EDIT = _svg('<path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>')
ICON_TRASH = _svg('<path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>')
ICON_REPEAT = _svg('<path d="m17 2 4 4-4 4"/><path d="M3 11v-1a4 4 0 0 1 4-4h14"/><path d="m7 22-4-4 4-4"/><path d="M21 13v1a4 4 0 0 1-4 4H3"/>')


# Exercise type icons (abstract shapes)
def exercise_icon(etype: str, size: int = 20, color: str = "white") -> str:
    """Return an SVG icon for each exercise type."""
    paths = {
        "badminton": '<path d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2z"/><circle cx="12" cy="12" r="3"/>',
        "basketball": '<circle cx="12" cy="12" r="10"/><path d="M2 12h20"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/>',
        "running": '<path d="M13 4 8 9l3 3-2 7 5-3 2-7-3-5z"/>',
        "swimming": '<path d="M2 12h20"/><path d="M2 16c4-2 6-2 10 0s6 2 10 0"/><path d="M2 8c4-2 6-2 10 0s6 2 10 0"/>',
        "yoga": '<path d="M12 2v20"/><path d="M8 6l4-4 4 4"/><path d="M8 18l4 4 4-4"/>',
        "other": '<circle cx="12" cy="12" r="10"/><path d="M12 8v8"/><path d="M8 12h8"/>',
    }
    path = paths.get(etype, paths["other"])
    return _svg(path, size=size, color=color)


def icon(name: str, size: int = 20, color: str = "currentColor") -> str:
    """Get an icon by name."""
    icons = {
        "home": ICON_HOME,
        "activity": ICON_ACTIVITY,
        "wind": ICON_WIND,
        "calendar": ICON_CALENDAR,
        "user": ICON_USER,
        "check": ICON_CHECK,
        "check_circle": ICON_CHECK_CIRCLE,
        "circle": ICON_CIRCLE,
        "plus": ICON_PLUS,
        "settings": ICON_SETTINGS,
        "x": ICON_X,
        "arrow_right": ICON_ARROW_RIGHT,
        "arrow_left": ICON_ARROW_LEFT,
        "flame": ICON_FLAME,
        "zap": ICON_ZAP,
        "heart": ICON_HEART,
        "star": ICON_STAR,
        "trending_up": ICON_TRENDING_UP,
        "clock": ICON_CLOCK,
        "timer": ICON_TIMER,
        "music": ICON_MUSIC,
        "sun": ICON_SUN,
        "moon": ICON_MOON,
        "lightbulb": ICON_LIGHTBULB,
        "info": ICON_INFO,
        "play": ICON_PLAY,
        "pause": ICON_PAUSE,
        "chevron_right": ICON_CHEVRON_RIGHT,
        "chevron_down": ICON_CHEVRON_DOWN,
        "search": ICON_SEARCH,
        "edit": ICON_EDIT,
        "trash": ICON_TRASH,
        "repeat": ICON_REPEAT,
    }
    svg = icons.get(name, ICON_CIRCLE)
    # Replace size and color
    return svg.replace('width="24"', f'width="{size}"').replace('height="24"', f'height="{size}"').replace('stroke="currentColor"', f'stroke="{color}"')
