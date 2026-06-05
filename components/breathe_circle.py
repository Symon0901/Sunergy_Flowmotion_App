import streamlit as st
import time


def render_breathe_guide():
    """Render the Calm-style breathing guide with animation."""

    html = """
    <div style="text-align: center; padding: 40px 0;">
        <div style="position: relative; width: 200px; height: 200px; margin: 0 auto;">
            <!-- Outer glow ring -->
            <div style="
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 180px;
                height: 180px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(13,148,136,0.15) 0%, transparent 70%);
                animation: breathe-outer 16s ease-in-out infinite;
            "></div>

            <!-- Main breathe circle -->
            <div class="breathe-circle" style="
                width: 120px;
                height: 120px;
                position: absolute;
                top: 50%;
                left: 50%;
                margin-top: -60px;
                margin-left: -60px;
            ">
                <span id="breathe-text" style="font-size: 14px; letter-spacing: 0.05em;">Breathe</span>
            </div>

            <!-- Small orbiting dots -->
            <div style="
                position: absolute;
                top: 50%;
                left: 50%;
                width: 160px;
                height: 160px;
                margin-top: -80px;
                margin-left: -80px;
                animation: orbit 16s linear infinite;
            ">
                <div style="
                    position: absolute;
                    top: 0;
                    left: 50%;
                    transform: translateX(-50%);
                    width: 8px;
                    height: 8px;
                    border-radius: 50%;
                    background: #14B8A6;
                    opacity: 0.6;
                "></div>
            </div>
        </div>

        <p id="breathe-instruction" style="margin-top: 32px; font-size: 18px; font-weight: 500; color: #134E4A;">
            Get ready...
        </p>
        <p style="font-size: 14px; color: #64748B; margin-top: 8px;">
            4 seconds in · 4 hold · 4 out · 4 hold
        </p>
    </div>

    <script>
        const instructions = [
            { text: "Breathe In", duration: 4000 },
            { text: "Hold", duration: 4000 },
            { text: "Breathe Out", duration: 4000 },
            { text: "Hold", duration: 4000 }
        ];

        let currentStep = 0;
        const instructionEl = document.getElementById('breathe-instruction');

        function updateInstruction() {
            if (instructionEl) {
                instructionEl.textContent = instructions[currentStep].text;
            }
            setTimeout(() => {
                currentStep = (currentStep + 1) % instructions.length;
                updateInstruction();
            }, instructions[currentStep].duration);
        }

        // Start after a brief delay
        setTimeout(updateInstruction, 1000);
    </script>
    """

    return html


def render_breathe_page():
    """Render the complete breathing exercise page."""
    st.markdown('<div class="page-title">Breathe</div>', unsafe_allow_html=True)
    st.markdown('<div class="page-subtitle">Take a moment with Cozymo</div>', unsafe_allow_html=True)

    # Duration selector
    duration = st.segmented_control(
        "Duration",
        options=["1 min", "3 min", "5 min"],
        default="3 min",
        key="breathe_duration"
    )

    # Render the breathe animation
    st.components.v1.html(render_breathe_guide(), height=350)

    # Start button
    col1, col2 = st.columns(2)
    with col1:
        if st.button("Start Session", type="primary", use_container_width=True, key="start_breathe"):
            st.session_state.breathing_active = True
            st.session_state.breathe_start_time = time.time()
            st.session_state.breathe_duration_min = int(duration.split()[0]) if duration else 3
            st.rerun()

    with col2:
        if st.button("Stop", type="secondary", use_container_width=True, key="stop_breathe"):
            if st.session_state.get("breathing_active", False):
                # Calculate elapsed time
                elapsed = time.time() - st.session_state.breathe_start_time
                minutes_done = elapsed / 60

                # Award benefits
                pet = st.session_state.pet
                mood_gain = min(int(minutes_done * 10), 20)
                xp_gain = min(int(minutes_done * 5), 15)

                pet["mood"] = min(100, pet["mood"] + mood_gain)
                pet["xp"] = min(100, pet["xp"] + xp_gain)

                # Check level up
                if pet["xp"] >= 100:
                    pet["level"] += 1
                    pet["xp"] = 0
                    st.session_state.show_level_up = True

                st.session_state.breathing_active = False
                st.session_state.last_activity = f"Completed {int(minutes_done)} min breathing"
                st.success(f"Great job! Cozymo's mood +{mood_gain}%, XP +{xp_gain}")
                st.rerun()

    # Show active breathing timer
    if st.session_state.get("breathing_active", False):
        elapsed = time.time() - st.session_state.breathe_start_time
        target_seconds = st.session_state.breathe_duration_min * 60
        remaining = max(0, target_seconds - elapsed)

        mins = int(remaining // 60)
        secs = int(remaining % 60)

        st.markdown(f"""
        <div style="text-align: center; margin-top: 20px;">
            <div class="timer-display">{mins:02d}:{secs:02d}</div>
            <p style="color: #64748B; font-size: 14px;">Keep breathing with Cozymo...</p>
        </div>
        """, unsafe_allow_html=True)

        # Auto-refresh for timer
        if remaining > 0:
            time.sleep(1)
            st.rerun()
        else:
            # Auto-complete
            pet = st.session_state.pet
            pet["mood"] = min(100, pet["mood"] + 20)
            pet["xp"] = min(100, pet["xp"] + 15)
            if pet["xp"] >= 100:
                pet["level"] += 1
                pet["xp"] = 0
                st.session_state.show_level_up = True
            st.session_state.breathing_active = False
            st.session_state.last_activity = f"Completed {st.session_state.breathe_duration_min} min breathing"
            st.success("Session complete! Cozymo feels much better!")
            st.rerun()
