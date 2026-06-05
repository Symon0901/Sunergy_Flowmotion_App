import streamlit as st
import streamlit.components.v1 as components
import time


BREATHE_HTML = """
<div style="text-align:center;padding:28px 0;position:relative;">
    <div class="breathe-wrap">
        <div class="breathe-ring"></div>
        <div class="breathe-ring" style="animation-delay:-4s;"></div>
        <div class="breathe-core"></div>
    </div>
    <div id="b-instruction" style="margin-top:28px;font-size:20px;font-weight:600;color:#1F2937;letter-spacing:-0.01em;">
        Get ready
    </div>
    <div style="margin-top:6px;font-size:13px;color:#9CA3AF;letter-spacing:0.02em;">
        4s in &middot; 4s hold &middot; 4s out &middot; 4s hold
    </div>
</div>
<script>
    const steps = [
        { text: "Breathe In",  dur: 4000 },
        { text: "Hold",        dur: 4000 },
        { text: "Breathe Out", dur: 4000 },
        { text: "Hold",        dur: 4000 }
    ];
    let idx = 0;
    const el = document.getElementById('b-instruction');
    function tick() {
        if (el) el.textContent = steps[idx].text;
        setTimeout(() => { idx = (idx + 1) % 4; tick(); }, steps[idx].dur);
    }
    setTimeout(tick, 800);
</script>
"""


def render_breathe_page():
    st.markdown('<div class="title-xl" style="margin-bottom:2px;">Breathe</div>', unsafe_allow_html=True)
    st.markdown('<div class="body" style="margin-bottom:20px;">Take a moment with Cozymo</div>', unsafe_allow_html=True)

    # Duration selector as HTML segments
    durations = [("1 min", 1), ("3 min", 3), ("5 min", 5)]
    selected = st.session_state.get("breathe_dur", 3)

    seg_html = '<div class="segment-wrap" style="margin-bottom:24px;">'
    for label, val in durations:
        active = "active" if selected == val else ""
        seg_html += f'<button class="segment-btn {active}" onclick="document.getElementById(\'seg_{val}\').click()">{label}</button>'
    seg_html += '</div>'
    st.markdown(seg_html, unsafe_allow_html=True)

    # Hidden buttons for segment control
    seg_cols = st.columns(3)
    for idx, (label, val) in enumerate(durations):
        with seg_cols[idx]:
            if st.button(label, key=f"seg_{val}", type="secondary", use_container_width=True):
                st.session_state.breathe_dur = val
                st.rerun()

    components.html(BREATHE_HTML, height=300)

    active = st.session_state.get("breathing_active", False)

    c1, c2 = st.columns(2)
    with c1:
        if not active:
            if st.button("Start Session", type="primary", use_container_width=True, key="b_start"):
                st.session_state.breathing_active = True
                st.session_state.breathe_start = time.time()
                st.session_state.breathe_target = selected
                st.rerun()
        else:
            if st.button("Finish Early", type="primary", use_container_width=True, key="b_finish"):
                _complete_breathe()

    with c2:
        if active:
            if st.button("Cancel", type="secondary", use_container_width=True, key="b_cancel"):
                st.session_state.breathing_active = False
                st.rerun()

    if active:
        elapsed = time.time() - st.session_state.breathe_start
        target_sec = st.session_state.breathe_target * 60
        remain = max(0, target_sec - elapsed)
        m, s = int(remain // 60), int(remain % 60)

        st.markdown(f"""
        <div style="text-align:center;margin-top:16px;">
            <div class="timer-digits">{m:02d}:{s:02d}</div>
            <div class="caption" style="margin-top:4px;">Keep breathing with Cozymo</div>
        </div>
        """, unsafe_allow_html=True)

        if remain > 0:
            time.sleep(1)
            st.rerun()
        else:
            _complete_breathe()


def _complete_breathe():
    elapsed = time.time() - st.session_state.breathe_start
    minutes = max(1, int(elapsed / 60))
    pet = st.session_state.pet

    mood_gain = min(minutes * 10, 25)
    xp_gain = min(minutes * 6, 18)

    pet["mood"] = min(100, pet["mood"] + mood_gain)
    pet["xp"] = min(100, pet["xp"] + xp_gain)

    if pet["xp"] >= 100:
        pet["level"] += 1
        pet["xp"] = 0
        st.session_state.show_level_up = True

    st.session_state.breathing_active = False
    st.session_state.last_activity = f"Completed {minutes} min breathing"
    st.success(f"Great job! Mood +{mood_gain}%, XP +{xp_gain}")
    st.rerun()
