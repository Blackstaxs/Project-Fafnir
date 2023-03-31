using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Bullet : MonoBehaviour
{
    public float timeToInactive = 10.0f; // The time in seconds before setting the object as inactive


    void Start()
    {
        Invoke("SetObjectInactive", timeToInactive);
    }


    void OnCollisionEnter(Collision collision)
    {
        SetObjectInactive();
    }

    void SetObjectInactive()
    {
        gameObject.SetActive(false);
    }
}

