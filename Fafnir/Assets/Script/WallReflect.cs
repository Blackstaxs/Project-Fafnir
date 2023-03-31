using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WallReflect : MonoBehaviour
{
    public GameObject projectilePrefab;
    //private GameObject playerObject;
    public float projectileForce = 0.1f;

    private void Awake()
    {
        //playerObject = PlayerManager.instance.player;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Projectile"))
        {
            Vector3 playerPosition = PlayerManager.instance.GetPlayerPosition();
            Vector3 contactPoint = collision.contacts[0].point;
            Vector3 projectileDirection = (playerPosition - contactPoint).normalized;

            // Add 1 unit in the direction of the player
            Vector3 spawnPosition = contactPoint + projectileDirection * 1f;

            GameObject projectileInstance = Instantiate(projectilePrefab, spawnPosition, Quaternion.identity);
            Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
            projectileRb.AddForce(projectileDirection * projectileForce, ForceMode.Impulse);

        }
    }
}
