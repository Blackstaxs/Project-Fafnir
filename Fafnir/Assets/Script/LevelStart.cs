using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

public class LevelStart : MonoBehaviour
{
    public GameObject enemyRed;
    public GameObject enemyBlue;
    public GameObject enemyGreen;
    public GameObject enemyYellow;

    public int EnemiesRemaing = 0;
    private int numWave = 0;
    private bool spawnEnemy = true;
    public Text ScreenEnemy;

    //all Points Scanned
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();
    public List<ulong> usedPoints = new List<ulong>();
    // Start is called before the first frame update
    void Start()
    {
        if (EnemiesRemaing == 0 && spawnEnemy)
        {
            spawnEnemy = false;
            SpawnWave();
        }
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
        spawnEnemy = true;
    }

    public void minusEnemy()
    {
        EnemiesRemaing -= 1;

        if (EnemiesRemaing <= 0 && spawnEnemy)
        {
            spawnEnemy = false;
            SpawnWave();
        }
        else
        {
            UpdateNumerScreen();
        }
    }

    public void SpawnWave()
    {

        if (numWave == 0)
        {
            randomEnemies(0, 1);
            numWave += 1;
        }
        else if (numWave == 1)
        {
            randomEnemies(3, 1);
            numWave += 1;
        }
        else if (numWave == 2)
        {
            randomEnemies(2, 1);
            numWave += 1;
        }
        else if (numWave == 3)
        {
            randomEnemies(1, 1);
            numWave += 1;
        }
        else if (numWave == 4)
        {
            int randomIndex = Random.Range(0, 4);
            randomEnemies(randomIndex, 2);
            numWave += 1;
        }
        else if (numWave == 5)
        {
            int randomIndex = Random.Range(0, 4);
            randomEnemies(randomIndex, 3);
            numWave += 1;
        }
        usedPoints.Clear();
        UpdateNumerScreen();
    }

    public void randomEnemies(int enemyType, int numEnemies)
    {
        GameObject enemyPrefab = null;
        switch (enemyType)
        {
            case 0:
                enemyPrefab = enemyBlue;
                break;
            case 1:
                enemyPrefab = enemyRed;
                break;
            case 2:
                enemyPrefab = enemyGreen;
                break;
            case 3:
                enemyPrefab = enemyYellow;
                break;
            default:
                Debug.LogError("Invalid enemy type specified");
                return;
        }

        for (int i = 0; i < numEnemies; i++)
        {
            SpawnRandomObject(enemyPrefab);
        }
        EnemiesRemaing = numEnemies;
        spawnEnemy = true;
    }

    public void UpdateNumerScreen()
    {
        ScreenEnemy.text = EnemiesRemaing.ToString();
    }
}
