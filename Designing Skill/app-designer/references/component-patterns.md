# Component Design Patterns

Detailed specifications for core UI components with all required states.

## Table of Contents
- [Button](#button)
- [Input](#input)
- [Card](#card)
- [Navigation](#navigation)
- [Modal/Dialog](#modaldialog)
- [Dropdown/Select](#dropdownselect)
- [Toast/Notification](#toastnotification)
- [Empty State](#empty-state)
- [Skeleton](#skeleton)
- [Badge/Tag](#badgetag)

## Button

### Variants

**Primary Button**
```
Background: Primary color
Text: White
Border: none
Padding: 10px 20px (default), 6px 12px (small), 14px 28px (large)
Border-radius: radius-md (8px) or radius-full for pill style
Font: Body weight-semibold
```

States:
| State | Visual |
|-------|--------|
| Default | Solid primary bg, white text |
| Hover | Darken bg 10%, add shadow-md with primary color glow |
| Active | Scale(0.97), darken bg 15% |
| Focus | 2px ring in primary color, 2px offset |
| Disabled | Opacity 0.4, cursor not-allowed |
| Loading | Spinner icon replaces text, opacity 0.8 |

**Secondary Button**
```
Background: transparent or surface color
Text: Primary color
Border: 1px solid primary color (20% opacity)
```
States follow Primary but with inverted colors.

**Ghost Button**
```
Background: transparent
Text: Text primary
Border: none
```
Hover: Background at 5-10% opacity of text color.

**Danger Button**
```
Background: Error color
Text: White
```
Follows Primary pattern but with error color.

### Icon Button
```
Size: 36x36px (default), 32x32px (small), 44x44px (large)
Border-radius: radius-md
Icon: 20px centered
Background: transparent (default), surface (filled variant)
```

## Input

### Text Input
```
Background: Surface or white
Border: 1px solid Border color
Border-radius: radius-sm (4px) or radius-md (8px)
Padding: 10px 14px
Font: Body size
Text color: Text primary
Placeholder: Text secondary at 60% opacity
```

States:
| State | Visual |
|-------|--------|
| Default | 1px border |
| Hover | Border darkens slightly |
| Focus | 2px Primary border, subtle primary glow shadow |
| Error | 2px Error border, error bg tint (1-2%) |
| Disabled | Opacity 0.5, bg slightly grayed |
| Filled | Text primary, label floats above (if floating label) |

### Input with Icon
```
Left icon: 20px, Text secondary color, positioned 12px from left
Text padding-left: 40px (to clear icon)
Right icon/action: Same spacing, for clear button or visibility toggle
```

### Textarea
Same as text input but:
```
Min-height: 80px
Resize: vertical only
Padding: 12px 14px
```

### Search Input
```
Left icon: Search icon (20px, text secondary)
Border-radius: radius-full (pill shape) or radius-md
Background: Surface color (subtle fill)
Placeholder: "Search..."
```

## Card

### Content Card
```
Background: Surface
Border: 1px solid Border (optional, can be borderless)
Border-radius: radius-lg (12px)
Padding: 24px
Shadow: shadow-sm or none
```

Hover (if clickable): `shadow-md, translateY(-1px), 200ms ease`

### Structure
```
[Header: optional title + action button, mb-16]
[Media: optional image/video, full-width, radius-top]
[Content: title, description, body]
[Footer: optional actions, metadata, timestamps]
```

### Stat Card (Dashboard)
```
Compact: Padding 20px
Icon: 40px container, rounded, primary bg at 10% opacity, primary icon
Value: Display size font, font-bold
Label: Caption size, text secondary
Trend: Optional up/down indicator with color
```

### List Item Card
```
Horizontal layout: [Icon/Avatar] [Content] [Action]
Padding: 12px 16px
Border-bottom: 1px solid Border (between items)
Min-height: 56px
```

## Navigation

### Top Navigation Bar
```
Height: 56-64px
Background: Surface or white
Border-bottom: 1px solid Border
Padding: 0 24px
Position: sticky top-0
Z-index: 50
Backdrop-filter: blur(8px) when scrolled (glassmorphism)
```

Elements:
- **Logo**: Left, 32px height
- **Nav links**: Center or left, 15px font, medium weight, gap 24-32px
- **Actions**: Right, icon buttons or CTA button
- **Mobile**: Hamburger menu, drawer from left

### Sidebar Navigation
```
Width: 240-260px (desktop), 280px (mobile drawer)
Background: Surface or slightly darker
Border-right: 1px solid Border
Padding: 16px 12px
```

Nav Item:
```
Height: 40px
Padding: 0 12px
Border-radius: radius-sm
Icon: 20px, gap 12px to label
Font: Body small, medium weight
Gap between items: 4px
```

States:
| State | Visual |
|-------|--------|
| Default | Transparent bg, text secondary |
| Hover | Surface-hover bg, text primary |
| Active | Primary bg at 8%, primary color text and icon |
| Collapsed | Only icons visible, width 64px |

### Bottom Tab Bar (Mobile)
```
Height: 64px (safe area aware)
Background: Surface with blur
Border-top: 1px solid Border
Position: fixed bottom
Z-index: 50
Items: 3-5 tabs
```

Tab Item:
```
Icon: 24px
Label: Caption size, mt-4
Active: Primary color, icon filled or stroke 2.5
Inactive: Text secondary, stroke 1.5
```

## Modal/Dialog

### Overlay
```
Background: rgba(0,0,0,0.5)
Backdrop-filter: blur(4px)
Z-index: 100
Animation: fade in 200ms
```

### Modal Container
```
Background: Surface
Border-radius: radius-lg (12px) or radius-xl (16px)
Shadow: shadow-xl
Max-width: 480px (default), 640px (large), 360px (small)
Max-height: 85vh
Overflow: auto
```

### Structure
```
[Header: padding 20-24px, border-bottom optional]
  [Title: H3 size, semibold]
  [Close button: icon button top-right, X icon]
[Body: padding 20-24px, overflow-auto]
[Footer: padding 16-20px, border-top, flex justify-end gap-8]
  [Cancel: ghost button]
  [Confirm: primary button]
```

Animation: `scale(0.95) → scale(1), opacity 0→1, 200ms ease-out`

### Mobile Adaptation
Bottom sheet style:
```
Position: fixed bottom
Border-radius: radius-xl top corners only
Max-height: 90vh
Slide up animation: translateY(100%) → translateY(0), 300ms spring
```

## Dropdown/Select

### Trigger
Same as button or input with chevron-down icon right-aligned.

### Menu
```
Background: Surface
Border: 1px solid Border
Border-radius: radius-md
Shadow: shadow-lg
Min-width: match trigger
Padding: 4px
Z-index: 60
```

### Menu Item
```
Padding: 8px 12px
Border-radius: radius-sm
Font: Body small
Icon: optional, 16px, gap 8px
```

States:
| State | Visual |
|-------|--------|
| Default | Transparent |
| Hover | Surface-hover bg |
| Active/Selected | Primary bg at 8%, primary text, checkmark icon |
| Disabled | Opacity 0.4 |

### Separator
```
Height: 1px
Background: Border color
Margin: 4px 8px
```

## Toast/Notification

### Container
```
Position: fixed top-right (desktop), top-center (mobile)
Gap: 8px between toasts
Z-index: 200
Max-width: 400px
```

### Toast Item
```
Background: Surface
Border: 1px solid Border
Border-radius: radius-md
Shadow: shadow-lg
Padding: 12px 16px
Min-height: 48px
```

### Structure
```
[Icon: 20px, left, variant color]
[Content: flex-1]
  [Title: Body small, semibold, single line]
  [Message: Caption, text secondary, max 2 lines]
[Close: X icon button, 16px]
```

Variants:
| Type | Icon | Icon Color | Left Border |
|------|------|-----------|-------------|
| Success | Check circle | Success green | 3px solid success |
| Warning | Alert triangle | Warning amber | 3px solid warning |
| Error | X circle | Error red | 3px solid error |
| Info | Info circle | Info blue | 3px solid info |

Animation: `slide in from right 300ms, auto-dismiss after 4-5s with progress bar`

## Empty State

### Container
```
Display: flex, flex-col, items-center, text-center
Padding: 48px 24px
Max-width: 320px (centered)
```

### Structure
```
[Illustration: 120-160px, muted/gray tone or subtle primary tint]
[Title: H3 size, semibold, mt-24]
[Description: Body small, text secondary, mt-8, max 2 lines]
[Action: Primary or Secondary button, mt-24]
```

Rules:
- Illustration should be simple, not overly detailed
- Use Lucide icon at large size (48-64px) if no custom illustration
- Never leave empty space with no explanation
- Action button should help user populate the empty state

## Skeleton

### Base
```
Background: linear-gradient(90deg, Border 25%, Light-gray 50%, Border 75%)
Background-size: 200% 100%
Animation: shimmer 1.5s infinite
Border-radius: radius-sm
```

### Common Patterns
```
Text line: height 16px, width 60-100%, mb-8
Avatar: 40x40px, radius-full
Card: full width, height 120px, radius-md
Title: height 20px, width 40%, mb-12
```

### Shimmer Animation
```css
@keyframes shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
```

## Badge/Tag

### Badge (Status Indicator)
```
Height: 20px
Padding: 0 8px
Border-radius: radius-full
Font: Overline (11px, medium)
Display: inline-flex, items-center, gap-4
```

Variants:
| Status | Background | Text Color |
|--------|-----------|------------|
| Active/Success | Success at 10% | Success dark |
| Warning | Warning at 10% | Warning dark |
| Error | Error at 10% | Error dark |
| Info | Info at 10% | Info dark |
| Neutral | Gray at 10% | Gray dark |
| New/Featured | Primary at 10% | Primary |

### Dot Variant
```
Size: 8px circle
Position: before text or top-right of icon
Same colors as above
```

### Tag (Filter/Label)
```
Height: 28px
Padding: 0 12px
Border-radius: radius-full or radius-sm
Border: 1px solid Border
Background: transparent or Surface
Font: Body small, medium
```

States:
| State | Visual |
|-------|--------|
| Default | Bordered, text secondary |
| Hover | Border darkens |
| Selected | Primary bg, white text, no border |
| Removable | X icon at 14px, ml-4 |
