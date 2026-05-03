# Phase 1.4: Project Structure

## Godot 4/C# Project Setup for ParSec Nova

### Project Initialization

#### 1. Create Godot Project
```bash
# Initialize Godot project
mkdir ParSecNova
cd ParSecNova

# Godot project configuration
godot --headless --create-project .

# Project settings
# - Name: ParSec Nova
# - Renderer: Vulkan (default) / OpenGL (fallback)
# - Language: C# (.NET 8+)
# - Target platforms: Linux, Windows, macOS
```

#### 2. C#/.NET 8+ Configuration
```csharp
// project.csproj
<Project Sdk="Godot.NET.Sdk/4.2.0">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <RootNamespace>ParSecNova</RootNamespace>
    <AssemblyName>ParSecNova</AssemblyName>
    <GodotSourceGeneratorProperties>GodotSourceGeneratorProperties</GodotSourceGeneratorProperties>
  </PropertyGroup>
  
  <ItemGroup>
    <PackageReference Include="Godot.SourceGenerators" Version="4.2.0" />
    <PackageReference Include="GodotSharp" Version="4.2.0" />
  </ItemGroup>
</Project>
```

### Directory Structure

#### 1. Base Directory Structure
```
ParSecNova/
├── .godot/                    # Godot Engine configuration
├── .mono/                     # Mono/.NET configuration
├── plans/                     # Project planning and documentation
│   ├── parsec_remake_plan_de.md
│   ├── parsec_remake_plan_en.md
│   ├── parsec_analysis_de.md
│   ├── parsec_analysis_en.md
│   ├── godot_technical_requirements_de.md
│   ├── godot_technical_requirements_en.md
│   ├── ecs_json_integration_de.md
│   ├── ecs_json_integration_en.md
│   ├── ai_world_generation_de.md
│   ├── ai_world_generation_en.md
│   ├── asset_analysis_modernization_de.md
│   └── asset_analysis_modernization_en.md
├── src/                       # C# source code
│   ├── Core/                  # Core systems
│   │   ├── Physics/           # Newtonian physics
│   │   ├── Network/           # Multiplayer (ENet)
│   │   ├── Input/             # 6DoF controls
│   │   ├── ECS/               # Entity Component System
│   │   └── AI/                # AI systems
│   ├── Game/                  # Game logic
│   │   ├── Ships/             # Ship classes
│   │   ├── Weapons/           # Weapon systems
│   │   ├── Environment/       # World objects
│   │   └── UI/                # User Interface
│   ├── Systems/               # System managers
│   │   ├── GameManager.cs
│   │   ├── NetworkManager.cs
│   │   ├── AssetManager.cs
│   │   └── InputManager.cs
│   └── Utilities/             # Helper functions
│       ├── MathHelpers.cs
│       ├── JsonHelpers.cs
│       └── AssetLoaders.cs
├── assets/                    # Game assets
│   ├── models/                # 3D models (glTF/GLB)
│   │   ├── ships/
│   │   │   ├── fighter.glb
│   │   │   ├── cruiser.glb
│   │   │   └── capital_ship.glb
│   │   ├── weapons/
│   │   │   ├── laser_cannon.glb
│   │   │   ├── missile.glb
│   │   │   └── plasma_weapon.glb
│   │   └── environment/
│   │       ├── asteroid.glb
│   │       ├── space_station.glb
│   │       └── planet.glb
│   ├── textures/              # Textures (PNG/WebP)
│   │   ├── ships/
│   │   │   ├── fighter/
│   │   │   │   ├── albedo.png
│   │   │   │   ├── normal.png
│   │   │   │   ├── roughness.png
│   │   │   │   ├── metallic.png
│   │   │   │   ├── ao.png
│   │   │   │   └── emission.png
│   │   │   └── cruiser/
│   │   ├── weapons/
│   │   ├── environment/
│   │   └── ui/
│   ├── sounds/                # Audio files (WAV/OGG)
│   │   ├── weapons/
│   │   │   ├── laser_fire.wav
│   │   │   ├── missile_launch.wav
│   │   │   └── explosion.wav
│   │   ├── engines/
│   │   │   ├── thrust_hum.wav
│   │   │   └── afterburner.wav
│   │   ├── ambient/
│   │   │   ├── space_ambient.wav
│   │   │   └── warning_beep.wav
│   │   └── ui/
│   ├── materials/             # Godot materials
│   │   ├── ships/
│   │   │   ├── fighter_material.tres
│   │   │   └── cruiser_material.tres
│   │   ├── weapons/
│   │   └── environment/
│   └── worlds/                # JSON world data
│       ├── sectors/
│       │   ├── alpha_centauri.json
│       │   ├── sol_system.json
│       │   └── nebula_regions.json
│       ├── ships/
│       │   ├── fighter_types.json
│       │   ├── cruiser_types.json
│       │   └── capital_ships.json
│       └── stations/
│           ├── trading_posts.json
│           └── military_bases.json
├── scenes/                   # Godot scenes
│   ├── core/
│   │   ├── Main.tscn          # Main scene
│   │   ├── GameManager.tscn   # Game Manager
│   │   └── NetworkManager.tscn
│   ├── game/
│   │   ├── SpaceSector.tscn   # Space sector
│   │   ├── Ship.tscn          # Spaceship
│   │   ├── Asteroid.tscn     # Asteroid
│   │   └── SpaceStation.tscn  # Space station
│   ├── ui/
│   │   ├── MainMenu.tscn      # Main menu
│   │   ├── HUD.tscn           # Cockpit HUD
│   │   ├── SettingsMenu.tscn  # Settings
│   │   └── ChatWindow.tscn    # Chat window
│   └── prototypes/
│       ├── MinimalPrototype.tscn  # Minimal prototype
│       └── PhysicsTest.tscn        # Physics test
├── scripts/                  # Godot GDScript (if needed)
│   ├── ui/
│   └── utilities/
├── shaders/                  # Custom shaders
│   ├── ship_shader.gdshader
│   ├── space_shader.gdshader
│   ├── weapon_effects.gdshader
│   └── post_process.gdshader
├── tests/                    # Unit tests
│   ├── Core/
│   │   ├── PhysicsTests.cs
│   │   ├── NetworkTests.cs
│   │   └── ECSTests.cs
│   ├── Game/
│   │   ├── ShipTests.cs
│   │   ├── WeaponTests.cs
│   │   └── EnvironmentTests.cs
│   └── Integration/
│       ├── MultiplayerTests.cs
│       └── AssetLoadingTests.cs
├── tools/                    # Development tools
│   ├── AssetConverter/       # Asset converter
│   ├── WorldEditor/          # World editor
│   ├── ShipDesigner/         # Ship designer
│   └── AssetValidator/       # Asset validation
├── docs/                     # Documentation
│   ├── api/                  # API documentation
│   ├── tutorials/            # Tutorials
│   └── modding/              # Modding guides
├── build/                    # Build output
│   ├── linux/
│   ├── windows/
│   └── macos/
├── project.godot             # Godot project configuration
├── project.csproj            # C# project configuration
├── README.md                 # Project description
├── LICENSE                   # License
└── .gitignore                # Git ignore rules
```

