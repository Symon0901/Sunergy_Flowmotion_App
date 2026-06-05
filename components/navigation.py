import streamlit as st
from components.icons import icon

NAV = [
    ("home", "Home", "home"),
    ("activities", "Move", "activity"),
    ("breathe", "Breathe", "wind"),
    ("schedule", "Plan", "calendar"),
    ("profile", "Me", "user"),
]


def render_bottom_nav():
    current = st.session_state.get("page", "home")

    # Build visual nav bar with HTML (for styling)
    nav_html = '<div class="bottom-nav-container">'
    nav_html += '<div style="display:flex;justify-content:space-around;align-items:center;height:64px;background:rgba(255,255,255,0.95);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-top:1px solid #F3F4F6;padding-bottom:env(safe-area-inset-bottom,0);">'

    for page_id, label, icon_name in NAV:
        is_active = current == page_id
        color = "#0D9488" if is_active else "#9CA3AF"
        weight = "600" if is_active else "500"
        svg = icon(icon_name, 22, color)
        nav_html += f'''
        <div onclick="document.getElementById('navbtn_{page_id}').click()" style="display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;padding:6px 0;flex:1;cursor:pointer;color:{color};font-size:11px;font-weight:{weight};letter-spacing:0.01em;transition:color 0.15s ease;">
            {svg}
            <span>{label}</span>
        </div>
        '''
    nav_html += '</div></div>'
    st.html(nav_html)

    # Hidden real buttons for actual navigation
    cols = st.columns(5)
    for idx, (page_id, _, _) in enumerate(NAV):
        with cols[idx]:
            if st.button(" ", key=f"navbtn_{page_id}", type="secondary", use_container_width=True):
                st.session_state.page = page_id
                st.rerun()
