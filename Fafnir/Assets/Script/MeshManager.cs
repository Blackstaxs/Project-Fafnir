using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class MeshManager : MonoBehaviour
{
    private ARMeshManager arMeshManager;

    void Start()
    {
        arMeshManager = FindObjectOfType<ARSession>().GetComponentInChildren<ARMeshManager>();
        arMeshManager.meshesChanged += OnMeshesChanged;
    }

    void OnMeshesChanged(ARMeshesChangedEventArgs args)
    {
        // Handle mesh changes
        foreach (var mesh in args.added)
        {
            // Add logic for adding meshes to your scene
        }

        foreach (var mesh in args.updated)
        {
            // Add logic for updating meshes in your scene
        }

        foreach (var mesh in args.removed)
        {
            // Add logic for removing meshes from your scene
        }
    }
}
