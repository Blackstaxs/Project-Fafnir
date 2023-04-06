using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossPart : MonoBehaviour
{
    [SerializeField]
    private bool isYellow;

    [SerializeField]
    private bool isRed;

    [SerializeField]
    private bool isBlue;

    [SerializeField]
    private bool isGreen;

    [SerializeField]
    private GameObject MainBoss;

    private float damageCheck;
    private float lastDamageTime;
    private const float damageCooldown = 1.0f; // 1 second cooldown

    // Start is called before the first frame update
    void Start()
    {
        if (isRed)
        {
            damageCheck = 1;
        }

        else if (isBlue)
        {
            damageCheck = 1.05f;
        }

        else if (isGreen)
        {
            damageCheck = 0.95f;
        }

        else if (isYellow)
        {
            damageCheck = 0.9f;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    {
        Rigidbody collisionRigidbody = collision.gameObject.GetComponent<Rigidbody>();

        if (collisionRigidbody.mass == damageCheck)
        {
            if (collision.gameObject.CompareTag("Projectile"))
            {
                MainBoss.GetComponent<Boss>().TakeDamage();
            }
        }
    }
}
