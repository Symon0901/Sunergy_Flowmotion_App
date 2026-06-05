# Design System Reference

Detailed reference for generating design tokens with consistent, professional results.

## Table of Contents
- [Color Generation Rules](#color-generation-rules)
- [Typography Scales](#typography-scales)
- [Spacing Scale](#spacing-scale)
- [Shadow Formulas](#shadow-formulas)
- [Border Radius Conventions](#border-radius-conventions)
- [Dark Mode Conversion](#dark-mode-conversion)

## Color Generation Rules

### Primary Color Selection by Mood

| Mood | Hue Range | Saturation | Lightness | Example |
|------|-----------|------------|-----------|---------|
| Professional/Enterprise | 210-225 | 60-75% | 45-55% | #2563EB |
| Energetic/Startup | 25-35 | 80-90% | 55-60% | #F59E0B |
| Creative/Playful | 260-280 | 70-80% | 55-65% | #8B5CF6 |
| Calm/Wellness | 170-180 | 50-65% | 40-50% | #0D9488 |
| Luxury/Premium | 340-350 | 60-70% | 45-50% | #BE185D |
| Natural/Organic | 140-150 | 45-60% | 35-45% | #15803D |

### Functional Colors (always use these)

| Purpose | Color | Hex | Tailwind Equivalent |
|---------|-------|-----|-------------------|
| Success | Green | #22C55E | green-500 |
| Warning | Amber | #F59E0B | amber-500 |
| Error | Red | #EF4444 | red-500 |
| Info | Blue | #3B82F6 | blue-500 |

### Neutral Gray Scale

| Token | Hex | Tailwind | Usage |
|-------|-----|----------|-------|
| Gray 50 | #F9FAFB | gray-50 | Lightest background |
| Gray 100 | #F3F4F6 | gray-100 | Hover backgrounds |
| Gray 200 | #E5E7EB | gray-200 | Borders, dividers |
| Gray 300 | #D1D5DB | gray-300 | Disabled borders |
| Gray 400 | #9CA3AF | gray-400 | Placeholder text |
| Gray 500 | #6B7280 | gray-500 | Secondary text |
| Gray 600 | #4B5563 | gray-600 | Body text (dark bg) |
| Gray 700 | #374151 | gray-700 | Headings (dark bg) |
| Gray 800 | #1F2937 | gray-800 | Dark surfaces |
| Gray 900 | #111827 | gray-900 | Deepest dark |

### Contrast Check
Text must have 4.5:1 contrast against its background. Quick check:
- Dark text (#1F2937) on white (#FFFFFF): ~15:1 ✓
- Gray text (#6B7280) on white: ~5.9:1 ✓
- Light text (#E5E7EB) on dark (#1F2937): ~10:1 ✓

## Typography Scales

### Modern Sans-Serif Font Stacks

**English + International:**
```css
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
```

**With Chinese Support:**
```css
font-family: 'Inter', 'PingFang SC', 'Microsoft YaHei', 'Noto Sans SC', sans-serif;
```

### Type Scale (px-based)

| Token | Size | Weight | Line-Height | Letter-Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| Display | 40px | 700 | 1.1 | -0.02em | Hero headlines |
| H1 | 30px | 600 | 1.2 | -0.01em | Page titles |
| H2 | 22px | 600 | 1.3 | 0 | Section headers |
| H3 | 17px | 600 | 1.4 | 0 | Card titles |
| Body | 15px | 400 | 1.65 | 0 | Paragraphs |
| Body Small | 13px | 400 | 1.5 | 0 | Descriptions |
| Caption | 12px | 400 | 1.4 | 0.01em | Metadata |
| Overline | 11px | 500 | 1.2 | 0.06em | Labels, badges |

### Type Scale (rem-based, tailwind-friendly)

| Token | Size | Weight | Line-Height | Tailwind Classes |
|-------|------|--------|-------------|-----------------|
| Display | 2.5rem | font-bold | leading-tight | text-4xl font-bold |
| H1 | 1.875rem | font-semibold | leading-snug | text-3xl font-semibold |
| H2 | 1.375rem | font-semibold | leading-snug | text-xl font-semibold |
| H3 | 1.0625rem | font-semibold | leading-normal | text-base font-semibold |
| Body | 0.9375rem | font-normal | leading-relaxed | text-sm leading-relaxed |
| Body Small | 0.8125rem | font-normal | leading-normal | text-xs |
| Caption | 0.75rem | font-normal | leading-normal | text-xs |

## Spacing Scale

Base unit: 4px. All spacing values are multiples.

| Token | Value | Tailwind | Common Usage |
|-------|-------|----------|-------------|
| space-1 | 4px | p-1 / m-1 | Tight internal padding |
| space-2 | 8px | p-2 / m-2 | Icon gaps, small padding |
| space-3 | 12px | p-3 / m-3 | Button padding (small) |
| space-4 | 16px | p-4 / m-4 | Card padding, standard gap |
| space-5 | 20px | p-5 / m-5 | Button padding (default) |
| space-6 | 24px | p-6 / m-6 | Section gaps |
| space-8 | 32px | p-8 / m-8 | Card groups, large gaps |
| space-10 | 40px | p-10 / m-10 | Section padding |
| space-12 | 48px | p-12 / m-12 | Major section separators |
| space-16 | 64px | p-16 / m-16 | Page-level padding |

## Shadow Formulas

### Layered Shadows (Modern Approach)
Instead of a single shadow, use two layered shadows for realism:

```css
/* Subtle elevation — cards, inputs */
shadow-sm: 0 1px 2px 0 rgba(0,0,0,0.04), 0 1px 3px 0 rgba(0,0,0,0.04);

/* Default — buttons, dropdowns */
shadow-md: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -2px rgba(0,0,0,0.05);

/* Prominent — modals, popovers */
shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.08), 0 4px 6px -4px rgba(0,0,0,0.04);

/* Floating — FAB, toasts */
shadow-xl: 0 20px 25px -5px rgba(0,0,0,0.08), 0 8px 10px -6px rgba(0,0,0,0.03);
```

### Colored Shadows (For Primary Actions)
Add a subtle colored glow to primary buttons/CTAs:
```css
box-shadow: 0 4px 14px 0 rgba(37, 99, 235, 0.39); /* primary color glow */
```

## Border Radius Conventions

| Token | Value | Usage |
|-------|-------|-------|
| radius-sm | 4px | Inputs, small buttons, badges |
| radius-md | 8px | Cards, panels, default buttons |
| radius-lg | 12px | Modals, large cards |
| radius-xl | 16px | Feature cards, hero containers |
| radius-2xl | 24px | Mobile bottom sheets |
| radius-full | 9999px | Avatars, pills, chips |

## Dark Mode Conversion

When generating dark mode variants, apply these transformations:

| Light Token | Dark Token | Rule |
|-------------|-----------|------|
| Background (#FFFFFF) | Background (#0F172A) | Invert to dark slate |
| Surface (#F9FAFB) | Surface (#1E293B) | Slightly lighter than bg |
| Text Primary (#111827) | Text Primary (#F1F5F9) | Light gray, not pure white |
| Text Secondary (#6B7280) | Text Secondary (#94A3B8) | Medium-light gray |
| Border (#E5E7EB) | Border (#334155) | Muted visible border |
| Primary (keep same hue) | Primary (lighten 10%) | Adjust lightness for visibility |

### Dark Mode Shadow Adjustment
In dark mode, shadows become less visible. Compensate by:
- Increasing shadow opacity by 50-100%
- Adding a subtle border (`border: 1px solid #334155`) to define edges
- Using lighter shadow colors (`rgba(0,0,0,0.3)` instead of `rgba(0,0,0,0.1)`)

## Icon Size Standards

| Context | Size | Tailwind | Notes |
|---------|------|----------|-------|
| Inline with text | 16px | w-4 h-4 | Aligned with text baseline |
| Button icon | 18-20px | w-5 h-5 | Slightly larger than text |
| Navigation | 24px | w-6 h-6 | Standard nav icon size |
| Feature/Empty | 32-48px | w-8 h-8 to w-12 h-12 | Decorative, can be colored |
| Avatar placeholder | 40px | w-10 h-10 | User icon fallback |

Always use consistent stroke-width: 1.5px or 2px throughout the app.
