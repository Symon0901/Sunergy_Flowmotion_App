---
name: app-designer
description: "Generate comprehensive design systems and implementation-ready UI specifications for web/mobile applications. Use when the user needs to design an app interface, create a design system, generate UI/UX specifications, or produce design prompts for vibe coding. Triggers on requests involving: app UI design, interface design system, component design specs, visual design guidelines, design tokens, color palette definition, typography system, spacing system, icon strategy, or producing design-ready prompts for AI coders."
---

# App Designer

Generate professional-grade design systems and implementation-ready UI specifications that eliminate guesswork from vibe coding.

## Overview

This skill bridges the gap between "ugly AI-generated UI" and "polished professional interfaces" by systematically defining every visual aspect of an application before code is written. It produces a complete design specification that any AI coder can implement with precision.

## Workflow

Designing an app interface involves these steps:

1. Gather context (product type, audience, mood)
2. Generate design system (colors, typography, spacing, icons)
3. Define component specifications (buttons, cards, inputs, navigation)
4. Specify interaction states (hover, active, disabled, loading)
5. Create layout architecture (responsive breakpoints, grid)
6. Produce implementation prompt (design-ready spec for AI coder)

## Step 1: Gather Context

Collect from user (or infer from conversation):

- **Product type**: Dashboard, social app, e-commerce, tool/utility, content site, landing page
- **Target audience**: Technical users, general consumers, professionals, creatives
- **Mood/personality**: Playful, serious, minimalist, luxurious, energetic, calm
- **Platform**: Web app, mobile app, desktop app, responsive
- **Reference**: Any screenshots, brand colors, or existing design references

If the user does not specify, make reasonable defaults and state them explicitly.

## Step 2: Generate Design System

Read `references/design-system-reference.md` for detailed token definitions.

Generate these tokens with specific values:

### Color Palette
Define 7-10 semantic colors with hex values:
- **Primary**: Main brand color (buttons, active states, key actions)
- **Primary Light/Dark**: Variants for hover and pressed states
- **Secondary**: Supporting accent (tags, secondary buttons, highlights)
- **Background**: Page background
- **Surface**: Cards, modals, elevated containers
- **Text Primary**: Main body text
- **Text Secondary**: Captions, metadata, placeholders
- **Border**: Dividers, input borders
- **Success/Warning/Error**: Functional feedback colors (optional but recommended)

