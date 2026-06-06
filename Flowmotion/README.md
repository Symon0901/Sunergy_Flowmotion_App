# Flowmotion - iOS App

A gamified wellness pet app built with SwiftUI for iOS.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## How to Run

1. Open **Xcode**
2. Create a new project: **File > New > Project**
3. Select **iOS > App**
4. Configure:
   - **Name**: `Flowmotion`
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **Minimum Deployments**: iOS 17.0
5. Click **Create**
6. Replace the contents of the project with the files in this folder:
   - Copy all `.swift` files from this folder into your Xcode project
   - Replace the auto-generated `ContentView.swift` and `<AppName>App.swift`
7. Select an iPhone Simulator (e.g., iPhone 15 Pro)
8. Press **Cmd+R** to run

## Features

- **Home**: Pet status, daily plan, quick actions
- **Move**: Exercise timer with 6 activities
- **Breathe**: Box breathing animation (4-4-4-4)
- **Plan**: Schedule management with recommendations
- **Me**: Profile stats, weekly progress, settings

## Architecture

```
Flowmotion/
├── FlowmotionApp.swift          # App entry + TabView
├── Models/
│   ├── Pet.swift            # Pet data model
│   ├── ScheduleItem.swift   # Schedule item model
│   └── Exercise.swift       # Exercise definitions
├── Views/
│   ├── HomeView.swift       # Home page
│   ├── ActivitiesView.swift # Exercise timer
│   ├── BreatheView.swift    # Breathing animation
│   ├── ScheduleView.swift   # Schedule management
│   └── ProfileView.swift    # Profile & stats
├── Components/
│   ├── PetView.swift        # Animated pet rendering
│   ├── ProgressBar.swift    # Status bars
│   └── AppIcons.swift       # Custom icons
├── ViewModels/
│   └── AppViewModel.swift   # App state management
└── Resources/
    └── AppColors.swift      # Design system
```