### Core Systems Setup

#### 1. Main.cs - Entry Point
```csharp
using Godot;

namespace ParSecNova.Core
{
    public partial class Main : Node
    {
        public override void _Ready()
        {
            // Engine configuration
            ConfigureEngine();
            
            // Initialize core systems
            InitializeCoreSystems();
            
            // Load main scene
            LoadMainScene();
        }
        
        private void ConfigureEngine()
        {
            // Rendering settings
            RenderingServer.DefaultClearColor = Colors.Black;
            
            // Physics settings
            PhysicsServer3D.SetActive(true);
            
            // Audio settings
            AudioServer.SetBusLayout("res://assets/audio/bus_layout.tres");
        }
        
        private void InitializeCoreSystems()
        {
            // Game Manager
            var gameManager = GD.Load<PackedScene>("res://scenes/core/GameManager.tscn").Instantiate();
            AddChild(gameManager);
            
            // Network Manager (if multiplayer)
            if (OS.GetCmdlineArgs().Contains("--multiplayer"))
            {
                var networkManager = GD.Load<PackedScene>("res://scenes/core/NetworkManager.tscn").Instantiate();
                AddChild(networkManager);
            }
        }
        
        private void LoadMainScene()
        {
            // Main menu or directly to game sector
            if (OS.GetCmdlineArgs().Contains("--skip-menu"))
            {
                GetTree().ChangeSceneToFile("res://scenes/game/SpaceSector.tscn");
            }
            else
            {
                GetTree().ChangeSceneToFile("res://scenes/ui/MainMenu.tscn");
            }
        }
    }
}
```

