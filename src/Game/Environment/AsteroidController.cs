using Godot;

namespace ParSecNova.Game.Environment
{
    public partial class AsteroidController : RigidBody3D
    {
        [Export] public float Health { get; set; } = 100.0f;
        [Export] public float ExplosionForce { get; set; } = 500.0f;
        [Export] public PackedScene ExplosionScene { get; set; }
        [Export] public PackedScene FragmentScene { get; set; }
        
        private bool _isDestroyed = false;
        
        public override void _Ready()
        {
            // Set up physics properties
            GravityScale = 0.0f;
            LinearDamp = 0.01f;
            AngularDamp = 0.01f;
            
            // Add some random rotation for visual effect
            AngularVelocity = new Vector3(
                (float)GD.RandRange(-1, 1),
                (float)GD.RandRange(-1, 1),
                (float)GD.RandRange(-1, 1)
            );
        }
        
        public void TakeDamage(float damage)
        {
            if (_isDestroyed) return;
            
            Health -= damage;
            GD.Print($"Asteroid took {damage} damage. Health: {Health}");
            
            if (Health <= 0)
            {
                DestroyAsteroid();
            }
        }
        
        private void DestroyAsteroid()
        {
            if (_isDestroyed) return;
            _isDestroyed = true;
            
            GD.Print("Asteroid destroyed!");
            
            // Create explosion effect
            CreateExplosion();
            
            // Create fragments
            CreateFragments();
            
            // Remove asteroid
            QueueFree();
        }
        
        private void CreateExplosion()
        {
            if (ExplosionScene != null)
            {
                var explosion = ExplosionScene.Instantiate() as Node3D;
                if (explosion != null)
                {
                    explosion.Position = GlobalPosition;
                    GetTree().Root.AddChild(explosion);
                    
                    // Auto-remove explosion after animation
                    var timer = GetTree().CreateTimer(2.0f);
                    timer.Timeout += () => explosion.QueueFree();
                }
            }
            else
            {
                // Fallback: simple particle effect
                CreateFallbackExplosion();
            }
        }
        
        private void CreateFallbackExplosion()
        {
            // Simple explosion effect with light
            var light = new OmniLight3D();
            light.LightColor = Colors.Orange;
            light.LightEnergy = 8.0f;
            light.ShadowEnabled = false;
            light.Position = GlobalPosition;
            
            GetTree().Root.AddChild(light);
            
            // Remove light after explosion
            var timer = GetTree().CreateTimer(1.0f);
            timer.Timeout += () => light.QueueFree();
        }
        
        private void CreateFragments()
        {
            if (FragmentScene != null)
            {
                // Create multiple fragments
                int fragmentCount = (int)GD.RandRange(3, 6);
                for (int i = 0; i < fragmentCount; i++)
                {
                    var fragment = FragmentScene.Instantiate() as RigidBody3D;
                    if (fragment != null)
                    {
                        fragment.Position = GlobalPosition;
                        fragment.Rotation = new Vector3(
                            (float)GD.RandRange(0, Mathf.Tau),
                            (float)GD.RandRange(0, Mathf.Tau),
                            (float)GD.RandRange(0, Mathf.Tau)
                        );
                        
                        // Apply random velocity to fragments
                        var randomDirection = new Vector3(
                            (float)GD.RandRange(-1, 1),
                            (float)GD.RandRange(-1, 1),
                            (float)GD.RandRange(-1, 1)
                        ).Normalized();
                        
                        fragment.LinearVelocity = randomDirection * ExplosionForce;
                        fragment.AngularVelocity = new Vector3(
                            (float)GD.RandRange(-5, 5),
                            (float)GD.RandRange(-5, 5),
                            (float)GD.RandRange(-5, 5)
                        );
                        
                        GetTree().Root.AddChild(fragment);
                        
                        // Auto-remove fragments after some time
                        var timer = GetTree().CreateTimer(5.0f);
                        timer.Timeout += () => fragment.QueueFree();
                    }
                }
            }
        }
    }
}
