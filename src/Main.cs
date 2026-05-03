using Godot;

namespace ParSecNova.Core
{
    public partial class Main : Node
    {
        public override void _Ready()
        {
            // Engine-Konfiguration
            ConfigureEngine();
            
            // Core-Systeme initialisieren
            InitializeCoreSystems();
            
            // Haupt-Szene laden
            LoadMainScene();
        }
        
        private void ConfigureEngine()
        {
            // Rendering settings
            // Note: DefaultClearColor is not available in Godot 4.x
            // This will be handled by the WorldEnvironment
            
            // Physik-Einstellungen (keine Schwerkraft im Weltraum)
            PhysicsServer3D.SetActive(true);
            
            // Audio-Einstellungen
            // Note: SetBusCount is not available in Godot 4.x
            // Audio buses will be configured automatically
            
            GD.Print("ParSec Nova - Engine configured");
        }
        
        private void InitializeCoreSystems()
        {
            // Game Manager
            var gameManagerScene = GD.Load<PackedScene>("res://scenes/core/GameManager.tscn");
            var gameManager = gameManagerScene.Instantiate();
            AddChild(gameManager);
            
            GD.Print("ParSec Nova - Core systems initialized");
        }
        
        private void LoadMainScene()
        {
            // Hauptmenü oder direkt in den Spiel-Sektor
            var args = OS.GetCmdlineArgs();
            if (System.Linq.Enumerable.Contains(args, "--skip-menu"))
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