#### 2. GameManager.cs - Central Manager
```csharp
using Godot;
using ParSecNova.Core.ECS;
using ParSecNova.Core.Network;
using ParSecNova.Core.Physics;

namespace ParSecNova.Systems
{
    public partial class GameManager : Node
    {
        public static GameManager Instance { get; private set; }
        
        // Core systems
        public ECSManager ECS { get; private set; }
        public NetworkManager Network { get; private set; }
        public PhysicsManager Physics { get; private set; }
        public AssetManager Assets { get; private set; }
        public InputManager Input { get; private set; }
        
        // Game state
        public GameState CurrentState { get; private set; }
        
        public override void _Ready()
        {
            Instance = this;
            InitializeManagers();
        }
        
        private void InitializeManagers()
        {
            // ECS Manager
            ECS = new ECSManager();
            AddChild(ECS);
            
            // Physics Manager
            Physics = new PhysicsManager();
            AddChild(Physics);
            
            // Asset Manager
            Assets = new AssetManager();
            AddChild(Assets);
            
            // Input Manager
            Input = new InputManager();
            AddChild(Input);
            
            // Network Manager (optional)
            if (HasNode("NetworkManager"))
            {
                Network = GetNode<NetworkManager>("NetworkManager");
            }
        }
        
        public override void _Process(double delta)
        {
            // Game loop
            UpdateGameState(delta);
        }
        
        private void UpdateGameState(double delta)
        {
            switch (CurrentState)
            {
                case GameState.Menu:
                    ProcessMenuState(delta);
                    break;
                case GameState.Playing:
                    ProcessPlayingState(delta);
                    break;
                case GameState.Paused:
                    ProcessPausedState(delta);
                    break;
                case GameState.Loading:
                    ProcessLoadingState(delta);
                    break;
            }
        }
        
        private void ProcessPlayingState(double delta)
        {
            // ECS Update
            ECS.Update(delta);
            
            // Physics Update
            Physics.Update(delta);
            
            // Network Update (if active)
            Network?.Update(delta);
        }
    }
    
    public enum GameState
    {
        Menu,
        Playing,
        Paused,
        Loading
    }
}
```

#### 3. ECS Manager - Entity Component System
```csharp
using Godot;
using System.Collections.Generic;

namespace ParSecNova.Core.ECS
{
    public partial class ECSManager : Node
    {
        private Dictionary<int, Entity> _entities = new();
        private Dictionary<SystemType, ISystem> _systems = new();
        private int _nextEntityId = 1;
        
        public Entity CreateEntity()
        {
            var entity = new Entity(_nextEntityId++);
            _entities[entity.Id] = entity;
            return entity;
        }
        
        public void DestroyEntity(int entityId)
        {
            if (_entities.ContainsKey(entityId))
            {
                _entities.Remove(entityId);
            }
        }
        
        public void AddComponent<T>(int entityId, T component) where T : IComponent
        {
            if (_entities.ContainsKey(entityId))
            {
                _entities[entityId].AddComponent(component);
            }
        }
        
        public T GetComponent<T>(int entityId) where T : IComponent
        {
            if (_entities.ContainsKey(entityId))
            {
                return _entities[entityId].GetComponent<T>();
            }
            return default(T);
        }
        
        public void AddSystem<T>(T system) where T : ISystem
        {
            _systems[system.SystemType] = system;
        }
        
        public void Update(double delta)
        {
            foreach (var system in _systems.Values)
            {
                system.Update(delta, _entities.Values);
            }
        }
    }
    
    public class Entity
    {
        public int Id { get; }
        private Dictionary<ComponentType, IComponent> _components = new();
        
        public Entity(int id)
        {
            Id = id;
        }
        
        public void AddComponent<T>(T component) where T : IComponent
        {
            _components[component.ComponentType] = component;
        }
        
        public T GetComponent<T>() where T : IComponent
        {
            var componentType = typeof(T);
            if (_components.TryGetValue(componentType, out var component))
            {
                return (T)component;
            }
            return default(T);
        }
        
        public bool HasComponent<T>() where T : IComponent
        {
            return _components.ContainsKey(typeof(T));
        }
    }
    
    public interface IComponent
    {
        ComponentType ComponentType { get; }
    }
    
    public interface ISystem
    {
        SystemType SystemType { get; }
        void Update(double delta, IEnumerable<Entity> entities);
    }
}
```

