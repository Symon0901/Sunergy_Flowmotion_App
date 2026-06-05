import streamlit as st

st.set_page_config(page_title="SVG Test 2", layout="centered")
st.title("SVG via st.image()")

svg = '''<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="red"/></svg>'''

# st.image supports SVG strings
st.image(svg, use_container_width=False)
st.write("If you see a red circle above, st.image() works for SVG.")
