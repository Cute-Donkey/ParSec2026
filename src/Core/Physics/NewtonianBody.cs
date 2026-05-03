using Godot;

namespace ParSecNova.Core.Physics
{
    public partial class NewtonianBody : RigidBody3D
    {
        [Export] public float MaxThrust { get; set; } = 1000.0f;
        [Export] public float MaxTorque { get; set; } = 500.0f;
        
        private Vector3 _thrustForce = Vector3.Zero;
        private Vector3 _torqueForce = Vector3.Zero;
        
        public override void _Ready()
        {
            // Disable gravity for space physics
            GravityScale = 0.0f;
            // Set linear damping to minimal for realistic space movement
            LinearDamp = 0.01f;
            AngularDamp = 0.01f;
        }
        
        public override void _PhysicsProcess(double delta)
        {
            // Apply thrust force
            if (_thrustForce != Vector3.Zero)
            {
                ApplyCentralForce(_thrustForce);
            }
            
            // Apply torque for rotation
            if (_torqueForce != Vector3.Zero)
            {
                ApplyTorque(_torqueForce);
            }
        }
        
        public void ApplyThrust(Vector3 direction, float thrustAmount)
        {
            _thrustForce = direction.Normalized() * thrustAmount * MaxThrust;
        }
        
        public void ApplyTorque(Vector3 torqueDirection, float torqueAmount)
        {
            _torqueForce = torqueDirection.Normalized() * torqueAmount * MaxTorque;
        }
        
        public void StopThrust()
        {
            _thrustForce = Vector3.Zero;
        }
        
        public void StopTorque()
        {
            _torqueForce = Vector3.Zero;
        }
        
        // Get current velocity for debugging
        public Vector3 GetVelocity()
        {
            return LinearVelocity;
        }
        
        // Get current angular velocity
        public Vector3 GetAngularVelocity()
        {
            return AngularVelocity;
        }
    }
}
