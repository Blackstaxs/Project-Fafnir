using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerManager : MonoBehaviour
{
    public static PlayerManager instance;
    public GameObject player;
    private int CurrentDamage = 0;
    public Text ErrorDamage;

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
}
