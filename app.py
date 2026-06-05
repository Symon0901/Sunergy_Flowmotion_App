import streamlit as st
import time
from datetime import datetime

from styles import load_css
from components.pet import render_pet, render_pet_status, celebrate, get_pet_state
from components.navigation import render_bottom_nav
from components.breathe_circle import render_breathe_page

st.set_page_config(
    page_title="Cozymo",
    page_icon="🌿",
    layout="centered",
    initial_sidebar_state="collapsed",
)


def init():
    defaults = {
        "page": "home",
        "pet": {"name": "Cozymo", "level": 1, "energy": 55, "mood": 55, "xp": 35},
        "streak": {"current": 3, "best": 7, "last_active": datetime.now().strftime("%Y-%m-%d")},
        "schedule": [
            {"time": "08:00", "activity": "Morning Breathe", "completed": False, "type": "breathe"},
            {"time": "12:30", "activity": "Lunch Walk", "completed": False, "type": "exercise"},
            {"time": "18:00", "activity": "Badminton", "completed": False, "type": "exercise"},
            {"time": "21:30", "activity": "Evening Relax", "completed": False, "type": "breathe"},
        ],
        "activities_today": {"breathe": 0, "exercise": 0, "music": 0},
        "breathing_active": False,
        "exercise_active": False,
        "selected_exercise": None,
        "last_activity": None,
        "show_level_up": False,
        "breathe_dur": 3,
    }
    for k, v in defaults.items():
        if k not in st.session_state:
            st.session_state[k] = v


# ─── Pages ───

def page_home():
    pet = st.session_state.pet
    streak = st.session_state.streak

    c1, c2 = st.columns([3, 1])
    with c1:
        st.html('<div class="title-xl">Good Day!</div>')
        st.html(f'<div class="body" style="margin-bottom:16px;">Day {streak["current"]} streak</div>')
    with c2:
        st.html(f'<div style="text-align:right;"><div class="badge badge-gold">Lv.{pet["level"]}</div></div>')

    render_pet(pet["energy"], pet["mood"])
    render_pet_status(pet["energy"], pet["mood"], pet["level"], pet["xp"])

    st.html('<div class="overline" style="margin:20px 0 10px 0;">Today\'s Plan</div>')

    for item in st.session_state.schedule:
        done = item["completed"]
        opacity = "opacity:0.45;" if done else ""
        dot_class = item["type"]
        check = '<div style="width:18px;height:18px;border-radius:50%;background:#0D9488;display:flex;align-items:center;justify-content:center;color:white;font-size:11px;font-weight:700;">✓</div>' if done else '<div style="width:18px;height:18px;border-radius:50%;border:2px solid #E5E7EB;"></div>'
        st.html(f"""
        <div class="schedule-row" style="{opacity}">
            <div class="schedule-dot {dot_class}"></div>
            <div style="flex:1;min-width:0;">
                <div style="font-weight:500;font-size:14px;color:#1F2937;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">{item['activity']}</div>
                <div class="caption">{item['time']}</div>
            </div>
            <div style="flex-shrink:0;">{check}</div>
        </div>
        """)

    c1, c2 = st.columns(2)
    with c1:
        if st.button("Quick Breathe", type="primary", use_container_width=True, key="q_breathe"):
            st.session_state.page = "breathe"; st.rerun()
    with c2:
        if st.button("Start Moving", type="secondary", use_container_width=True, key="q_move"):
            st.session_state.page = "activities"; st.rerun()


