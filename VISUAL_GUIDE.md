# Visual Design Guide - RIFT Dashboard

## 🎨 Design System Overview

### Color System

```
Primary Palette
├── Primary:       oklch(0.48 0.20 260)  [Vibrant Blue]
├── Danger:        oklch(0.58 0.22 25)   [Alert Red]
├── Warning:       oklch(0.70 0.16 70)   [Caution Yellow]
├── Success:       oklch(0.55 0.14 160)  [Success Green]
├── Forensic Ring: oklch(0.55 0.18 310)  [Detection Purple]
└── Info:          oklch(0.55 0.18 220)  [Info Blue]

Neutral Palette
├── Background:    oklch(0.99 0.002 260) [Near White]
├── Foreground:    oklch(0.12 0.01 260)  [Near Black]
├── Muted:         oklch(0.48 0.01 260)  [Gray Text]
└── Border:        oklch(0.92 0.005 260) [Light Gray]
```

### Typography Scale

```
Display:  text-7xl (72px)  - Hero headlines
Heading:  text-5xl (48px)  - Section titles
Title:    text-3xl (30px)  - Card titles
Body:     text-lg  (18px)  - Main content
Small:    text-sm  (14px)  - Secondary text
Tiny:     text-xs  (12px)  - Labels, captions
```

### Spacing Scale

```
xs:  0.25rem (4px)
sm:  0.5rem  (8px)
md:  1rem    (16px)
lg:  1.5rem  (24px)
xl:  2rem    (32px)
2xl: 3rem    (48px)
```

### Border Radius

```
sm:  0.5rem   (8px)
md:  0.625rem (10px)
lg:  0.75rem  (12px)
xl:  1rem     (16px)
2xl: 1.5rem   (24px)
```

---

## 🏠 Landing Page Components

### Hero Section

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  [🌟 RIFT 2026 Hackathon Winner]  ← Animated badge    │
│                                                         │
│         Detect Financial Fraud with                     │
│         [Graph Intelligence] ← Gradient text            │
│                                                         │
│  Uncover money muling rings, suspicious patterns...    │
│                                                         │
│  ✓ Real-time Analysis  ✓ Graph Viz  ✓ 99.2% Accuracy │
│                                                         │
│  [Get Started Free →]  [See How It Works]              │
│                                                         │
│  ┌──────┬──────┬──────┬──────┐                        │
│  │ 📊   │ ⚡   │ 🎯   │ 🔍   │  ← Stats with emojis   │
│  │ 1M+  │ <3s  │99.2% │ 50+  │                        │
│  └──────┴──────┴──────┴──────┘                        │
└─────────────────────────────────────────────────────────┘
```

**Key Features**:
- Multi-layer gradient background
- Animated floating badge with glow
- Gradient text effect on "Graph Intelligence"
- Feature checkmarks with icons
- Enhanced CTA buttons with shadows
- Stats bar with emojis and glass effect

---

### Features Section

```
┌─────────────────────────────────────────────────────────┐
│                    [CAPABILITIES]                       │
│                                                         │
│     Everything You Need for Financial Forensics        │
│                                                         │
│  ┌──────────┬──────────┬──────────┬──────────┐        │
│  │ [📤]     │ [🕸️]     │ [🔍]     │ [🛡️]     │        │
│  │ Instant  │Interactive│ Smart    │ AI       │        │
│  │ Upload   │ Graph    │ Detection│ Scoring  │        │
│  │          │          │          │          │        │
│  │ Drag...  │ Explore..│ Auto...  │ ML...    │        │
│  └──────────┴──────────┴──────────┴──────────┘        │
│  ┌──────────┬──────────┬──────────┬──────────┐        │
│  │ [📊]     │ [🔔]     │ [⚡]     │ [🔒]     │        │
│  │ Real-time│ Pattern  │Lightning │ Secure   │        │
│  │Dashboard │ Alerts   │ Fast     │ Private  │        │
│  └──────────┴──────────┴──────────┴──────────┘        │
└─────────────────────────────────────────────────────────┘
```

**Key Features**:
- 8 feature cards in 4-column grid
- Gradient icon backgrounds (unique per feature)
- Background gradient orbs for depth
- Hover effects with gradient overlays
- Staggered animations

---

## 📊 Dashboard Components

### Header (Sticky)

```
┌─────────────────────────────────────────────────────────┐
│ [←] │ [🛡️] RIFT Dashboard          [JSON] [CSV] [@user]│
│     │     Financial Forensics                    [Exit] │
└─────────────────────────────────────────────────────────┘
```

**Key Features**:
- Sticky positioning with backdrop blur
- Glass morphism effect
- Gradient logo with shadow
- Enhanced user info card
- Export buttons with shadows

---

### Tab Navigation

```
┌─────────────────────────────────────────────────────────┐
│  [📊 My Dashboard]  [🔍 Analyze]                       │
│  ═══════════════                                        │
└─────────────────────────────────────────────────────────┘
```

**Key Features**:
- Gradient underline for active tab
- Icon scale on hover
- Backdrop blur on tab bar
- Smooth transitions

---

### User Stats Cards

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│ [📄]         │ [⚠️]         │ [⭕]         │ [⏱️]         │
│ Total        │ Suspicious   │ Fraud        │ Avg          │
│ Analyses     │ Accounts     │ Rings        │ Time         │
│              │              │              │              │
│ 1,234        │ 567          │ 89           │ 2,345ms      │
└──────────────┴──────────────┴──────────────┴──────────────┘
```

