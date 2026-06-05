import streamlit as st

st.set_page_config(page_title="SVG Test", layout="centered")

st.title("SVG Test")

# Test 1: Simple SVG via st.html
st.subheader("Test 1: Simple SVG via st.html")
st.html('<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="red"/></svg>')

# Test 2: SVG with animation
st.subheader("Test 2: SVG with animate")
st.html('''<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="40" fill="blue">
    <animate attributeName="r" values="40;50;40" dur="2s" repeatCount="indefinite"/>
  </circle>
</svg>''')

# Test 3: SVG with filter
st.subheader("Test 3: SVG with filter")
st.html('''<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="b"/>
      <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
    </filter>
  </defs>
  <circle cx="50" cy="50" r="40" fill="green" filter="url(#glow)"/>
</svg>''')

# Test 4: Full pet SVG
st.subheader("Test 4: Full pet SVG")
from components.pet import _pet_svg
st.html(_pet_svg(50, 50, 120))
