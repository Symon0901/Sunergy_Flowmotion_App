# {Project Name} — Design System

## Color Palette

### Primary Colors
| Token | Hex | Tailwind | Usage |
|-------|-----|----------|-------|
| Primary | {hex} | {class} | Buttons, links, active states |
| Primary Light | {hex} | {class} | Hover states |
| Primary Dark | {hex} | {class} | Pressed states |

### Neutral Colors
| Token | Hex | Tailwind | Usage |
|-------|-----|----------|-------|
| Background | {hex} | {class} | Page background |
| Surface | {hex} | {class} | Cards, panels |
| Text Primary | {hex} | {class} | Headings, body text |
| Text Secondary | {hex} | {class} | Captions, metadata |
| Border | {hex} | {class} | Dividers, input borders |

### Functional Colors
| Token | Hex | Tailwind | Usage |
|-------|-----|----------|-------|
| Success | #22C55E | green-500 | Success states |
| Warning | #F59E0B | amber-500 | Warning states |
| Error | #EF4444 | red-500 | Error states |
| Info | #3B82F6 | blue-500 | Info states |

### Dark Mode Variants
| Token | Light | Dark |
|-------|-------|------|
| Background | {light-hex} | {dark-hex} |
| Surface | {light-hex} | {dark-hex} |
| Text Primary | {light-hex} | {dark-hex} |
| Text Secondary | {light-hex} | {dark-hex} |
| Border | {light-hex} | {dark-hex} |

## Typography

### Font Family
```css
font-family: {font-stack};
```

### Type Scale
| Token | Size | Weight | Line-Height | Tailwind |
|-------|------|--------|-------------|----------|
| Display | {size} | {weight} | {lh} | {class} |
| H1 | {size} | {weight} | {lh} | {class} |
| H2 | {size} | {weight} | {lh} | {class} |
| H3 | {size} | {weight} | {lh} | {class} |
| Body | {size} | {weight} | {lh} | {class} |
| Caption | {size} | {weight} | {lh} | {class} |
| Overline | {size} | {weight} | {lh} | {class} |

## Spacing System

Base unit: 4px

| Token | Value | Tailwind |
|-------|-------|----------|
| space-1 | 4px | p-1 / m-1 / gap-1 |
| space-2 | 8px | p-2 / m-2 / gap-2 |
| space-3 | 12px | p-3 / m-3 / gap-3 |
| space-4 | 16px | p-4 / m-4 / gap-4 |
| space-5 | 20px | p-5 / m-5 / gap-5 |
| space-6 | 24px | p-6 / m-6 / gap-6 |
| space-8 | 32px | p-8 / m-8 / gap-8 |
| space-10 | 40px | p-10 / m-10 / gap-10 |
| space-12 | 48px | p-12 / m-12 / gap-12 |

## Shadow & Elevation

| Level | Shadow | Tailwind | Usage |
|-------|--------|----------|-------|
| 1 | {shadow} | shadow-sm | Cards, inputs |
| 2 | {shadow} | shadow-md | Dropdowns, popovers |
| 3 | {shadow} | shadow-lg | Modals |
| Glow | {shadow} | — | Primary button glow |

## Border Radius

| Token | Value | Tailwind | Usage |
|-------|-------|----------|-------|
| radius-sm | 4px | rounded | Inputs, badges |
| radius-md | 8px | rounded-lg | Buttons, cards |
| radius-lg | 12px | rounded-xl | Modals, panels |
| radius-full | 9999px | rounded-full | Avatars, pills |

## Icon Strategy

- **Library**: Lucide React (`lucide-react`)
- **Default size**: 20px (w-5 h-5)
- **Navigation size**: 24px (w-6 h-6)
- **Stroke width**: {1.5 or 2}px
- **Icon color**: Inherits from text color

### Common Icon Mapping
| Purpose | Icon Name | Import |
|---------|-----------|--------|
| Dashboard | LayoutDashboard | `import { LayoutDashboard } from 'lucide-react'` |
| Settings | Settings | `import { Settings } from 'lucide-react'` |
| User | User | `import { User } from 'lucide-react'` |
| Search | Search | `import { Search } from 'lucide-react'` |
| Close | X | `import { X } from 'lucide-react'` |
| Add | Plus | `import { Plus } from 'lucide-react'` |
| Delete | Trash2 | `import { Trash2 } from 'lucide-react'` |
| Edit | Pencil | `import { Pencil } from 'lucide-react'` |
| Check | Check | `import { Check } from 'lucide-react'` |
| ChevronDown | ChevronDown | `import { ChevronDown } from 'lucide-react'` |
| Bell | Bell | `import { Bell } from 'lucide-react'` |
| Menu | Menu | `import { Menu } from 'lucide-react'` |
