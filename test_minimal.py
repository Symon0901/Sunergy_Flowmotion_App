import streamlit as st
from styles import load_css

st.set_page_config(page_title="Test", layout="centered")
load_css()
st.markdown('<div class="title-xl">Hello World</div>', unsafe_allow_html=True)
st.write("If you see this, CSS is working.")
