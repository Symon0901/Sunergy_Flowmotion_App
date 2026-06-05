# Design Anti-Patterns

Common mistakes in AI-generated UI and how to avoid them.

## Critical Anti-Patterns (Never Do)

### 1. Emoji as Icons
**Problem**: Using emoji (📊, ⚙️, 👤, 🔔) instead of proper icon components.
**Why it's wrong**: Emojis render inconsistently across platforms, cannot be styled (color, size, stroke), look unprofessional, and violate accessibility standards.
**Solution**: Always use Lucide React icons. Map common concepts to Lucide icons:

| Concept | Emoji | Lucide Replacement |
|---------|-------|-------------------|
| Dashboard | 📊 | `LayoutDashboard` |
| Settings | ⚙️ | `Settings` |
| User | 👤 | `User` |
| Notification | 🔔 | `Bell` |
| Search | 🔍 | `Search` |
| Home | 🏠 | `Home` |
| Menu | ☰ | `Menu` |
| Close | ✕ | `X` |
| Add | + | `Plus` |
| Delete | 🗑️ | `Trash2` |
| Edit | ✏️ | `Pencil` |
| Share | ↗️ | `Share2` |
| Download | ⬇️ | `Download` |
| Upload | ⬆️ | `Upload` |
| Calendar | 📅 | `Calendar` |
| Mail | ✉️ | `Mail` |
| Lock | 🔒 | `Lock` |
| Unlock | 🔓 | `Unlock` |
| Star/Favorite | ⭐ | `Star` |
| Heart/Like | ❤️ | `Heart` |
| Arrow Right | → | `ArrowRight` |
| Arrow Left | ← | `ArrowLeft` |
| Chevron Down | ▼ | `ChevronDown` |
| Chevron Up | ▲ | `ChevronUp` |
| Check | ✓ | `Check` |
| Info | ℹ️ | `Info` |
| Warning | ⚠️ | `AlertTriangle` |
| Error | ❌ | `XCircle` |
| Success | ✅ | `CheckCircle2` |
| Help | ❓ | `HelpCircle` |
| Logout | → | `LogOut` |
| Refresh | ↻ | `RefreshCw` |
| Filter | 🔽 | `Filter` |
| Sort | ⇅ | `ArrowUpDown` |
| More actions | ⋯ | `MoreHorizontal` |
| File | 📄 | `FileText` |
| Folder | 📁 | `Folder` |
| Image | 🖼️ | `Image` |
| Link | 🔗 | `Link` |
| External link | ↗️ | `ExternalLink` |
| Copy | 📋 | `Copy` |
| Cut | ✂️ | `Scissors` |
| Paste | 📌 | `Clipboard` |
| Print | 🖨️ | `Printer` |
| Save | 💾 | `Save` |
| Refresh | 🔄 | `RotateCcw` |
| Zoom in | 🔍+ | `ZoomIn` |
| Zoom out | 🔍- | `ZoomOut` |
| Full screen | ⛶ | `Maximize2` |
| Minimize | ⛩ | `Minimize2` |
| Play | ▶ | `Play` |
| Pause | ⏸ | `Pause` |
| Stop | ⏹ | `Square` |
| Skip forward | ⏩ | `SkipForward` |
| Skip back | ⏪ | `SkipBack` |
| Volume | 🔊 | `Volume2` |
| Mute | 🔇 | `VolumeX` |
| Mic | 🎤 | `Mic` |
| Camera | 📷 | `Camera` |
| Phone | 📞 | `Phone` |
| Video | 🎥 | `Video` |
| Map | 🗺️ | `Map` |
| Location | 📍 | `MapPin` |
| Clock | 🕐 | `Clock` |
| History | 🔄 | `History` |
| Bookmark | 🔖 | `Bookmark` |
| Flag | 🚩 | `Flag` |
| Tag | 🏷️ | `Tag` |
| Code | `</>` | `Code` |
| Terminal | >_ | `Terminal` |
| Database | 🗄️ | `Database` |
| Cloud | ☁️ | `Cloud` |
| Sun | ☀️ | `Sun` |
| Moon | 🌙 | `Moon` |
| Eye | 👁️ | `Eye` |
| Eye off | 🚫👁️ | `EyeOff` |

### 2. Pure Black and Pure White
**Problem**: Using #000000 for text and #FFFFFF for backgrounds.
**Why it's wrong**: Pure black on pure white creates maximum contrast that causes eye strain. Real-world designs use slightly softened tones.
**Solution**:
- Background: #F9FAFB or #F8FAFC instead of #FFFFFF
- Text: #1F2937 or #111827 instead of #000000
- Dark mode bg: #0F172A instead of #000000
- Dark mode text: #F1F5F9 instead of #FFFFFF

