import streamlit as st
import time
from datetime import datetime, timedelta

from styles import load_css
from components.pet import render_pet, render_pet_status, celebrate_animation
from components.navigation import render_bottom_nav
from components.breathe_circle import render_breathe_page


# Page config
st.set_page_config(
    page_title="Cozymo - Wellness Pet",
    page_icon="🌿",
    layout="centered",
    initial_sidebar_state="collapsed",
)


def init_session_state():
    """Initialize all session state variables."""
    defaults = {
        "page": "home",
        "pet": {
            "name": "Cozymo",
            "level": 1,
            "energy": 60,
            "mood": 60,
            "xp": 30,
        },
        "streak": {
            "current": 3,
            "best": 7,
            "last_active": datetime.now().strftime("%Y-%m-%d"),
        },
        "schedule": [
            {"time": "08:00", "activity": "Morning Breathe", "completed": False, "type": "breathe"},
            {"time": "12:30", "activity": "Lunch Walk", "completed": False, "type": "exercise"},
            {"time": "18:00", "activity": "Badminton", "completed": False, "type": "exercise"},
            {"time": "21:30", "activity": "Evening Relax", "completed": False, "type": "breathe"},
        ],
        "activities_today": {
            "breathe": 0,
            "exercise": 0,
            "music": 0,
        },
        "breathing_active": False,
        "exercise_active": False,
        "selected_exercise": None,
        "last_activity": None,
        "show_level_up": False,
    }

    for key, value in defaults.items():
        if key not in st.session_state:
            st.session_state[key] = value


# --- Page Rendering Functions ---

def render_home():
    """Render the home page with pet and daily overview."""
    pet = st.session_state.pet
    streak = st.session_state.streak

    # Header
    col1, col2 = st.columns([3, 1])
    with col1:
        st.markdown('<div class="page-title">Good Day!</div>', unsafe_allow_html=True)
        st.markdown(f'<div class="page-subtitle">Your streak: {streak["current"]} days 🔥</div>', unsafe_allow_html=True)
    with col2:
        st.markdown(f"""
        <div style="text-align: right;">
            <div class="level-badge">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                Lv.{pet["level"]}
            </div>
        </div>
        """, unsafe_allow_html=True)

    # Pet visualization
    st.markdown(render_pet(pet["energy"], pet["mood"]), unsafe_allow_html=True)

    # Pet status bars
    st.markdown(render_pet_status(pet["energy"], pet["mood"], pet["level"], pet["xp"]), unsafe_allow_html=True)

    # Today's Schedule Overview
    st.markdown('<div style="font-size: 17px; font-weight: 600; color: #134E4A; margin: 24px 0 12px 0;">Today\'s Plan</div>', unsafe_allow_html=True)

    completed_count = sum(1 for item in st.session_state.schedule if item["completed"])
    total_count = len(st.session_state.schedule)

    for item in st.session_state.schedule:
        icon = "🫁" if item["type"] == "breathe" else "🏃"
        status_style = "text-decoration: line-through; opacity: 0.6;" if item["completed"] else ""
        check_icon = "✓" if item["completed"] else "○"

        st.markdown(f"""
        <div class="schedule-item" style="{status_style}">
            <div style="font-size: 18px;">{icon}</div>
            <div style="flex: 1;">
                <div style="font-weight: 500; font-size: 14px; color: #374151;">{item["activity"]}</div>
                <div style="font-size: 12px; color: #94A3B8;">{item["time"]}</div>
            </div>
            <div style="font-size: 16px; color: {'#0D9488' if item['completed'] else '#CBD5E1'};">{check_icon}</div>
        </div>
        """, unsafe_allow_html=True)

    # Quick actions
    st.markdown('<div style="margin-top: 20px;"></div>', unsafe_allow_html=True)
    col1, col2 = st.columns(2)
    with col1:
        if st.button("Quick Breathe", type="primary", use_container_width=True, key="quick_breathe"):
            st.session_state.page = "breathe"
            st.rerun()
    with col2:
        if st.button("Start Moving", type="secondary", use_container_width=True, key="quick_move"):
            st.session_state.page = "activities"
            st.rerun()


