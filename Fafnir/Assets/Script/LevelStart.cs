using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelStart : MonoBehaviour
{
    public GameObject enemyRed;
    public GameObject enemyBlue;
    public GameObject enemyGreen;
    public GameObject enemyYellow;

    //all Points Scanned
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();
    public List<ulong> usedPoints = new List<ulong>();
    // Start is called before the first frame update
    void Start()
    {
        //Invoke("SpawnRandomObject", 2f);
        SpawnRandomObject(enemyRed);
        SpawnRandomObject(enemyBlue);
        SpawnRandomObject(enemyGreen);
        SpawnRandomObject(enemyYellow);
        usedPoints.Clear();
    }

    private void Awake()
    {
        //GetComponent<PlayerProjectile>().enabled = true;

    }

    // Update is called once per frame
    void Update()
    {
     
    }

    public void SpawnRandomObject(GameObject enemyprefab)
    {
        // Get a random key from the dictionary
        List<ulong> keys = new List<ulong>(SavedPoints.Keys);
        
        ulong randomKey = keys[Random.Range(0, keys.Count)];

        while (usedPoints.Contains(randomKey))
        {
            randomKey = keys[Random.Range(0, keys.Count)];
        }

        usedPoints.Add(randomKey);

        // Get the position associated with the random key
        Vector3 randomPosition = SavedPoints[randomKey];

        // Instantiate the prefab at the random position
        Instantiate(enemyprefab, randomPosition, Quaternion.identity);
    }
}
