# ParSec Nova

A modern, open-source rebirth of the legendary linux space combat simulator **ParSec** (1999/2002). 

This project aims to bridge the gap between classic Newtonian flight physics and modern game engine technology. By leveraging **Godot 4** and **C#**, we are rebuilding the experience from the ground up, focusing on decentralized multiplayer and AI-driven world-building.

## ✨ Core Vision

- **Authentic Physics:** Implementation of the original Newtonian flight model for deep, skill-based space combat.
- **AI-Driven World Building:** Every player can define their own static sectors using AI prompts, saved in a standardized JSON format.
- **Decentralized Multiplayer:** No central server authority. Players host their own worlds and share sector data peer-to-peer.
- **Open Source Heritage:** Built on the spirit of the original GPL sources, keeping the galaxy free and moddable forever.

## 🛠 Tech Stack

- **Engine:** [Godot 4.x](https://godotengine.org/)
- **Language:** C# (.NET 8/9)
- **Physics:** Custom RigidBody3D implementation based on original ParSec logic.
- **Multiplayer:** Godot High-level Multiplayer API (ENet/P2P).
- **Data Format:** JSON-based world and ship definitions.

## 📂 Repository Structure
This project is part of the [donkey-projects](https://github.com/donkey-projects) organization. To facilitate development, the following repositories are used:

* **Development:** [ParSecNova](https://github.com/donkey-projects/ParSecNova) (This repository)
* **Legacy Source:** [parsec](https://github.com/donkey-projects/parsec) (Original source code fork for logic reference)
* **Legacy Assets:** [orig-openparsec-assets](https://github.com/donkey-projects/orig-openparsec-assets) (Original artwork and sound archives)

## 🚀 Getting Started

**⚠️ Important Notice:** This project is currently in **early development**. We have completed the analysis and planning phase (Phase 1) and set up the basic project structure (Phase 1.4). The actual game implementation (Phase 2+) has not yet begun. Please see the [Project Plan](plans/) for detailed development progress.

### Prerequisites
- .NET SDK (8.0 or higher)
- Godot Engine 4.x (.NET Version)

### Installation
1. Clone the repository:
```bash
   git clone https://github.com/donkey-projects/ParSecNova.git
   cd ParSecNova
```

2. Open the project in Godot:
```bash
   godot --editor
```

### Current Development Status
- ✅ **Phase 1.1**: Original ParSec Analysis (completed)
- ✅ **Phase 1.2**: Technical Requirements (completed)
- ✅ **Phase 1.3**: Asset Analysis & AI Modernization (completed)
- ✅ **Phase 1.4**: Project Structure Setup (completed)
- ⏳ **Phase 2**: Early Prototype (upcoming)

### Project Structure
```
ParSecNova/
├── src/                    # C# source code
│   ├── Core/              # Core systems (ECS, Physics, Network)
│   ├── Game/              # Game logic (Ships, Weapons, Environment)
│   └── Systems/           # Manager classes (Game, Asset, Input)
├── assets/                # Game assets
│   ├── models/            # 3D models (glTF/GLB)
│   ├── textures/          # Textures (PNG/WebP)
│   ├── sounds/            # Audio files (WAV/OGG)
│   └── worlds/            # JSON world data
├── scenes/                # Godot scenes
│   ├── core/              # Core scenes (Main, GameManager)
│   ├── game/              # Game scenes (SpaceSector, Ship)
│   └── ui/                # UI scenes (MainMenu, HUD)
├── tools/                 # Development tools
├── tests/                 # Unit tests
└── build/                 # Build output
```

### Building
```bash
# Make build script executable
chmod +x build.sh

# Build for all platforms
./build.sh
```

### Running
```bash
# Run with Godot
godot --headless --skip-menu

# Or open in editor
godot --editor
```

For detailed licensing and a list of original contributors, see **[CREDITS.md](CREDITS.md)**.