def render_activities():
    """Render the activities/exercise page."""
    st.markdown('<div class="page-title">Move</div>', unsafe_allow_html=True)
    st.markdown('<div class="page-subtitle">Choose an activity with Cozymo</div>', unsafe_allow_html=True)

    # Exercise options
    exercises = [
        ("badminton", "Badminton", "🏸", "Great cardio & fun with friends"),
        ("basketball", "Basketball", "🏀", "Team sport for energy boost"),
        ("running", "Running", "🏃", "Clear your mind, build stamina"),
        ("swimming", "Swimming", "🏊", "Full body, low impact"),
        ("yoga", "Yoga", "🧘", "Flexibility and calm"),
        ("other", "Other", "💪", "Any movement counts!"),
    ]

    if not st.session_state.get("exercise_active", False):
        # Show exercise selection
        for ex_id, name, emoji, desc in exercises:
            # Use a card-like button
            if st.button(
                f"**{emoji} {name}**\n\n{desc}",
                key=f"ex_{ex_id}",
                use_container_width=True,
            ):
                st.session_state.selected_exercise = {"id": ex_id, "name": name, "emoji": emoji}
                st.session_state.exercise_active = True
                st.session_state.exercise_start_time = time.time()
                st.rerun()

            # Add spacing between buttons
            st.markdown("<div style='height: 4px;'></div>", unsafe_allow_html=True)

    else:
        # Active exercise timer
        exercise = st.session_state.selected_exercise
        elapsed = time.time() - st.session_state.exercise_start_time
        mins = int(elapsed // 60)
        secs = int(elapsed % 60)

        st.markdown(f"""
        <div style="text-align: center; padding: 40px 0;">
            <div style="font-size: 64px; margin-bottom: 20px;">{exercise['emoji']}</div>
            <div class="timer-display">{mins:02d}:{secs:02d}</div>
            <div style="font-size: 18px; font-weight: 600; color: #134E4A; margin-top: 12px;">{exercise['name']}</div>
            <div style="font-size: 14px; color: #64748B; margin-top: 4px;">Cozymo is cheering for you!</div>
        </div>
        """, unsafe_allow_html=True)

        # Pet cheering animation (simple bounce)
        st.markdown("""
        <div style="text-align: center; margin: 20px 0;">
            <div style="display: inline-block; animation: float 1s ease-in-out infinite;">🌟</div>
        </div>
        """, unsafe_allow_html=True)

        col1, col2 = st.columns(2)
        with col1:
            if st.button("Finish", type="primary", use_container_width=True, key="finish_exercise"):
                # Award benefits
                pet = st.session_state.pet
                duration_min = max(1, int(elapsed / 60))
                energy_gain = min(duration_min * 8, 25)
                xp_gain = min(duration_min * 5, 20)

                pet["energy"] = min(100, pet["energy"] + energy_gain)
                pet["xp"] = min(100, pet["xp"] + xp_gain)

                # Check level up
                if pet["xp"] >= 100:
                    pet["level"] += 1
                    pet["xp"] = 0
                    st.session_state.show_level_up = True

                # Update today's activity
                st.session_state.activities_today["exercise"] += duration_min
                st.session_state.exercise_active = False
                st.session_state.last_activity = f"Completed {duration_min} min of {exercise['name']}"
                st.success(f"Amazing! Energy +{energy_gain}%, XP +{xp_gain}")
                st.rerun()

        with col2:
            if st.button("Cancel", type="secondary", use_container_width=True, key="cancel_exercise"):
                st.session_state.exercise_active = False
                st.session_state.selected_exercise = None
                st.rerun()

        # Auto-refresh timer
        time.sleep(1)
        st.rerun()


def render_schedule():
    """Render the schedule/plan page."""
    st.markdown('<div class="page-title">Plan</div>', unsafe_allow_html=True)
    st.markdown('<div class="page-subtitle">Your wellness schedule</div>', unsafe_allow_html=True)

    # Add new item section
    with st.expander("➕ Add New Activity"):
        col1, col2 = st.columns(2)
        with col1:
            new_time = st.time_input("Time", value=datetime.strptime("09:00", "%H:%M").time(), key="new_time")
        with col2:
            new_type = st.selectbox("Type", ["breathe", "exercise", "music"], key="new_type")

        new_activity = st.text_input("Activity Name", placeholder="e.g., Morning Jog", key="new_activity")

        if st.button("Add to Schedule", type="primary", use_container_width=True, key="add_schedule"):
            time_str = new_time.strftime("%H:%M")
            st.session_state.schedule.append({
                "time": time_str,
                "activity": new_activity or f"New {new_type.title()}",
                "completed": False,
                "type": new_type,
            })
            # Sort by time
            st.session_state.schedule.sort(key=lambda x: x["time"])
            st.success("Added to schedule!")
            st.rerun()

    # Schedule list
    st.markdown('<div style="margin-top: 20px;"></div>', unsafe_allow_html=True)

    for idx, item in enumerate(st.session_state.schedule):
        icon = "🫁" if item["type"] == "breathe" else "🏃" if item["type"] == "exercise" else "🎵"
        completed = item["completed"]

        col1, col2, col3 = st.columns([1, 6, 1])
        with col1:
            st.markdown(f"<div style='font-size: 20px; text-align: center; padding-top: 8px;'>{icon}</div>", unsafe_allow_html=True)
        with col2:
            st.markdown(f"""
            <div style="{'text-decoration: line-through; opacity: 0.6;' if completed else ''}">
                <div style="font-weight: 500; font-size: 14px; color: #374151;">{item['activity']}</div>
                <div style="font-size: 12px; color: #94A3B8;">{item['time']}</div>
            </div>
            """, unsafe_allow_html=True)
        with col3:
            if st.checkbox("Done", value=completed, key=f"check_{idx}", label_visibility="collapsed"):
                if not completed:
                    st.session_state.schedule[idx]["completed"] = True
                    # Award small bonus
                    pet = st.session_state.pet
                    pet["xp"] = min(100, pet["xp"] + 5)
                    if pet["xp"] >= 100:
                        pet["level"] += 1
                        pet["xp"] = 0
                        st.session_state.show_level_up = True
                    st.rerun()
            else:
                if completed:
                    st.session_state.schedule[idx]["completed"] = False
                    st.rerun()

        st.markdown("<hr style='margin: 8px 0; border: none; border-top: 1px solid #E2E8F0;'>", unsafe_allow_html=True)

    # Smart recommendations
    st.markdown('<div style="font-size: 17px; font-weight: 600; color: #134E4A; margin: 24px 0 12px 0;">💡 Smart Recommendations</div>', unsafe_allow_html=True)

    # Simple recommendation logic
    pet = st.session_state.pet
    recs = []
    if pet["energy"] < 50:
        recs.append("Cozymo's energy is low. Try a light walk or stretching.")
    if pet["mood"] < 50:
        recs.append("Cozymo seems stressed. A breathing session would help!")
    if not recs:
        recs.append("Cozymo is doing well! Maintain your routine.")

    for rec in recs:
        st.info(rec)


def render_profile():
    """Render the profile/pet stats page."""
    pet = st.session_state.pet
    streak = st.session_state.streak
    activities = st.session_state.activities_today

    st.markdown('<div class="page-title">Profile</div>', unsafe_allow_html=True)
    st.markdown('<div class="page-subtitle">Your wellness journey</div>', unsafe_allow_html=True)

    # Pet display
    st.markdown(render_pet(pet["energy"], pet["mood"], size=140), unsafe_allow_html=True)

    # Stats grid
    st.markdown(f"""
    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-value">{pet['level']}</div>
            <div class="stat-label">Level</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">{streak['current']}</div>
            <div class="stat-label">Day Streak</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">{streak['best']}</div>
            <div class="stat-label">Best Streak</div>
        </div>
    </div>
    """, unsafe_allow_html=True)

    # Today's activity summary
    st.markdown('<div class="wellness-card">', unsafe_allow_html=True)
    st.markdown('<div style="font-size: 16px; font-weight: 600; color: #134E4A; margin-bottom: 16px;">Today\'s Activity</div>', unsafe_allow_html=True)

    total_mins = activities["breathe"] + activities["exercise"] + activities["music"]

    col1, col2, col3 = st.columns(3)
    with col1:
        st.metric("Breathe", f"{activities['breathe']} min")
    with col2:
        st.metric("Move", f"{activities['exercise']} min")
    with col3:
        st.metric("Music", f"{activities['music']} min")

    st.markdown(f'<div style="text-align: center; margin-top: 12px; font-size: 14px; color: #64748B;">Total: {total_mins} minutes today</div>', unsafe_allow_html=True)
    st.markdown('</div>', unsafe_allow_html=True)

    # Weekly progress (mock data for demo)
    st.markdown('<div class="wellness-card">', unsafe_allow_html=True)
    st.markdown('<div style="font-size: 16px; font-weight: 600; color: #134E4A; margin-bottom: 16px;">Weekly Progress</div>', unsafe_allow_html=True)

    days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    today_idx = datetime.now().weekday()

    # Mock weekly data
    weekly_data = [45, 30, 60, 20, 40, 0, 0]
    weekly_data[today_idx] = total_mins

    cols = st.columns(7)
    for i, (day, mins) in enumerate(zip(days, weekly_data)):
        is_today = i == today_idx
        bg_color = "#0D9488" if mins > 0 else "#E2E8F0"
        text_color = "white" if mins > 0 else "#94A3B8"

        with cols[i]:
            st.markdown(f"""
            <div style="
                text-align: center;
                padding: 8px 4px;
                border-radius: 8px;
                background: {bg_color};
                color: {text_color};
                font-size: 11px;
                font-weight: {'600' if is_today else '500'};
            ">
                <div>{day}</div>
                <div style="font-size: 13px; margin-top: 4px;">{mins}</div>
            </div>
            """, unsafe_allow_html=True)

    st.markdown('</div>', unsafe_allow_html=True)

    # Last activity
    if st.session_state.get("last_activity"):
        st.success(f"Last activity: {st.session_state.last_activity}")

    # Settings / Reset
    with st.expander("⚙️ Settings"):
        if st.button("Reset Demo Data", type="secondary", use_container_width=True, key="reset_data"):
            for key in list(st.session_state.keys()):
                del st.session_state[key]
            st.rerun()


# --- Main App ---

def main():
    """Main application entry point."""
    init_session_state()
    load_css()

    # Check for level up celebration
    if st.session_state.get("show_level_up", False):
        st.balloons()
        st.success(f"🎉 Level Up! Cozymo is now Level {st.session_state.pet['level']}!")
        st.session_state.show_level_up = False

    # Render current page
    current_page = st.session_state.get("page", "home")

    if current_page == "home":
        render_home()
    elif current_page == "activities":
        render_activities()
    elif current_page == "breathe":
        render_breathe_page()
    elif current_page == "schedule":
        render_schedule()
    elif current_page == "profile":
        render_profile()

    # Spacer for bottom nav
    st.markdown("<div style='height: 80px;'></div>", unsafe_allow_html=True)

    # Render bottom navigation
    render_bottom_nav()


if __name__ == "__main__":
    main()
