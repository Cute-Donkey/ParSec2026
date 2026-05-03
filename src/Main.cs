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
            // Rendering-Einstellungen
            RenderingServer.DefaultClearColor = Colors.Black;
            
            // Physik-Einstellungen (keine Schwerkraft im Weltraum)
            PhysicsServer3D.SetActive(true);
            
            // Audio-Einstellungen
            AudioServer.SetBusCount(8);
            
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
