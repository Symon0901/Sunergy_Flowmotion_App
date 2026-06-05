import streamlit as st


# SVG icons as strings (Lucide-style, no emoji)
ICONS = {
    "home": """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>""",
    "activity": """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>""",
    "breathe": """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 2a10 10 0 0 1 10 10"/><path d="M12 12 4.1 4.1"/></svg>""",
    "schedule": """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="18" height="18" x="3" y="4" rx="2" ry="2"/><line x1="16" x2="16" y1="2" y2="6"/><line x1="8" x2="8" y1="2" y2="6"/><line x1="3" x2="21" y1="10" y2="10"/></svg>""",
    "profile": """<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>""",
}


def render_bottom_nav():
    """Render the bottom navigation bar."""
    current_page = st.session_state.get("page", "home")

    nav_items = [
        ("home", "Home"),
        ("activities", "Move"),
        ("breathe", "Breathe"),
        ("schedule", "Plan"),
        ("profile", "Me"),
    ]

    # Build nav HTML
    nav_html = '<div class="bottom-nav">'
    for page_id, label in nav_items:
        is_active = current_page == page_id
        active_class = "active" if is_active else ""
        # We use a form-based approach with st.button for each nav item
        # But since we need them side by side in a fixed bar, we'll use columns + buttons
    nav_html += '</div>'

    # Instead, use Streamlit columns for the nav bar
    cols = st.columns(5, gap="small")

    for idx, (page_id, label) in enumerate(nav_items):
        with cols[idx]:
            is_active = current_page == page_id
            btn_type = "primary" if is_active else "secondary"

            # Use a key format that won't conflict
            if st.button(
                label,
                key=f"nav_{page_id}",
                type=btn_type,
                use_container_width=True,
            ):
                st.session_state.page = page_id
                st.rerun()
