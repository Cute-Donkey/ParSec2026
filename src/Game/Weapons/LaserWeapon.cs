using Godot;

namespace ParSecNova.Game.Weapons
{
    public partial class LaserWeapon : Node3D
    {
        [Export] public float Damage { get; set; } = 50.0f;
        [Export] public float FireRate { get; set; } = 2.0f; // shots per second
        [Export] public float LaserSpeed { get; set; } = 1000.0f;
        [Export] public float LaserLifetime { get; set; } = 2.0f;
        [Export] public PackedScene LaserScene { get; set; }
        
        private float _timeSinceLastShot = 0.0f;
        private bool _canFire = true;
        
        public override void _Ready()
        {
            if (LaserScene == null)
            {
                GD.PrintErr("LaserWeapon: No laser scene assigned!");
            }
        }
        
        public override void _Process(double delta)
        {
            _timeSinceLastShot += (float)delta;
            
            if (_timeSinceLastShot >= 1.0f / FireRate)
            {
                _canFire = true;
            }
        }
        
        public void Fire()
        {
            if (!_canFire || LaserScene == null)
            {
                return;
            }
            
            // Create laser instance
            var laser = LaserScene.Instantiate() as LaserProjectile;
            if (laser == null)
            {
                GD.PrintErr("LaserWeapon: Failed to instantiate laser projectile");
                return;
            }
            
            // Set laser properties
            laser.Damage = Damage;
            laser.Speed = LaserSpeed;
            laser.Lifetime = LaserLifetime;
            
            // Position and rotate laser
            laser.Transform = this.GlobalTransform;
            
            // Add to scene
            GetTree().Root.AddChild(laser);
            
            // Reset fire timer
            _timeSinceLastShot = 0.0f;
            _canFire = false;
            
            GD.Print("Laser fired!");
        }
    }
}
