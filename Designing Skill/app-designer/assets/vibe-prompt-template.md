# {Project Name} — UI Implementation Prompt

Use this specification to implement the UI. Follow every detail precisely. Do not deviate from the design system.

## Design Philosophy

{Project description and visual direction. Describe the mood, personality, and feel.}

## Technology Stack

- **Framework**: React + TypeScript
- **Styling**: Tailwind CSS
- **Icons**: Lucide React (`lucide-react` package)
- **Animation**: CSS transitions + Framer Motion (for complex interactions)

## CRITICAL RULES

1. **NEVER use emoji as icons** — always import from `lucide-react`
2. **NEVER use arbitrary values** — everything must come from the design system below
3. **NEVER skip states** — every interactive element needs: Default, Hover, Active, Focus, Disabled
4. **ALWAYS use the 4px spacing grid** — no random pixel values
5. **ALWAYS implement empty states** — no blank areas when there's no data
6. **ALWAYS implement loading states** — skeletons for data, spinners for actions
7. **Use the exact hex values specified** — no approximations

## Color Tokens

```javascript
const colors = {
  primary: {
    DEFAULT: '{hex}',
    light: '{hex}',
    dark: '{hex}',
  },
  background: '{hex}',
  surface: '{hex}',
  text: {
    primary: '{hex}',
    secondary: '{hex}',
  },
  border: '{hex}',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  info: '#3B82F6',
}
```

Dark mode variants:
```javascript
const darkColors = {
  background: '{hex}',
  surface: '{hex}',
  text: {
    primary: '{hex}',
    secondary: '{hex}',
  },
  border: '{hex}',
}
```

## Typography

```css
font-family: {font-stack};
```

| Token | Size | Weight | Line-Height | Tailwind Classes |
|-------|------|--------|-------------|-----------------|
| Display | {size} | {weight} | {lh} | {tailwind} |
| H1 | {size} | {weight} | {lh} | {tailwind} |
| H2 | {size} | {weight} | {lh} | {tailwind} |
| H3 | {size} | {weight} | {lh} | {tailwind} |
| Body | {size} | {weight} | {lh} | {tailwind} |
| Caption | {size} | {weight} | {lh} | {tailwind} |

## Spacing

Use Tailwind spacing scale: 1=4px, 2=8px, 3=12px, 4=16px, 5=20px, 6=24px, 8=32px, 10=40px, 12=48px

## Shadows

| Level | Tailwind | Custom (if needed) |
|-------|----------|-------------------|
| Card | shadow-sm | — |
| Dropdown | shadow-md | — |
| Modal | shadow-lg | — |
| Button glow | — | `0 4px 14px {primary}40` |

## Component Specifications

### Button

**Primary:**
```
Default:   bg-primary text-white rounded-md px-5 py-2.5 font-semibold
Hover:     darken bg, add shadow with primary glow
Active:    scale-[0.97] darken bg
Focus:     ring-2 ring-primary ring-offset-2
Disabled:  opacity-40 cursor-not-allowed
Loading:   opacity-80, show spinner icon, disable pointer events
```

**Secondary:**
```
Default:   bg-transparent border border-primary/20 text-primary
Hover:     bg-primary/5
```

**Ghost:**
```
Default:   bg-transparent text-text-primary
Hover:     bg-text-primary/5
```

**Sizes:**
- Small: `px-3 py-1.5 text-sm`
- Default: `px-5 py-2.5 text-sm`
- Large: `px-7 py-3.5 text-base`

### Input

```
Default:   bg-surface border border-border rounded-md px-3.5 py-2.5 text-body
Hover:     border-border/80
Focus:     border-primary ring-2 ring-primary/20
Error:     border-error bg-error/5
Disabled:  opacity-50 bg-muted
```

With left icon:
```
Container: relative
Icon:      absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-text-secondary
Input:     pl-10
```

### Card

```
Container: bg-surface rounded-xl p-6 shadow-sm
Hover (if clickable): shadow-md -translate-y-0.5 transition-all duration-200
```

**Structure:**
```
[Header: flex justify-between items-center mb-4]
  [Title: text-xl font-semibold]
  [Action: icon button or link]
[Body: content area]
[Footer: optional, flex justify-end gap-2 mt-4 pt-4 border-t]
```

### Navigation

**Top Bar:**
```
Container: sticky top-0 z-50 h-16 bg-surface/80 backdrop-blur-md border-b border-border
Layout: flex items-center justify-between px-6
Left: Logo + nav links (gap-8, text-sm font-medium)
Right: Action buttons + avatar
```

**Nav Link States:**
```
Default:   text-text-secondary
Hover:     text-text-primary
Active:    text-primary (with optional underline indicator)
```

**Sidebar (Dashboard):**
```
Container: w-64 h-screen bg-surface border-r border-border p-3
Nav Item:  flex items-center gap-3 px-3 h-10 rounded-md text-sm font-medium
Active:    bg-primary/10 text-primary
Hover:     bg-muted text-text-primary
```

**Bottom Tabs (Mobile):**
```
Container: fixed bottom-0 w-full h-16 bg-surface border-t border-border z-50
Tab Item:  flex flex-col items-center justify-center gap-1 flex-1
Icon:      w-6 h-6 (strokeWidth: active ? 2.5 : 1.5)
Label:     text-xs
Active:    text-primary
Inactive:  text-text-secondary
```

### Modal

