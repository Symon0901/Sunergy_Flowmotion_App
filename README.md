# Flowmotion - Gamified Wellness Pet App

A prototype wellness app built with Streamlit, featuring a virtual pet (Flowmotion) that users care for through breathing exercises, physical activities, and relaxation.

## Features

- **Home**: View pet status (Energy, Mood, XP), daily schedule overview, quick action buttons
- **Move**: Choose from various exercises (Badminton, Basketball, Running, Swimming, Yoga, etc.) with timer
- **Breathe**: Calm-style breathing guide with animated circle (Box Breathing 4-4-4-4)
- **Plan**: Editable daily schedule with smart recommendations
- **Me**: Profile with stats, weekly progress, streak tracking

## Design System

Following the `Designing Skill` specification:
- **Primary**: Teal (#0D9488) - Calm/Wellness mood
- **Typography**: Inter font family, 7-level type scale
- **Spacing**: 4px base grid
- **Icons**: Lucide-style SVG icons (no emoji)
- **Animation**: CSS keyframes for pet float, breathe circle, progress bars

## Run Locally

```bash
cd /Users/JensenW/AA_EngEnv/gamified_wellness_app
streamlit run app.py
```

The app will open at http://localhost:8501

## Project Structure

```
gamified_wellness_app/
├── app.py                    # Main application entry
├── styles.py                 # Custom CSS (mobile simulation, animations)
├── components/
│   ├── __init__.py
│   ├── pet.py               # Pet SVG rendering + status bars
│   ├── navigation.py        # Bottom tab bar
│   └── breathe_circle.py    # Calm-style breathing animation
└── README.md
```

## Pet Mechanics

- **Energy** (0-100%): Increased by exercise, decreases over time
- **Mood** (0-100%): Increased by breathing/meditation, decreases over time
- **XP** (0-100): Gained from all activities, fills up to level up
- **Level**: Increases when XP reaches 100
- **Streak**: Daily activity streak counter
