import streamlit as st
from components.icons import icon

st.set_page_config(page_title="No CSS Test", layout="centered")

st.title("No CSS Test")
st.write("If you see this, Streamlit works fine.")

svg = icon("home", 24)
st.markdown(f'<div>{svg} Home Icon</div>', unsafe_allow_html=True)
st.write("Icon rendered above.")

from components.pet import render_pet
st.markdown(render_pet(50, 50, 80), unsafe_allow_html=True)
st.write("Pet rendered above.")
