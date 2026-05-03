using Godot;

namespace ParSecNova.Game.Weapons
{
    public partial class LaserProjectile : RigidBody3D
    {
        public float Damage { get; set; } = 50.0f;
        public float Speed { get; set; } = 1000.0f;
        public float Lifetime { get; set; } = 2.0f;
        
        private float _currentLifetime = 0.0f;
        private bool _hasHit = false;
        
        public override void _Ready()
        {
            // Set up physics properties
            GravityScale = 0.0f; // No gravity in space
            LinearDamp = 0.0f; // No friction in space
            
            // Add collision detection
            BodyEntered += OnBodyEntered;
            
            // Set initial velocity
            ApplyCentralImpulse(-Transform.Basis.Z * Speed);
            
            // Create visual representation
            CreateLaserVisual();
        }
        
        public override void _PhysicsProcess(double delta)
        {
            _currentLifetime += (float)delta;
            
            if (_currentLifetime >= Lifetime || _hasHit)
            {
                QueueFree();
            }
        }
        
        private void CreateLaserVisual()
        {
            // Create a simple cylinder mesh for the laser
            var mesh = new CylinderMesh();
            mesh.Height = 2.0f;
            mesh.TopRadius = 0.05f;
            mesh.BottomRadius = 0.05f;
            
            var material = new StandardMaterial3D();
            material.AlbedoColor = Colors.Red;
            material.EmissionEnabled = true;
            material.Emission = Colors.Red;
            material.EmissionEnergyMultiplier = 2.0f;
            
            var meshInstance = new MeshInstance3D();
            meshInstance.Mesh = mesh;
            meshInstance.MaterialOverride = material;
            
            // Rotate cylinder to face forward
            meshInstance.RotationDegrees = new Vector3(90, 0, 0);
            
            AddChild(meshInstance);
            
            // Add light for visual effect
            var light = new OmniLight3D();
            light.LightColor = Colors.Red;
            light.LightEnergy = 2.0f;
            light.ShadowEnabled = false;
            AddChild(light);
        }
        
        private void OnBodyEntered(Node body)
        {
            if (_hasHit) return;
            
            GD.Print($"Laser hit: {body.Name}");
            
            // Check if the hit object is damageable
            if (body.HasMethod("TakeDamage"))
            {
                body.Call("TakeDamage", Damage);
            }
            else if (body is RigidBody3D)
            {
                // Apply physics impact
                var rigidBody = body as RigidBody3D;
                rigidBody.ApplyCentralImpulse(-Transform.Basis.Z * Damage * 10);
            }
            
            _hasHit = true;
            CreateHitEffect();
        }
        
                
        private void CreateHitEffect()
        {
            // Simple hit effect - create a small light flash
            var light = new OmniLight3D();
            light.LightColor = Colors.Red;
            light.LightEnergy = 3.0f;
            light.ShadowEnabled = false;
            light.Position = GlobalPosition;
            
            GetTree().Root.AddChild(light);
            
            // Remove light after flash
            var timer = GetTree().CreateTimer(0.2f);
            timer.Timeout += () => light.QueueFree();
        }
    }
}
