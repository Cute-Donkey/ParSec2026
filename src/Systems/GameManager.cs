using Godot;

namespace ParSecNova.Systems
{
    public partial class GameManager : Node
    {
        public static GameManager Instance { get; private set; }
        
        // Spiel-Zustand
        public GameState CurrentState { get; private set; }
        
        // Core-Systeme
        public AssetManager Assets { get; private set; }
        public InputManager Input { get; private set; }
        
        public override void _Ready()
        {
            Instance = this;
            InitializeManagers();
            
            GD.Print("ParSec Nova - Game Manager initialized");
        }
        
        private void InitializeManagers()
        {
            // Asset Manager
            Assets = new AssetManager();
            AddChild(Assets);
            
            // Input Manager
            Input = new InputManager();
            AddChild(Input);
            
            // Start im Menu-Zustand
            CurrentState = GameState.Menu;
        }
        
        public override void _Process(double delta)
        {
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
        
        private void ProcessMenuState(double delta)
        {
            // Menu-Logik hier
        }
        
        private void ProcessPlayingState(double delta)
        {
            // Spiel-Logik hier
        }
        
        private void ProcessPausedState(double delta)
        {
            // Pause-Logik hier
        }
        
        private void ProcessLoadingState(double delta)
        {
            // Loading-Logik hier
        }
        
        public void SetGameState(GameState newState)
        {
            GD.Print($"Game state changed: {CurrentState} -> {newState}");
            CurrentState = newState;
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