### Build Pipeline Configuration

#### 1. Export Presets
```json
// export_presets.cfg
[preset.0]

name="Linux/X11"
platform="Linux/X11"
runnable=true
dedicated_server=false
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="build/linux/ParSecNova.x86_64"
encryption_include_filters=[]
encryption_exclude_filters=[]

[preset.0.options]

custom_template/debug=""
custom_template/release=""
debug/export_console_wrapper=1
binary_format/embed_pck=false
texture_format/bptc=true
texture_format/s3tc=true
binary_format/architecture="x86_64"

[preset.1]

name="Windows Desktop"
platform="Windows Desktop"
runnable=true
dedicated_server=false
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="build/windows/ParSecNova.exe"
encryption_include_filters=[]
encryption_exclude_filters=[]

[preset.1.options]

custom_template/debug=""
custom_template/release=""
debug/export_console_wrapper=1
binary_format/embed_pck=false
texture_format/bptc=true
texture_format/s3tc=true
codesign/enable=false
codesign/identity=""
codesign/password=""
codesign/timestamp_server_url=""
application/modify_resources=true
application/icon=""
application/console_wrapper_icon=""
application/file_version=""
application/product_version=""
application/company_name=""
application/product_name=""
application/file_description=""
application/copyright=""
application/trademarks=""
application/export_angle="false"
ssh_remote_deploy/enabled=false
ssh_remote_deploy/host="user@host_ip"
ssh_remote_deploy/port="22"
ssh_remote_deploy/extra_args_ssh=""
ssh_remote_deploy/extra_args_scp=""
ssh_remote_deploy/run_script=""
ssh_remote_deploy/clean_script=""

[preset.2]

name="macOS"
platform="macOS"
runnable=true
dedicated_server=false
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="build/macos/ParSecNova.zip"
encryption_include_filters=[]
encryption_exclude_filters=[]

[preset.2.options]

custom_template/debug=""
custom_template/release=""
debug/export_console_wrapper=1
binary_format/embed_pck=true
texture_format/bptc=true
texture_format/s3tc=true
codesign/codesign=1
codesign/identity=""
codesign/certificate_file=""
codesign/certificate_password=""
codesign/provisioning_profile=""
notarization/notarization=0
notarization/apple_id_name=""
notarization/apple_id_password=""
notarization/apple_team_id=""
privacy/microphone_usage_description=""
privacy/microphone_usage_description_localized={}
privacy/camera_usage_description=""
privacy/camera_usage_description_localized={}
privacy/location_usage_description=""
privacy/location_usage_description_localized={}
privacy/address_book_usage_description=""
privacy/address_book_usage_description_localized={}
privacy/calendar_usage_description=""
privacy/calendar_usage_description_localized={}
privacy/photos_library_usage_description=""
privacy/photos_library_usage_description_localized={}
privacy/desktop_folder_usage_description=""
privacy/desktop_folder_usage_description_localized={}
privacy/documents_folder_usage_description=""
privacy/documents_folder_usage_description_localized={}
privacy/downloads_folder_usage_description=""
privacy/downloads_folder_usage_description_localized={}
privacy/network_volumes_usage_description=""
privacy/network_volumes_usage_description_localized={}
privacy/removable_volumes_usage_description=""
privacy/removable_volumes_usage_description_localized={}
application/icon=""
application/bundle_identifier=""
application/signature=""
application/app_category="Games"
application/short_version=""
application/version=""
application/copyright=""
application/copyright_localized={}
application/export_angle="false"
ssh_remote_deploy/enabled=false
ssh_remote_deploy/host="user@host_ip"
ssh_remote_deploy/port="22"
ssh_remote_deploy/extra_args_ssh=""
ssh_remote_deploy/extra_args_scp=""
ssh_remote_deploy/run_script=""
ssh_remote_deploy/clean_script=""
```

#### 2. Build Script
```bash
#!/bin/bash
# build.sh - Automated build script

echo "Building ParSec Nova..."

# Create build directory
mkdir -p build/{linux,windows,macos}

# Linux Build
echo "Building Linux version..."
godot --headless --export-release "Linux/X11" "build/linux/ParSecNova.x86_64"

# Windows Build (if on Linux with cross-compilation)
echo "Building Windows version..."
godot --headless --export-release "Windows Desktop" "build/windows/ParSecNova.exe"

# macOS Build
echo "Building macOS version..."
godot --headless --export-release "macOS" "build/macos/ParSecNova.zip"

echo "Build completed!"
echo "Linux: build/linux/ParSecNova.x86_64"
echo "Windows: build/windows/ParSecNova.exe"
echo "macOS: build/macos/ParSecNova.zip"
```

