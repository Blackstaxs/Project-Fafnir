using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class EnemyAI : MonoBehaviour
{
    private Animator animator;
    private int EnemyHp = 20;
    private Vector3 playerPosition;
    private Vector3 projectileDirection;

    private float jumpHeight = 1f;
    private float jumpDuration = 2f;

    public GameObject projectilePrefab;
    private float projectileForce = 2.0f;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        JumpMove();
        InvokeRepeating("rangedAttack", 2f, 3f);
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

    void SetInactive()
    {
        gameObject.SetActive(false);
    }

    private IEnumerator SetInactiveAfterAnimation()
    {
        // Wait for the animation to finish playing
        yield return new WaitForSeconds(animator.GetCurrentAnimatorStateInfo(0).length/2);

        // Stop the InvokeRepeating method
        CancelInvoke("rangedAttack");


        // Set the game object to inactive
        gameObject.SetActive(false);
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Projectile"))
        {
            if(EnemyHp > 0)
            {
                // Play the animation
                animator.Play("Damage");
                EnemyHp -= 5;
            }
            if(EnemyHp <= 0) 
            {
                animator.Play("Die");
                StartCoroutine(SetInactiveAfterAnimation());
            }
        }
    }

    private void JumpMove()
    {
        animator.Play("Run");
        // Define the start and end positions of the jump
        Vector3 startPos = transform.position;
        Vector3 endPos = startPos + Vector3.up * jumpHeight;

        // Use DoTween to move the object up and down
        transform.DOMove(endPos, jumpDuration / 2f).SetEase(Ease.OutQuad).OnComplete(() =>
        {
            transform.DOMove(startPos, jumpDuration / 2f).SetEase(Ease.InQuad).OnComplete(() => JumpMove());
        });
    }

    private void rangedAttack()
    {
        animator.Play("Attack");
        Vector3 projectileDirection = (playerPosition - transform.position).normalized;

        // Add 1 unit in the direction of the player
        Vector3 spawnPosition = transform.position + projectileDirection * 0.5f;

        GameObject projectileInstance = Instantiate(projectilePrefab, spawnPosition, Quaternion.identity);
        Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
        projectileRb.AddForce(projectileDirection * projectileForce, ForceMode.Impulse);
    }
}