def page_activities():
    st.html('<div class="title-xl">Move</div>')
    st.html('<div class="body" style="margin-bottom:20px;">Choose an activity</div>')

    exercises = [
        ("badminton", "Badminton", "Great cardio & fun with friends", "#0D9488"),
        ("basketball", "Basketball", "Team sport for energy boost", "#F59E0B"),
        ("running", "Running", "Clear your mind, build stamina", "#EF4444"),
        ("swimming", "Swimming", "Full body, low impact", "#3B82F6"),
        ("yoga", "Yoga", "Flexibility and calm", "#8B5CF6"),
        ("other", "Other", "Any movement counts", "#6B7280"),
    ]

    if not st.session_state.get("exercise_active"):
        for eid, name, desc, color in exercises:
            if st.button(
                f"{name}\n\n{desc}",
                key=f"ex_{eid}",
                use_container_width=True,
            ):
                st.session_state.selected_exercise = {"id": eid, "name": name, "color": color}
                st.session_state.exercise_active = True
                st.session_state.exercise_start = time.time()
                st.rerun()
    else:
        ex = st.session_state.selected_exercise
        elapsed = time.time() - st.session_state.exercise_start
        m, s = int(elapsed // 60), int(elapsed % 60)
        color = ex.get("color", "#0D9488")

        st.html(f"""
        <div style="text-align:center;padding:36px 0;">
            <div style="width:72px;height:72px;border-radius:20px;background:{color};display:flex;align-items:center;justify-content:center;margin:0 auto 20px auto;color:white;font-size:28px;font-weight:700;">
                {ex['name'][0]}
            </div>
            <div class="timer-digits">{m:02d}:{s:02d}</div>
            <div class="title-md" style="margin-top:12px;">{ex['name']}</div>
            <div class="body">Cozymo is cheering for you</div>
        </div>
        """)

        c1, c2 = st.columns(2)
        with c1:
            if st.button("Finish", type="primary", use_container_width=True, key="ex_finish"):
                dur = max(1, int(elapsed / 60))
                pet = st.session_state.pet
                pet["energy"] = min(100, pet["energy"] + min(dur * 8, 25))
                pet["xp"] = min(100, pet["xp"] + min(dur * 5, 20))
                if pet["xp"] >= 100:
                    pet["level"] += 1; pet["xp"] = 0
                    st.session_state.show_level_up = True
                st.session_state.activities_today["exercise"] += dur
                st.session_state.exercise_active = False
                st.session_state.last_activity = f"Completed {dur} min of {ex['name']}"
                st.success(f"Amazing! Energy +{min(dur*8,25)}%, XP +{min(dur*5,20)}")
                st.rerun()
        with c2:
            if st.button("Cancel", type="secondary", use_container_width=True, key="ex_cancel"):
                st.session_state.exercise_active = False
                st.session_state.selected_exercise = None
                st.rerun()

        time.sleep(1); st.rerun()


def page_schedule():
    st.html('<div class="title-xl">Plan</div>')
    st.html('<div class="body" style="margin-bottom:20px;">Your wellness schedule</div>')

    with st.expander("Add Activity"):
        c1, c2 = st.columns(2)
        with c1:
            new_time = st.time_input("Time", value=datetime.strptime("09:00", "%H:%M").time(), key="new_time")
        with c2:
            new_type = st.selectbox("Type", ["breathe", "exercise", "music"], key="new_type")
        new_name = st.text_input("Name", placeholder="Morning jog", key="new_name")
        if st.button("Add", type="primary", use_container_width=True, key="add_sch"):
            st.session_state.schedule.append({
                "time": new_time.strftime("%H:%M"),
                "activity": new_name or f"New {new_type.title()}",
                "completed": False, "type": new_type,
            })
            st.session_state.schedule.sort(key=lambda x: x["time"])
            st.rerun()

    st.html('<div style="margin-top:16px;"></div>')

    for idx, item in enumerate(st.session_state.schedule):
        done = item["completed"]
        dot = item["type"]
        st.html(f"""
        <div class="schedule-row{' done' if done else ''}">
            <div class="schedule-dot {dot}"></div>
            <div style="flex:1;">
                <div style="font-weight:500;font-size:14px;color:#1F2937;{'text-decoration:line-through;' if done else ''}">{item['activity']}</div>
                <div class="caption">{item['time']}</div>
            </div>
        </div>
        """)

        # Hidden checkbox for toggling
        if st.checkbox("Done", value=done, key=f"sch_{idx}", label_visibility="collapsed"):
            if not done:
                st.session_state.schedule[idx]["completed"] = True
                pet = st.session_state.pet
                pet["xp"] = min(100, pet["xp"] + 5)
                if pet["xp"] >= 100:
                    pet["level"] += 1; pet["xp"] = 0
                    st.session_state.show_level_up = True
                st.rerun()
        else:
            if done:
                st.session_state.schedule[idx]["completed"] = False
                st.rerun()

    st.html('<div class="overline" style="margin:20px 0 10px 0;">Recommendations</div>')
    pet = st.session_state.pet
    recs = []
    if pet["energy"] < 50: recs.append("Cozymo's energy is low. Try a light walk.")
    if pet["mood"] < 50: recs.append("Cozymo seems stressed. Try breathing.")
    if not recs: recs.append("Cozymo is doing well! Keep it up.")
    for rec in recs:
        st.html(f'<div class="card" style="padding:12px 14px;margin-bottom:8px;"><div class="body" style="margin:0;">{rec}</div></div>')


def page_profile():
    pet = st.session_state.pet
    streak = st.session_state.streak
    acts = st.session_state.activities_today

    st.html('<div class="title-xl">Profile</div>')
    st.html('<div class="body" style="margin-bottom:16px;">Your wellness journey</div>')

    render_pet(pet["energy"], pet["mood"], size=120)

    total = acts["breathe"] + acts["exercise"] + acts["music"]

    st.html(f"""
    <div class="stat-grid" style="margin-top:16px;">
        <div class="stat-box">
            <div class="stat-num">{pet['level']}</div>
            <div class="stat-label">Level</div>
        </div>
        <div class="stat-box">
            <div class="stat-num">{streak['current']}</div>
            <div class="stat-label">Streak</div>
        </div>
        <div class="stat-box">
            <div class="stat-num">{total}</div>
            <div class="stat-label">Min Today</div>
        </div>
    </div>
    """)

    st.html('<div class="card">')
    st.html('<div class="title-sm" style="margin-bottom:12px;">Today\'s Activity</div>')
    c1, c2, c3 = st.columns(3)
    with c1: st.metric("Breathe", f"{acts['breathe']} min")
    with c2: st.metric("Move", f"{acts['exercise']} min")
    with c3: st.metric("Music", f"{acts['music']} min")
    st.html('</div>')

    # Weekly
    st.html('<div class="card">')
    st.html('<div class="title-sm" style="margin-bottom:12px;">Weekly Progress</div>')
    days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    today_idx = datetime.now().weekday()
    weekly = [35, 20, 50, 15, 30, 0, 0]
    weekly[today_idx] = total

    cols = st.columns(7)
    for i, (d, v) in enumerate(zip(days, weekly)):
        is_today = i == today_idx
        bg = "#0D9488" if v > 0 else "#F3F4F6"
        tc = "white" if v > 0 else "#9CA3AF"
        with cols[i]:
            st.html(f"""
            <div style="text-align:center;padding:8px 2px;border-radius:10px;background:{bg};color:{tc};font-size:11px;font-weight:{'600' if is_today else '500'};">
                <div>{d}</div>
                <div style="font-size:13px;margin-top:3px;font-weight:700;">{v}</div>
            </div>
            """)
    st.html('</div>')

    if st.session_state.get("last_activity"):
        st.info(f"Last: {st.session_state.last_activity}")

    with st.expander("Settings"):
        if st.button("Reset Data", type="secondary", use_container_width=True, key="reset"):
            for k in list(st.session_state.keys()): del st.session_state[k]
            st.rerun()


# ─── Main ───

def main():
    init()
    load_css()

    if st.session_state.get("show_level_up"):
        st.html(celebrate())
        st.success(f"Level Up! Cozymo is now Level {st.session_state.pet['level']}")
        st.session_state.show_level_up = False

    page = st.session_state.get("page", "home")
    if page == "home":       page_home()
    elif page == "activities": page_activities()
    elif page == "breathe":   render_breathe_page()
    elif page == "schedule":  page_schedule()
    elif page == "profile":   page_profile()

    st.html('<div style="height:80px;"></div>')
    render_bottom_nav()


if __name__ == "__main__":
    main()
