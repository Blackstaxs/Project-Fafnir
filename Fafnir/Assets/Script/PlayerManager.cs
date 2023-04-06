using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerManager : MonoBehaviour
{
    public static PlayerManager instance;
    public GameObject player;
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();
    private int CurrentDamage = 0;
    public Text ErrorDamage;
    public GameObject Intro;

    private void Awake()
    {
        // Make sure there's only one instance of this script
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(gameObject);
        }
    }

    public Vector3 GetPlayerPosition()
    {
        return instance.player.transform.position;
    }

    public Dictionary<ulong, Vector3> GetSavedPoints()
    {
        return SavedPoints;
    }

    public Vector3 GetObjectPosition()
    {
        return instance.player.gameObject.transform.position;
    }

    public void TakeDamage()
    {
        if(CurrentDamage <= 100) 
        { 
            CurrentDamage += 5;
            UpdateDamage();
        }
    }

    public void UpdateDamage()
    {
        ErrorDamage.text = "ERROR: " + CurrentDamage + "%";
    }

    public void EnemyDeath()
    {
        Intro.GetComponent<LevelStart>().minusEnemy();
    }

    public void EndGame()
    {
        Intro.GetComponent<PlaceObject>().askRetry();
    }
}
