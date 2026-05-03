using Godot;

namespace ParSecNova.Systems
{
    public partial class InputManager : Node
    {
        // 6DoF Steuerung
        public Vector3 GetTranslationInput()
        {
            var input = Vector3.Zero;
            
            // Vorwärts/Rückwärts
            if (Input.IsActionPressed("move_forward"))
                input.Z -= 1.0f;
            if (Input.IsActionPressed("move_backward"))
                input.Z += 1.0f;
            
            // Links/Rechts (Strafe)
            if (Input.IsActionPressed("move_left"))
                input.X -= 1.0f;
            if (Input.IsActionPressed("move_right"))
                input.X += 1.0f;
            
            // Hoch/Runter
            if (Input.IsActionPressed("move_up"))
                input.Y += 1.0f;
            if (Input.IsActionPressed("move_down"))
                input.Y -= 1.0f;
            
            return input.Normalized();
        }
        
        public Vector3 GetRotationInput()
        {
            var input = Vector3.Zero;
            
            // Maus-Steuerung für Rotation
            var mouseMotion = Input.GetLastMouseVelocity();
            
            // Pitch (hoch/runter)
            input.X = -mouseMotion.Y * 0.001f;
            
            // Yaw (links/rechts)
            input.Y = -mouseMotion.X * 0.001f;
            
            // Roll (Q/E für Roll)
            if (Input.IsActionPressed("roll_left"))
                input.Z -= 1.0f;
            if (Input.IsActionPressed("roll_right"))
                input.Z += 1.0f;
            
            return input;
        }
        
        public bool IsFireWeaponPressed()
        {
            return Input.IsActionPressed("fire_weapon");
        }
        
        public bool IsToggleMenuPressed()
        {
            return Input.IsActionJustPressed("toggle_menu");
        }
        
        public override void _Ready()
        {
            GD.Print("ParSec Nova - Input Manager initialized");
        }
    }
}
