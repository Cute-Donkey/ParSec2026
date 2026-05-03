using Godot;
using System.Collections.Generic;

namespace ParSecNova.Systems
{
    public partial class AssetManager : Node
    {
        // Asset-Caches
        private Dictionary<string, PackedScene> _sceneCache = new();
        private Dictionary<string, Texture2D> _textureCache = new();
        private Dictionary<string, AudioStream> _audioCache = new();
        
        public override void _Ready()
        {
            GD.Print("ParSec Nova - Asset Manager initialized");
        }
        
        public T LoadAsset<T>(string path) where T : Resource
        {
            if (ResourceLoader.Exists(path))
            {
                return GD.Load<T>(path);
            }
            
            GD.PrintErr($"Asset not found: {path}");
            return null;
        }
        
        public PackedScene LoadScene(string path)
        {
            if (_sceneCache.TryGetValue(path, out var cachedScene))
            {
                return cachedScene;
            }
            
            var scene = LoadAsset<PackedScene>(path);
            if (scene != null)
            {
                _sceneCache[path] = scene;
            }
            
            return scene;
        }
        
        public Texture2D LoadTexture(string path)
        {
            if (_textureCache.TryGetValue(path, out var cachedTexture))
            {
                return cachedTexture;
            }
            
            var texture = LoadAsset<Texture2D>(path);
            if (texture != null)
            {
                _textureCache[path] = texture;
            }
            
            return texture;
        }
        
        public AudioStream LoadAudio(string path)
        {
            if (_audioCache.TryGetValue(path, out var cachedAudio))
            {
                return cachedAudio;
            }
            
            var audio = LoadAsset<AudioStream>(path);
            if (audio != null)
            {
                _audioCache[path] = audio;
            }
            
            return audio;
        }
        
        public void ClearCache()
        {
            _sceneCache.Clear();
            _textureCache.Clear();
            _audioCache.Clear();
            
            GD.Print("ParSec Nova - Asset cache cleared");
        }
        
        public int GetCacheSize()
        {
            return _sceneCache.Count + _textureCache.Count + _audioCache.Count;
        }
    }
}
