using Godot;
using ParSecNova.Core.Physics;
using ParSecNova.Game.Weapons;

namespace ParSecNova.Game.Ships
{
    public partial class ShipController : NewtonianBody
    {
        [Export] public float RotationSpeed { get; set; } = 2.0f;
        [Export] public float ThrustPower { get; set; } = 1.0f;
        [Export] public PackedScene LaserScene { get; set; }
        
        private Camera3D _camera;
        private LaserWeapon _laserWeapon;
        
        public override void _Ready()
        {
            base._Ready();
            _camera = GetNode<Camera3D>("Camera3D");
            
            // Create laser weapon
            _laserWeapon = new LaserWeapon();
            _laserWeapon.LaserScene = LaserScene;
            AddChild(_laserWeapon);
            
            // Position weapon at front of ship
            _laserWeapon.Position = new Vector3(0, 0, -2);
        }
        
        public override void _Process(double delta)
        {
            HandleInput();
        }
        
        private void HandleInput()
        {
            // Rotation controls (Q/E for yaw, A/D for roll, W/S for pitch)
            Vector3 torque = Vector3.Zero;
            
            if (Input.IsActionPressed("roll_left"))
            {
                torque += Vector3.Forward * RotationSpeed;
            }
            if (Input.IsActionPressed("roll_right"))
            {
                torque += Vector3.Back * RotationSpeed;
            }
            if (Input.IsActionPressed("pitch_up"))
            {
                torque += Vector3.Right * RotationSpeed;
            }
            if (Input.IsActionPressed("pitch_down"))
            {
                torque += Vector3.Left * RotationSpeed;
            }
            if (Input.IsActionPressed("yaw_left"))
            {
                torque += Vector3.Up * RotationSpeed;
            }
            if (Input.IsActionPressed("yaw_right"))
            {
                torque += Vector3.Down * RotationSpeed;
            }
            
            if (torque != Vector3.Zero)
            {
                ApplyTorque(torque, 1.0f);
            }
            else
            {
                StopTorque();
            }
            
            // Thrust controls (Space for forward thrust, Shift for reverse)
            if (Input.IsActionPressed("thrust_forward"))
            {
                ApplyThrust(-Transform.Basis.Z, ThrustPower);
            }
            else if (Input.IsActionPressed("thrust_backward"))
            {
                ApplyThrust(Transform.Basis.Z, ThrustPower * 0.5f);
            }
            else
            {
                StopThrust();
            }
            
            // Strafe controls
            Vector3 strafe = Vector3.Zero;
            if (Input.IsActionPressed("strafe_left"))
            {
                strafe += -Transform.Basis.X;
            }
            if (Input.IsActionPressed("strafe_right"))
            {
                strafe += Transform.Basis.X;
            }
            if (Input.IsActionPressed("strafe_up"))
            {
                strafe += Transform.Basis.Y;
            }
            if (Input.IsActionPressed("strafe_down"))
            {
                strafe += -Transform.Basis.Y;
            }
            
            if (strafe != Vector3.Zero)
            {
                ApplyThrust(strafe.Normalized(), ThrustPower * 0.7f);
            }
            
            // Weapon controls
            if (Input.IsActionPressed("fire_weapon"))
            {
                _laserWeapon?.Fire();
            }
        }
    }
}