### 3. Inconsistent Spacing
**Problem**: Random pixel values — 13px here, 17px there, 23px elsewhere.
**Why it's wrong**: Creates visual chaos, makes the UI feel unpolished and accidental.
**Solution**: Stick to 4px grid. Only use multiples of 4: 4, 8, 12, 16, 20, 24, 32, 40, 48, 64.

### 4. Missing States
**Problem**: Only designing the default state of interactive elements.
**Why it's wrong**: Users see hover/focus/disabled states constantly. Missing them makes the app feel broken.
**Solution**: Every interactive element MUST have: Default, Hover, Active, Focus, Disabled. Loading is strongly recommended.

### 5. No Empty States
**Problem**: Showing blank white areas when there's no data.
**Why it's wrong**: Users don't know if the page is broken, loading, or truly empty.
**Solution**: Every list, table, search result, and dashboard needs a designed empty state with icon + title + description + action button.

## Visual Anti-Patterns

### 6. Centered Text Walls
**Problem**: Long paragraphs of center-aligned text.
**Why it's wrong**: Hard to read, ragged edges disrupt scanning flow.
**Solution**: Body text always left-aligned. Center only for short headlines (< 2 lines) and hero sections.

### 7. Too Many Font Sizes
**Problem**: Using 15 different font sizes across the app.
**Why it's wrong**: Creates visual noise, no hierarchy established.
**Solution**: Maximum 6-7 type tokens: Display, H1, H2, H3, Body, Caption, Overline.

### 8. Insufficient Contrast
**Problem**: Light gray text on white backgrounds, or similar low-contrast combinations.
**Why it's wrong**: Unreadable for many users, fails accessibility standards.
**Solution**: Check contrast ratios. Minimum 4.5:1 for body text, 3:1 for large text/UI elements.

### 9. Random Border Radius
**Problem**: 3px on buttons, 8px on cards, 15px on inputs, 50% on modals — all on the same screen.
**Why it's wrong**: Inconsistency looks accidental and unprofessional.
**Solution**: Define 3-4 radius tokens and use them consistently:
- radius-sm (4px): inputs, small buttons
- radius-md (8px): cards, default buttons
- radius-lg (12-16px): modals, containers
- radius-full: avatars, pills

### 10. Shadow Overuse or Absence
**Problem**: Either every element has a shadow (visual noise) or nothing has depth (flat confusion).
**Why it's wrong**: Shadows communicate elevation. Overuse = no hierarchy. Absence = no depth cues.
**Solution**: Use 3 shadow levels purposefully:
- Level 1: Cards, containers
- Level 2: Dropdowns, popovers, floating elements
- Level 3: Modals, dialogs

## Interaction Anti-Patterns

### 11. No Loading Feedback
**Problem**: Buttons don't change when clicked, forms submit without indication.
**Why it's wrong**: Users think the action failed and click repeatedly.
**Solution**: Buttons show spinner and disabled state during async actions. Forms show skeleton or spinner.

### 12. Jarring Transitions
**Problem**: Instant state changes with no transition, or overly slow animations.
**Why it's wrong**: Feels robotic or frustrating.
**Solution**: 150-200ms for hover/focus, 200-300ms for modals, use ease-out curves.

### 13. Touch Targets Too Small
**Problem**: Buttons or links smaller than 44x44px on mobile.
**Why it's wrong**: Impossible to tap accurately, causes frustration.
**Solution**: Minimum 44x44px touch target. Icon buttons should be at least 36x36px with padding.

### 14. Form Validation Only on Submit
**Problem**: Forms show all errors only after clicking submit.
**Why it's wrong**: Users fix one error, submit again, see another error — frustrating cycle.
**Solution**: Real-time validation on blur. Inline errors below each field with red text and icon.

## Layout Anti-Patterns

### 15. Fixed Width Breakpoints Only
**Problem**: Using exact pixel widths without fluid scaling.
**Why it's wrong**: Looks broken on devices between breakpoints.
**Solution**: Use fluid typography (clamp()) and percentage-based layouts with max-width containers.

### 16. Horizontal Scroll on Mobile
**Problem**: Content overflows viewport width on mobile devices.
**Why it's wrong**: Users must scroll horizontally to see content — poor mobile experience.
**Solution**: Always use `max-width: 100%`, `overflow-x: hidden` on body, test on 375px width.

### 17. Content Touching Screen Edges
**Problem**: Text and cards go right to the screen edge with no padding.
**Why it's wrong**: Hard to read, feels cramped, accidental.
**Solution**: Minimum 16px horizontal padding on mobile, 24px on tablet, 32px on desktop.