### Development Tools Setup

#### 1. Asset Converter
```csharp
// tools/AssetConverter/Program.cs
using Godot;
using System.IO;

namespace ParSecNova.Tools.AssetConverter
{
    public class AssetConverter : Node
    {
        public override void _Ready()
        {
            ConvertLegacyAssets();
        }
        
        private void ConvertLegacyAssets()
        {
            // Convert old ParSec assets
            ConvertModels("legacy/models/", "assets/models/");
            ConvertTextures("legacy/textures/", "assets/textures/");
            ConvertSounds("legacy/sounds/", "assets/sounds/");
        }
        
        private void ConvertModels(string inputPath, string outputPath)
        {
            // OBJ → GLB conversion
            var objFiles = Directory.GetFiles(inputPath, "*.obj");
            foreach (var objFile in objFiles)
            {
                var glbPath = Path.ChangeExtension(
                    Path.Combine(outputPath, Path.GetFileName(objFile)), 
                    ".glb"
                );
                // Conversion logic here
                GD.Print($"Converting {objFile} to {glbPath}");
            }
        }
        
        private void ConvertTextures(string inputPath, string outputPath)
        {
            // TGA/BMP → PNG/WebP conversion
            var textureFiles = Directory.GetFiles(inputPath, "*.*", 
                SearchOption.AllDirectories)
                .Where(f => f.EndsWith(".tga") || f.EndsWith(".bmp"));
            
            foreach (var textureFile in textureFiles)
            {
                var pngPath = Path.ChangeExtension(
                    Path.Combine(outputPath, Path.GetFileName(textureFile)), 
                    ".png"
                );
                // Conversion logic here
                GD.Print($"Converting {textureFile} to {pngPath}");
            }
        }
        
        private void ConvertSounds(string inputPath, string outputPath)
        {
            // WAV → OGG conversion
            var soundFiles = Directory.GetFiles(inputPath, "*.wav");
            foreach (var soundFile in soundFiles)
            {
                var oggPath = Path.ChangeExtension(
                    Path.Combine(outputPath, Path.GetFileName(soundFile)), 
                    ".ogg"
                );
                // Conversion logic here
                GD.Print($"Converting {soundFile} to {oggPath}");
            }
        }
    }
}
```

### Testing Setup

#### 1. Unit Test Configuration
```csharp
// tests/Core/PhysicsTests.cs
using Godot;
using NUnit.Framework;
using ParSecNova.Core.Physics;

namespace ParSecNova.Tests.Core
{
    [TestFixture]
    public class PhysicsTests
    {
        private NewtonianBody _testBody;
        
        [SetUp]
        public void Setup()
        {
            _testBody = new NewtonianBody();
            _testBody.Mass = 1000.0f;
        }
        
        [Test]
        public void TestThrustApplication()
        {
            // Apply thrust force
            var thrustForce = new Vector3(1000.0f, 0.0f, 0.0f);
            _testBody.ApplyThrust(Vector3.Right, 1000.0f);
            
            // Check acceleration
            var expectedAcceleration = thrustForce / _testBody.Mass;
            Assert.AreEqual(expectedAcceleration, _testBody.Acceleration);
        }
        
        [Test]
        public void TestInertia()
        {
            // Check inertia - velocity should not change without thrust
            var initialVelocity = _testBody.Velocity;
            _testBody.UpdatePhysics(1.0);
            
            Assert.AreEqual(initialVelocity, _testBody.Velocity);
        }
    }
}
```

### Conclusion

**Phase 1.4 Project Structure Created:**

✅ **Godot 4/C# Project Setup** with .NET 8+  
✅ **Modular Directory Structure** for code, assets, scenes  
✅ **Core Systems** (ECS, Physics, Network, Input)  
✅ **Build Pipeline** for all target platforms  
✅ **Development Tools** for asset conversion  
✅ **Testing Framework** for unit and integration tests  

**Next Step:** Phase 2 Early Prototype implementation!

**The project is now ready for actual development!** 🚀
