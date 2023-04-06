using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HardBullet : MonoBehaviour
{
    public float timeToInactive = 10.0f; // The time in seconds before setting the object as inactive


    void Start()
    {
        Invoke("SetObjectInactive", timeToInactive);
    }


    void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Projectile") == false)
        {
            SetObjectInactive();
        }
    }

    void SetObjectInactive()
    {
        gameObject.SetActive(false);
    }
}