```
Overlay:   fixed inset-0 bg-black/50 backdrop-blur-sm z-50
           animate-in fade-in duration-200
Container: fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2
           bg-surface rounded-xl shadow-xl max-w-md w-full max-h-[85vh] overflow-auto
           animate-in zoom-in-95 fade-in duration-200
```

**Structure:**
```
[Header: flex justify-between items-center p-5 border-b]
  [Title: text-lg font-semibold]
  [Close: icon button <X />]
[Body: p-5]
[Footer: flex justify-end gap-3 p-4 border-t]
  [Cancel: secondary button]
  [Confirm: primary button]
```

**Mobile:** Use bottom sheet instead:
```
Container: fixed bottom-0 left-0 right-0 bg-surface rounded-t-2xl max-h-[90vh]
           animate-in slide-in-from-bottom duration-300
```

### Dropdown

```
Menu:      bg-surface border border-border rounded-lg shadow-lg py-1 min-w-[200px]
Item:      flex items-center gap-2 px-3 py-2 text-sm cursor-pointer
Hover:     bg-muted
Selected:  bg-primary/10 text-primary (with <Check className="w-4 h-4 ml-auto" />)
Separator: h-px bg-border my-1 mx-2
```

### Toast

```
Container: fixed top-4 right-4 z-[200] flex flex-col gap-2
Item:      bg-surface border border-border rounded-lg shadow-lg 
           px-4 py-3 flex items-start gap-3 min-w-[320px] max-w-[400px]
           animate-in slide-in-from-right duration-300
```

**Variants:**
```
Success: border-l-[3px] border-l-success
Warning: border-l-[3px] border-l-warning
Error:   border-l-[3px] border-l-error
Info:    border-l-[3px] border-l-info
```

**Structure:**
```
[Icon: w-5 h-5, variant color]
[Content: flex-1]
  [Title: text-sm font-medium]
  [Message: text-xs text-text-secondary]
[Close: <X className="w-4 h-4" />]
```

Auto-dismiss after 5 seconds with progress bar animation.

### Empty State

```
Container: flex flex-col items-center justify-center text-center py-12 px-6
Icon:      w-16 h-16 text-text-secondary/50 mb-4 (use relevant Lucide icon)
Title:     text-lg font-semibold mb-2
Message:   text-sm text-text-secondary mb-6 max-w-[280px]
Action:    primary button (optional, to create/add content)
```

### Skeleton

```
Base:      bg-muted rounded-md relative overflow-hidden
Shimmer:   absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent
           animate-shimmer (background-position animation)
```

Common patterns:
```
Text line: h-4 rounded w-3/4 (or w-1/2, w-full)
Circle:    w-10 h-10 rounded-full
Card:      h-32 rounded-lg
Title:     h-5 rounded w-1/3
```

### Badge/Tag

**Status Badge:**
```
Container: inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium
Variants:
  Success: bg-success/10 text-success
  Warning: bg-warning/10 text-warning
  Error:   bg-error/10 text-error
  Info:    bg-info/10 text-info
  Neutral: bg-muted text-text-secondary
```

**Filter Tag:**
```
Default:   inline-flex items-center px-3 py-1.5 rounded-full text-sm font-medium
           border border-border text-text-secondary
Selected:  bg-primary text-white border-primary
Removable: gap-1 pr-2 (with <X className="w-3 h-3" /> on right)
```

## Responsive Breakpoints

| Breakpoint | Width | Layout Changes |
|------------|-------|----------------|
| Mobile | < 640px | Single column, bottom nav, full-width cards |
| Tablet | 640-1024px | 2-column grids, condensed sidebar |
| Desktop | > 1024px | Full layout, persistent sidebar, max-width containers |

### Responsive Patterns

**Container:**
```
w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8
```

**Grid:**
```
grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 lg:gap-6
```

**Navigation:**
```
Desktop: sidebar (w-64) + main content (flex-1)
Mobile: bottom tabs + hamburger menu drawer
```

## Animation Specifications

```css
/* Standard transition */
transition-all duration-200 ease-out

/* Hover lift */
transition-all duration-200 hover:-translate-y-0.5 hover:shadow-md

/* Modal/Overlay */
animate-in fade-in duration-200

/* Modal Content */
animate-in zoom-in-95 fade-in duration-200

/* Toast */
animate-in slide-in-from-right duration-300

/* Skeleton shimmer */
@keyframes shimmer {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(100%); }
}
```

## Dark Mode Implementation

Use Tailwind's `dark:` prefix or CSS variables:

```css
:root {
  --background: {light-bg};
  --surface: {light-surface};
  --text-primary: {light-text};
  --text-secondary: {light-text-secondary};
  --border: {light-border};
}

.dark {
  --background: {dark-bg};
  --surface: {dark-surface};
  --text-primary: {dark-text};
  --text-secondary: {dark-text-secondary};
  --border: {dark-border};
}
```

Or with Tailwind config:
```javascript
darkMode: 'class', // or 'media'
// Use dark: prefix on all color utilities
// bg-white dark:bg-slate-900
// text-gray-900 dark:text-slate-100
```

## Anti-Patterns Checklist

Before finishing, verify NONE of these exist:
- [ ] No emoji anywhere (especially not as icons)
- [ ] No pure black (#000) or pure white (#FFF)
- [ ] No arbitrary spacing values (must be multiples of 4)
- [ ] No missing hover/focus/disabled states
- [ ] No empty areas without empty state design
- [ ] No missing loading states
- [ ] No centered text walls (body text is left-aligned)
- [ ] No inconsistent border radius
- [ ] No shadows on everything
- [ ] No Lucide icons missing imports