Rules:
- Use modern, slightly desaturated tones (avoid pure #FF0000 red, use #EF4444)
- Ensure 4.5:1 contrast ratio minimum for text
- Dark mode variants required (invert backgrounds, adjust text)

### Typography
Define a type scale with specific font family, sizes, weights, and line heights:
- **Display**: 36-48px, bold, 1.1 line-height (hero headlines)
- **H1**: 28-32px, semibold, 1.2 line-height (page titles)
- **H2**: 20-24px, semibold, 1.3 line-height (section headers)
- **H3**: 16-18px, medium, 1.4 line-height (card titles, subsections)
- **Body**: 14-16px, regular, 1.5-1.75 line-height (paragraphs, descriptions)
- **Caption**: 12-13px, regular, 1.4 line-height (metadata, timestamps)
- **Overline**: 11-12px, medium, uppercase, 1.2 line-height (labels, badges)

Rules:
- Prefer system font stack or modern geometric sans-serif (Inter, SF Pro, DM Sans)
- Maximum 2 font families (one for headings, one for body, or same for both)
- Chinese content: use "PingFang SC", "Microsoft YaHei", "Noto Sans SC" fallbacks

### Spacing System
Use 4px base unit. Define scale:
- xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, 2xl: 48px, 3xl: 64px
- Apply consistently: component padding, gaps between elements, section margins

### Shadow & Elevation
Define 3 shadow levels:
- **Level 1 (subtle)**: `0 1px 3px rgba(0,0,0,0.08)` — cards, containers
- **Level 2 (medium)**: `0 4px 12px rgba(0,0,0,0.12)` — dropdowns, popovers
- **Level 3 (pronounced)**: `0 8px 24px rgba(0,0,0,0.16)` — modals, floating elements

### Border Radius
Define component-specific radii:
- **Small (4-6px)**: Buttons, inputs, badges
- **Medium (8-12px)**: Cards, panels
- **Large (16-24px)**: Modals, containers
- **Pill (999px)**: Tags, chips, pill buttons

### Icon Strategy
MANDATORY: Never use emoji as icons. Specify:
- **Icon library**: Lucide React (default), or Tabler Icons, Heroicons
- **Icon sizing**: 16px (inline), 20px (buttons), 24px (navigation), 32px (feature icons)
- **Stroke width**: 1.5px or 2px (consistent across app)

## Step 3: Define Component Specifications

Read `references/component-patterns.md` for detailed component specs.

For each core component, specify:
1. **Visual properties**: Colors, typography, spacing, shadows, radius
2. **Size variants**: Small / Default / Large
3. **All states**: Default, Hover, Active/Pressed, Focus, Disabled, Loading
4. **Transition**: Duration (usually 150-200ms) and easing (ease-out)

### Required Components

Define these at minimum:
- **Button** (Primary, Secondary, Ghost, Danger)
- **Input** (Text, Password, Search, Textarea)
- **Card** (Content card, stat card, list item)
- **Navigation** (Top bar, sidebar, bottom tabs, breadcrumbs)
- **Modal/Dialog** (Overlay, container, header, body, footer)
- **Dropdown/Select** (Trigger, menu, item, group)
- **Toast/Notification** (Success, warning, error, info variants)
- **Empty State** (Illustration area, title, description, action)
- **Skeleton** (Loading placeholder with shimmer animation)
- **Badge/Tag** (Status indicators, labels, filters)

## Step 4: Specify Interaction States

Every interactive element MUST have these states defined:

| State | Visual Treatment | Transition |
|-------|-----------------|------------|
| Default | Base styling | — |
| Hover | Slight background change or elevation increase | 150ms ease |
| Active/Pressed | Scale to 0.97 or darker shade | 100ms ease |
| Focus | 2px ring in primary color with 2px offset | 150ms ease |
| Disabled | Opacity 0.4, no pointer events | — |
| Loading | Spinner inside element, reduced opacity | — |

## Step 5: Layout Architecture

### Responsive Breakpoints
Define mobile-first breakpoints:
- **Mobile**: < 640px (single column, stacked layout)
- **Tablet**: 640-1024px (2-column grids, condensed nav)
- **Desktop**: > 1024px (full layout, sidebar visible)

### Grid System
- Use 12-column grid on desktop, 4-column on mobile
- Standard gutter: 16px (mobile), 24px (desktop)
- Max content width: 1280px (dashboard), 768px (content), 100% (full-bleed)

### Navigation Patterns by Product Type
- **Dashboard**: Collapsible sidebar + top header bar
- **Social/Mobile**: Bottom tab bar with 3-5 items
- **E-commerce**: Top nav with categories + search bar
- **Tool/Utility**: Command palette (Cmd+K) + sidebar
- **Landing**: Single page, anchor links, sticky CTA

## Step 6: Produce Implementation Prompt

Read `assets/vibe-prompt-template.md` for the final prompt template.

Combine all specifications into a structured prompt document containing:
1. Design system summary (colors, typography, spacing as code-ready tokens)
2. Component specifications with state definitions
3. Layout rules and responsive behavior
4. Asset requirements (icon library, illustration style)
5. Anti-patterns checklist (what NOT to do)

Save this prompt to a file that the user can feed directly to their AI coder.

## Common Mistakes to Avoid

- **Never use emoji as icons** — always specify Lucide or equivalent
- **Never hardcode arbitrary values** — everything comes from the design system
- **Never skip disabled/loading states** — they are required for production
- **Never use pure black (#000) or pure white (#FFF)** — use slightly off-shades
- **Never forget empty states** — every list, search, and data view needs one
- **Never use inconsistent spacing** — stick to the 4px grid
- **Never forget focus states** — accessibility and keyboard navigation require them

## Output Files

Save all deliverables to a design directory:

```
design-output/
├── design-system.md       (complete token definitions)
├── component-specs.md     (all components with states)
├── layout-specs.md        (responsive rules, grid, nav)
└── implementation-prompt.md (ready for AI coder)
```
