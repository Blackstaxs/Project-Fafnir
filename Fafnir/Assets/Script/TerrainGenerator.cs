using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class TerrainGenerator : MonoBehaviour
{
    public ARPointCloudManager pointCloudManager; // reference to the ARPointCloudManager
    public GameObject terrainPrefab; // prefab to instantiate on each point
    public ParticleSystem particlePrefab;
    ARPointCloud m_PointCloud;

    ParticleSystem m_ParticleSystem;

    ParticleSystem.Particle[] m_Particles;

    int m_NumParticles;

    Dictionary<ulong, Vector3> m_Points = new Dictionary<ulong, Vector3>();

    void Start()
    {
        if (!m_PointCloud.positions.HasValue)
            return;

        var positions = m_PointCloud.positions.Value;

        // Store all the positions over time associated with their unique identifiers
        if (m_PointCloud.identifiers.HasValue)
        {
            var identifiers = m_PointCloud.identifiers.Value;
            for (int i = 0; i < positions.Length; ++i)
            {
                m_Points[identifiers[i]] = positions[i];
                //GameObject terrainObject = Instantiate(terrainPrefab, positions[i], Quaternion.identity);
            }
        }

    }

    void RenderPoints()
    {

        // Make sure we have enough particles to store all the ones we want to draw
        /*
        int numParticles = (mode == Mode.All) ? m_Points.Count : positions.Length;
        if (m_Particles == null || m_Particles.Length < numParticles)
        {
            m_Particles = new ParticleSystem.Particle[numParticles];
        }
        */
    }

    public void StopRender()
    {
        GetComponent<ARPointCloud>().enabled = false;
        //int particleIndex = 0;

        foreach (var kvp in m_Points)
        {
            //SetParticlePosition(particleIndex++, kvp.Value);
            GameObject terrainObject = Instantiate(terrainPrefab, kvp.Value, Quaternion.identity);
        }
    }

    public void ParticleRender()
    {
        GetComponent<ARPointCloud>().enabled = false;
        //int particleIndex = 0;

        foreach (var kvp in m_Points)
        {
            ParticleSystem particle = Instantiate(particlePrefab, kvp.Value, Quaternion.identity);
            particle.Play();
        }
    }

    void Awake()
    {
        m_PointCloud = GetComponent<ARPointCloud>();
        m_ParticleSystem = GetComponent<ParticleSystem>();
    }
}