**Key Features**:
- Larger cards with more padding
- Gradient overlay on hover
- Icon scale animation
- Better number formatting
- Enhanced shadows

---

### Welcome Banner

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  Welcome back! 👋                                       │
│                                                         │
│  Here's an overview of your fraud detection activity.  │
│  You've analyzed 1,234 datasets and detected 89 fraud  │
│  rings.                                                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Key Features**:
- Gradient background (primary → forensic-ring)
- Personalized greeting
- Dynamic stats in text
- Rounded corners

---

### Quick Insights

```
┌──────────────┬──────────────┬──────────────┐
│ [📊]         │ [🎯]         │ [⏱️]         │
│ Suspicious   │ Rings per    │ Processing   │
│ Rate         │ Analysis     │ Speed        │
│              │              │              │
│ 12.5%        │ 3.2          │ 2.3s         │
│ Average...   │ Average...   │ Average...   │
└──────────────┴──────────────┴──────────────┘
```

**Key Features**:
- Calculated metrics from history
- Icon integration
- Clean card design
- Helpful descriptions

---

## 🎭 Animation Patterns

### Fade-in Sequence

```
Element          Delay    Duration
─────────────────────────────────
Badge            0ms      600ms
Headline         0ms      600ms
Subtitle         100ms    600ms
Features         200ms    600ms
CTAs             300ms    600ms
Stats            400ms    600ms
```

### Hover Effects

```
Component        Transform           Shadow
──────────────────────────────────────────────
Button           scale(1.02)         lg → xl
Card             none                sm → md
Icon             scale(1.1)          none
Stats Card       none                sm → md
Feature Card     none                none → xl
```

### Transition Timing

```
Property         Duration    Easing
────────────────────────────────────
Color            200ms       ease-out
Transform        300ms       ease-out
Shadow           200ms       ease-out
Opacity          200ms       ease-in-out
Background       200ms       ease-out
```

---

## 🎨 Gradient Recipes

### Gradient Text

