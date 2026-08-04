---
name: Vault Logic
colors:
  surface: '#071327'
  surface-dim: '#071327'
  surface-bright: '#2e394f'
  surface-container-lowest: '#030e22'
  surface-container-low: '#101b30'
  surface-container: '#142034'
  surface-container-high: '#1f2a3f'
  surface-container-highest: '#2a354b'
  on-surface: '#d7e2ff'
  on-surface-variant: '#c4c6cc'
  inverse-surface: '#d7e2ff'
  inverse-on-surface: '#263046'
  outline: '#8e9196'
  outline-variant: '#44474c'
  surface-tint: '#bac8dc'
  primary: '#bac8dc'
  on-primary: '#243141'
  primary-container: '#0d1b2a'
  on-primary-container: '#768497'
  inverse-primary: '#525f71'
  secondary: '#afc9ea'
  on-secondary: '#17324d'
  secondary-container: '#2f4865'
  on-secondary-container: '#9eb7d8'
  tertiary: '#95d4b3'
  on-tertiary: '#003824'
  tertiary-container: '#001f12'
  on-tertiary-container: '#528f71'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d6e4f9'
  primary-fixed-dim: '#bac8dc'
  on-primary-fixed: '#0f1c2c'
  on-primary-fixed-variant: '#3a4859'
  secondary-fixed: '#d1e4ff'
  secondary-fixed-dim: '#afc9ea'
  on-secondary-fixed: '#001d36'
  on-secondary-fixed-variant: '#2f4865'
  tertiary-fixed: '#b1f0ce'
  tertiary-fixed-dim: '#95d4b3'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#0e5138'
  background: '#071327'
  on-background: '#d7e2ff'
  surface-variant: '#2a354b'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  margin-mobile: 20px
  gutter: 16px
---

## Brand & Style

The design system is engineered for a high-security environment, blending the precision of a modern password manager with the refined elegance of a premium fintech application. The brand personality is anchored in **discretion, authority, and tranquility**.

The aesthetic follows a **Modern-Minimalist** approach with **Glassmorphic** accents. It prioritizes clarity and focus, using generous whitespace to reduce cognitive load while employing subtle light-refraction effects to denote security layers. The visual language utilizes shield and lock motifs not as aggressive barriers, but as quiet, sophisticated markers of safety. Every interaction must feel intentional and grounded, evoking an emotional response of absolute digital safety.

## Colors

The palette is built on a foundation of deep, layered blues to establish immediate trust. 

- **Primary & Neutral:** The "Deep Navy" (#0D1B2A) serves as the primary canvas in dark mode, providing a high-end, obsidian-like depth. "Charcoal" (#1B263B) is used for secondary surfaces and containers to create a hierarchical "lift."
- **Accent:** The "Emerald" (#2D6A4F for light, #52B788 for dark) is used sparingly for "Safe" states, primary actions, and biometric confirmation indicators.
- **Secondary:** "Blue Accent" (#415A77) provides a softer alternative for interactive elements that are not primary calls to action.

In Light Mode, the system flips to a pristine White (#FFFFFF) background with the Navy reserved for typography and iconography to maintain the authoritative tone.

## Typography

This design system utilizes **Inter** exclusively to achieve a systematic, utilitarian, and clean look. The typographic hierarchy is aggressive, with large, bold headlines that provide clear orientation within the app.

- **Display & Headlines:** Use tight letter-spacing (-0.01em to -0.02em) to create a compact, premium "editorial" feel.
- **Body Text:** Optimized for legibility with standard tracking. 
- **Labels:** Small caps or increased tracking (0.05em) are encouraged for metadata and secondary headers to distinguish them from actionable body text.
- **Scaling:** On mobile devices, use the `headline-lg-mobile` variant to ensure long contact names do not wrap excessively.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** with a strict 8px rhythmic baseline. 

- **Safe Zones:** A standard 20px margin is maintained on both sides of the mobile screen to avoid edge-bleeding and improve thumb ergonomics.
- **Component Spacing:** Elements within a card (e.g., contact photo to name) should use `sm` (12px), while spacing between separate cards should use `md` (16px).
- **Vertical Rhythm:** Use `xl` (32px) to separate major sections, such as "Recent Contacts" and "All Contacts."
- **Touch Targets:** All interactive elements must maintain a minimum hit area of 48x48px, regardless of their visual size.

## Elevation & Depth

This design system utilizes **Tonal Layering** combined with **Glassmorphism** for its hierarchy.

- **Level 0 (Base):** The primary background color.
- **Level 1 (Surface):** Used for cards and list items. In dark mode, this is a slightly lighter navy with a 1px inner stroke (opacity 10%) to simulate a beveled edge.
- **Level 2 (Float):** Used for Floating Action Buttons (FABs) and Modals. These utilize a soft, ultra-diffused shadow: `Offset(0, 8), Blur(24), Color(Navy, 0.4)`.
- **Glassmorphism:** Bottom navigation bars and top app bars should use a backdrop filter (Blur: 20px) with a semi-transparent fill (80% surface color) to maintain context of the content scrolling beneath them. This represents a "secure overlay" state.

## Shapes

The shape language is "Rounded" to convey friendliness within a secure context. 

- **Standard Containers:** Cards, input fields, and buttons utilize a **16px** (rounded-lg) radius.
- **Large Containers:** Bottom sheets and prominent feature cards use **24px** (rounded-xl).
- **Icons:** Should follow a "Duotone" or "Soft Line" style with rounded terminals to match the UI's geometry. Avoid sharp 90-degree corners on any internal graphical elements.

## Components

- **Buttons:** 
  - *Primary:* Emerald fill, white text, 16px radius. No shadow; use a subtle inner-glow for depth.
  - *Secondary:* Ghost style with a 1px border of `Blue Accent` and high-transparency fill.
- **Input Fields:** Filled style using the `Surface` color. The active state is indicated by a 2px Emerald bottom-border or glow. Labels should float to `label-sm` on focus.
- **Cards (Contact Items):** Utilize a horizontal layout with a circular avatar (56px). Include a "Lock" icon badge on the avatar to reinforce the privacy narrative.
- **Chips:** Used for "Tags" or "Groups". Pill-shaped (32px radius), low-contrast background, `body-md` typography.
- **Checkboxes/Radios:** Custom Emerald-filled states. When "Checked," the element should have a slight "squishy" animation to feel tactile.
- **Biometric Prompt:** A custom full-screen overlay using the Glassmorphism blur (20px) with a centered Emerald shield icon, signifying a transition into the "Secure Vault."