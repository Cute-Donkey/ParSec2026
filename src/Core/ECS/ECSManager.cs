using Godot;
using System.Collections.Generic;

namespace ParSecNova.Core.ECS
{
    public partial class ECSManager : Node
    {
        private Dictionary<int, Entity> _entities = new();
        private Dictionary<SystemType, ISystem> _systems = new();
        private int _nextEntityId = 1;
        
        public override void _Ready()
        {
            GD.Print("ParSec Nova - ECS Manager initialized");
        }
        
        public Entity CreateEntity()
        {
            var entity = new Entity(_nextEntityId++);
            _entities[entity.Id] = entity;
            return entity;
        }
        
        public void DestroyEntity(int entityId)
        {
            if (_entities.ContainsKey(entityId))
            {
                _entities.Remove(entityId);
            }
        }
        
        public void AddComponent<T>(int entityId, T component) where T : IComponent
        {
            if (_entities.ContainsKey(entityId))
            {
                _entities[entityId].AddComponent(component);
            }
        }
        
        public T GetComponent<T>(int entityId) where T : IComponent
        {
            if (_entities.ContainsKey(entityId))
            {
                return _entities[entityId].GetComponent<T>();
            }
            return default(T);
        }
        
        public bool HasComponent<T>(int entityId) where T : IComponent
        {
            if (_entities.ContainsKey(entityId))
            {
                return _entities[entityId].HasComponent<T>();
            }
            return false;
        }
        
        public void AddSystem<T>(T system) where T : ISystem
        {
            _systems[system.SystemType] = system;
        }
        
        public void Update(double delta)
        {
            foreach (var system in _systems.Values)
            {
                system.Update(delta, _entities.Values);
            }
        }
        
        public int GetEntityCount()
        {
            return _entities.Count;
        }
        
        public IEnumerable<Entity> GetAllEntities()
        {
            return _entities.Values;
        }
    }
    
    public class Entity
    {
        public int Id { get; }
        private Dictionary<System.Type, IComponent> _components = new();
        
        public Entity(int id)
        {
            Id = id;
        }
        
        public void AddComponent<T>(T component) where T : IComponent
        {
            _components[typeof(T)] = component;
        }
        
        public T GetComponent<T>() where T : IComponent
        {
            var componentType = typeof(T);
            if (_components.TryGetValue(componentType, out var component))
            {
                return (T)component;
            }
            return default(T);
        }
        
        public bool HasComponent<T>() where T : IComponent
        {
            return _components.ContainsKey(typeof(T));
        }
        
        public void RemoveComponent<T>() where T : IComponent
        {
            _components.Remove(typeof(T));
        }
        
        public bool HasComponents<T1, T2>()
            where T1 : IComponent
            where T2 : IComponent
        {
            return HasComponent<T1>() && HasComponent<T2>();
        }
        
        public bool HasComponents<T1, T2, T3>()
            where T1 : IComponent
            where T2 : IComponent
            where T3 : IComponent
        {
            return HasComponent<T1>() && HasComponent<T2>() && HasComponent<T3>();
        }
    }
    
    public interface IComponent
    {
        // Basiskomponente - kann leer sein
    }
    
    public interface ISystem
    {
        SystemType SystemType { get; }
        void Update(double delta, IEnumerable<Entity> entities);
    }
    
    public enum SystemType
    {
        Physics,
        Rendering,
        Input,
        Audio,
        AI,
        Network
    }
}
