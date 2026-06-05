import streamlit as st
from styles import load_css
from components.icons import icon

st.set_page_config(page_title="Debug", layout="centered")

st.title("Step 1: Plain text works")

load_css()
st.title("Step 2: CSS loaded")

st.markdown(f'<div>{icon("home", 24)} Home Icon</div>', unsafe_allow_html=True)
st.title("Step 3: Icon works")

from components.pet import render_pet
st.markdown(render_pet(50, 50, 80), unsafe_allow_html=True)
st.title("Step 4: Pet works")

st.write("If you see all 4 steps, everything renders correctly.")