```css
.gradient-text {
  background: linear-gradient(
    to right,
    var(--primary),
    var(--forensic-ring),
    var(--primary)
  );
  background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

### Gradient Border

```css
.gradient-border {
  background: 
    linear-gradient(var(--card), var(--card)) padding-box,
    linear-gradient(135deg, var(--primary), var(--forensic-ring)) border-box;
  border: 2px solid transparent;
}
```

### Glass Effect

```css
.glass {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
}
```

---

## 📐 Layout Patterns

### Card Layout

```
┌─────────────────────────────────┐
│ [Icon]  Title                   │ ← Header (p-6)
├─────────────────────────────────┤
│                                 │
│ Content area                    │ ← Content (p-6)
│                                 │
└─────────────────────────────────┘
```

### Grid Layouts

```
Mobile (< 640px):   1 column
Tablet (640-1024):  2 columns
Desktop (> 1024):   4 columns
```

### Spacing System

```
Section padding:    py-24 (96px)
Card padding:       p-6 (24px)
Button padding:     px-8 py-6 (32px 24px)
Gap between cards:  gap-6 (24px)
```

---

## 🎯 Component States

### Button States

```
State      Background    Border      Shadow      Transform
─────────────────────────────────────────────────────────
Default    primary       none        lg          none
Hover      primary       none        xl          scale(1.02)
Active     primary/90    none        md          scale(0.98)
Disabled   muted         none        none        none
```

### Card States

```
State      Background    Border      Shadow      Overlay
──────────────────────────────────────────────────────
Default    card          border      sm          none
Hover      card          border      md          gradient
Active     card          primary     md          gradient
```

### Input States

```
State      Background    Border      Ring        Text
────────────────────────────────────────────────────
Default    input         border      none        foreground
Focus      input         primary     ring        foreground
Error      input         danger      danger      foreground
Disabled   muted         border      none        muted
```

---

## 🔍 Icon Usage

### Icon Sizes

```
Context          Size    Pixels
─────────────────────────────
Button           4       16px
Card header      5       20px
Stats card       6       24px
Feature card     6       24px
Hero badge       3.5     14px
```

### Icon Colors

```
Context          Color
──────────────────────────
Primary action   primary
Danger action    danger
Success state    success
Info state       info
Muted text       muted-foreground
```

---

## 📱 Responsive Breakpoints

```
Breakpoint    Width     Columns    Padding
────────────────────────────────────────────
xs            < 640px   1          px-4
sm            640px     2          px-4
md            768px     2          px-6
lg            1024px    4          px-6
xl            1280px    4          px-6
2xl           1536px    4          px-6
```

---

## ✨ Special Effects

### Glow Effect

```css
.glow {
  box-shadow: 0 0 20px rgba(var(--primary-rgb), 0.3);
}
```

### Pulse Animation

```css
.pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}
```

### Gradient Animation

```css
.gradient-animate {
  background-size: 200% 200%;
  animation: gradient 3s ease infinite;
}
```

---

## 🎨 Usage Examples

### Primary Button

```tsx
<Button 
  size="lg" 
  className="gap-2 rounded-full px-8 py-6 shadow-lg shadow-primary/25"
>
  Get Started
  <ArrowRight className="size-4" />
</Button>
```

### Stats Card

```tsx
<Card className="group hover:shadow-xl transition-all">
  <CardContent className="p-6">
    <div className="flex items-center gap-4">
      <div className="size-12 rounded-xl bg-primary/10">
        <Icon className="size-6 text-primary" />
      </div>
      <div>
        <p className="text-xs text-muted-foreground">Label</p>
        <p className="text-3xl font-bold">1,234</p>
      </div>
    </div>
  </CardContent>
</Card>
```

### Gradient Text

```tsx
<h1 className="text-7xl font-bold">
  Detect Fraud with{' '}
  <span className="gradient-text">
    Graph Intelligence
  </span>
</h1>
```

---

## 🎯 Best Practices

### Do's ✅
- Use consistent spacing (4px grid)
- Apply hover states to interactive elements
- Use semantic colors (danger for errors, success for confirmations)
- Maintain contrast ratios (WCAG AA minimum)
- Add loading states for async actions
- Use icons to reinforce meaning
- Apply smooth transitions (200-300ms)

### Don'ts ❌
- Don't use too many colors (stick to palette)
- Don't animate everything (be selective)
- Don't use tiny text (minimum 12px)
- Don't forget focus states
- Don't use low contrast colors
- Don't overuse gradients
- Don't make clickable areas too small

---

## 📊 Accessibility Checklist

- [ ] Color contrast meets WCAG AA (4.5:1 for text)
- [ ] Focus indicators visible on all interactive elements
- [ ] Keyboard navigation works throughout
- [ ] ARIA labels on icon-only buttons
- [ ] Alt text on all images
- [ ] Semantic HTML structure
- [ ] Form inputs have labels
- [ ] Error messages are clear and helpful

---

This visual guide ensures consistent, professional design across the entire RIFT dashboard application.
