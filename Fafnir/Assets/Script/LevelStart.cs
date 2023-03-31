using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelStart : MonoBehaviour
{
    public GameObject enemyPrefab;
    //all Points Scanned
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();
    private Vector3 playerPosition;
    private Vector3 projectileDirection;
    // Start is called before the first frame update
    void Start()
    {
        Invoke("SpawnRandomObject", 2f);
    }

    private void Awake()
    {
        //GetComponent<PlayerProjectile>().enabled = true;

    }

    // Update is called once per frame
    void Update()
    {
        playerPosition = PlayerManager.instance.GetPlayerPosition();
        projectileDirection = (playerPosition - transform.position).normalized;
        projectileDirection.y = 0;

        // Rotate this object to face the target direction
        transform.rotation = Quaternion.LookRotation(projectileDirection, Vector3.up);
    }

    public void SpawnRandomObject()
    {
        // Get a random key from the dictionary
        List<ulong> keys = new List<ulong>(SavedPoints.Keys);
        ulong randomKey = keys[Random.Range(0, keys.Count)];

        // Get the position associated with the random key
        Vector3 randomPosition = SavedPoints[randomKey];

        // Instantiate the prefab at the random position
        Instantiate(enemyPrefab, randomPosition, Quaternion.identity);
    }
}
