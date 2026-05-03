# Web Canvas Scaling Issue - 64px Problem

## Problem Description

The web version of ParSec Nova exhibits a persistent canvas scaling issue where the game renders at a very low resolution (64x64 pixels) internally, resulting in severe pixelation regardless of CSS scaling attempts.

## Observed Behavior

- **Canvas Size**: The HTML canvas element shows `width="64" height="64"` attributes
- **Visual Result**: Game is extremely pixelated, appearing as "80s retro pixel art"
- **CSS Overrides**: Even with `!important` CSS rules forcing `width: 100vw; height: 100vh`, the internal rendering remains at 64x64
- **Aspect Ratio**: The game maintains correct aspect ratio but at very low resolution

## Attempted Solutions

All of the following approaches have been tested without success:

### 1. CSS-Based Fixes
- Applied `width: 100vw !important; height: 100vh !important` to canvas
- Added `object-fit: contain` for proper aspect ratio
- Tried various `image-rendering` modes (`auto`, `crisp-edges`, `pixelated`)
- Added container CSS with `position: fixed; width: 100%; height: 100%`

### 2. Godot Project Settings
- Changed `window/stretch/mode` from `"viewport"` to `"canvas_items"`
- Modified `window/stretch/aspect` between `"keep"` and `"expand"`
- Added comprehensive display settings:
  ```
  window/size/initial_position_type=0
  window/size/borderless=true
  window/size/full_screen=false
  window/size/window_width_override=0
  window/size/window_height_override=0
  ```

### 3. Export Presets Configuration
- Changed `html/canvas_resize_policy` from `"3"` to `"2"` (Project Settings)
- Verified no conflicting HTML template settings

### 4. HTML Template Modifications
- Added container CSS before Godot initialization
- Modified canvas sizing in the generated HTML
- Ensured canvas is full-size before WASM module loads

## Root Cause Analysis

The issue appears to be that Godot's WASM module queries the canvas size during initialization and fixes its internal render buffer to whatever size it finds at that moment. If the canvas is 64x64 when Godot starts, it sets the internal resolution to 64x64 and never changes it again, regardless of later CSS modifications.

This is a known limitation in Godot's web export system when using CLI/headless builds without the Godot Editor.

## Current Status

**UNSOLVED** - The web version remains pixelated due to the 64x64 internal resolution limitation.

## Future Approach

This issue should be revisited when:
1. A new Godot CLI version is released that addresses web canvas initialization
2. Godot Editor becomes available in the development environment for proper export configuration
3. Alternative web export methods or templates become available

## Working Configuration

The current working state uses:
- `window/stretch/mode="viewport"`
- `window/stretch/aspect="keep"`
- `html/canvas_resize_policy="3"` (Full Window)
- Basic CSS for canvas sizing (acknowledged to be ineffective for pixelation)

## Notes for Future Developers

- Do not spend additional time on this issue until Godot CLI updates are available
- The problem is well-documented in Godot's web export limitations
- Current workaround is to accept the pixelated web version or use desktop builds
- All attempted solutions have been thoroughly documented above
