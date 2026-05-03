using Godot;

namespace ParSecNova.Core.Physics
{
    /// <summary>
    /// Base class for objects with Newtonian physics in space.
    /// Provides thrust and torque controls with zero gravity.
    /// </summary>
    public partial class NewtonianBody : RigidBody3D
    {
        /// <summary>
        /// Maximum thrust force that can be applied.
        /// </summary>
        [Export] public float MaxThrust { get; set; } = 1000.0f;
        
        /// <summary>
        /// Maximum torque that can be applied for rotation.
        /// </summary>
        [Export] public float MaxTorque { get; set; } = 500.0f;
        
        private Vector3 _thrustForce = Vector3.Zero;
        private Vector3 _torqueForce = Vector3.Zero;
        
        /// <summary>
        /// Called when the node enters the scene tree.
        /// Sets up physics properties for space simulation.
        /// </summary>
        public override void _Ready()
        {
            // Disable gravity for space physics
            GravityScale = 0.0f;
            // Set linear damping to minimal for realistic space movement
            LinearDamp = 0.01f;
            // Set angular damping to minimal for realistic space rotation
            AngularDamp = 0.01f;
        }
        
        /// <summary>
        /// Called during physics processing.
        /// Applies active thrust and torque forces.
        /// </summary>
        /// <param name="delta">Time since last physics frame</param>
        public override void _PhysicsProcess(double delta)
        {
            // Apply thrust force if active
            if (_thrustForce != Vector3.Zero)
            {
                ApplyCentralForce(_thrustForce);
            }
            
            // Apply torque if active
            if (_torqueForce != Vector3.Zero)
            {
                ApplyTorque(_torqueForce);
            }
        }
        
        /// <summary>
        /// Apply thrust force in the specified direction.
        /// </summary>
        /// <param name="direction">Normalized direction vector for thrust</param>
        /// <param name="thrustAmount">Thrust amount from 0.0 to 1.0</param>
        public void ApplyThrust(Vector3 direction, float thrustAmount)
        {
            _thrustForce = direction.Normalized() * thrustAmount * MaxThrust;
        }
        
        /// <summary>
        /// Apply torque for rotation.
        /// </summary>
        /// <param name="direction">Normalized direction vector for torque</param>
        /// <param name="torqueAmount">Torque amount from 0.0 to 1.0</param>
        public void ApplyTorque(Vector3 direction, float torqueAmount)
        {
            _torqueForce = direction.Normalized() * torqueAmount * MaxTorque;
        }
        
        /// <summary>
        /// Stop all thrust forces.
        /// </summary>
        public void StopThrust()
        {
            _thrustForce = Vector3.Zero;
        }
        
        /// <summary>
        /// Stop all torque forces.
        /// </summary>
        public void StopTorque()
        {
            _torqueForce = Vector3.Zero;
        }
        
        /// <summary>
        /// Get current velocity for debugging purposes.
        /// </summary>
        /// <returns>Current linear velocity of the body</returns>
        public Vector3 GetVelocity()
        {
            return LinearVelocity;
        }
        
        /// <summary>
        /// Get current angular velocity for debugging purposes.
        /// </summary>
        /// <returns>Current angular velocity of the body</returns>
        public Vector3 GetAngularVelocity()
        {
            return AngularVelocity;
        }
    }
}
