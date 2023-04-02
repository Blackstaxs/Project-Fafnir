using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using System.Linq;

public class EnemyAI : MonoBehaviour
{
    [SerializeField]
    private bool isYellow;

    [SerializeField]
    private bool isRed;

    [SerializeField]
    private bool isBlue;

    [SerializeField]
    private bool isGreen;

    private Animator animator;
    private int EnemyHp = 20;
    private Vector3 playerPosition;
    private Vector3 projectileDirection;

    private float jumpHeight = 1f;
    private float jumpDuration = 2f;
    private float RandomjumpDuration = 4f;

    public GameObject projectilePrefab;
    private float projectileForce = 2.0f;
    private float slowForce = 0.5f;

    Dictionary<ulong, Vector3> savedPoints = PlayerManager.instance.GetSavedPoints();

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        if(isRed)
        {
            JumpMove();
            InvokeRepeating("rangedAttack", 2f, 4f);
        }

        if (isBlue)
        {
            InvokeRepeating("volleyAttack", 2f, 4f);
        }

        if (isGreen)
        {
            DoRandomJumpMove();
            InvokeRepeating("rangedAttack", 2f, 4f);
        }

        if (isYellow)
        {
            RandomAirMove();
            InvokeRepeating("volleyAttack", 2f, 4f);
        }

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
        if (isRed)
        {
            CancelInvoke("rangedAttack");
        }

        if (isBlue)
        {
            CancelInvoke("volleyAttack");
        }

        if (isGreen)
        {
            CancelInvoke("rangedAttack");
        }

        if (isYellow)
        {
            CancelInvoke("volleyAttack");
        }


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

    private void DoRandomJumpMove()
    {
        animator.Play("Jump");
        Vector3 randomPoint = savedPoints.ElementAt(Random.Range(0, savedPoints.Count)).Value;

        // Define the start and end positions of the jump
        Vector3 startPos = transform.position;
        Vector3 endPos = randomPoint;

        // Use DoTween to move the object up and down
        transform.DOMove(endPos, RandomjumpDuration / 2f).SetEase(Ease.OutQuad).OnComplete(() =>
        {
            transform.DOMove(startPos, RandomjumpDuration / 2f).SetEase(Ease.InQuad).OnComplete(() => DoRandomJumpMove());
        });
    }

    private void RandomAirMove()
    {
        animator.Play("Jump");
        Vector3 randomPoint = savedPoints.ElementAt(Random.Range(0, savedPoints.Count)).Value;

        // Define the start and end positions of the jump
        Vector3 startPos = transform.position;
        Vector3 endPos = randomPoint + Vector3.up * jumpHeight;

        // Use DoTween to move the object up and down
        transform.DOMove(endPos, RandomjumpDuration / 2f).SetEase(Ease.OutQuad).OnComplete(() =>
        {
            transform.DOMove(startPos, RandomjumpDuration / 2f).SetEase(Ease.InQuad).OnComplete(() => RandomAirMove());
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

    private void rangedAttack360()
    {
        //animator.Play("Attack360");

        // Get a random direction in which to spawn the projectiles
        Vector3 spawnDirection = Random.insideUnitSphere.normalized;

        // Add 1 unit in the direction of the player
        Vector3 spawnPosition = transform.position + spawnDirection * 0.8f;

        // Spawn the projectiles in random directions
        for (int i = 0; i < 4; i++)
        {
            Vector3 projectileDirection = Random.insideUnitSphere.normalized;

            GameObject projectileInstance = Instantiate(projectilePrefab, spawnPosition, Quaternion.identity);
            Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
            projectileRb.AddForce(projectileDirection * slowForce, ForceMode.Impulse);
        }
        animator.Play("Attack");
    }

    private void volleyAttack()
    {
        animator.Play("Attack");
        Vector3 projectileDirection = (playerPosition - transform.position).normalized;

        Vector3 FrontspawnPosition = transform.position + projectileDirection * 0.5f;

        // Create the first projectile in the direction of the player
        GameObject projectileInstance = Instantiate(projectilePrefab, FrontspawnPosition, Quaternion.identity);
        Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
        projectileRb.AddForce(projectileDirection * projectileForce, ForceMode.Impulse);

        // Create the second projectile to the left of the first one
        Quaternion leftRotation = Quaternion.AngleAxis(-15f, Vector3.up);
        Vector3 leftDirection = leftRotation * projectileDirection;
        Vector3 leftSpawnPosition = transform.position + leftDirection * 0.5f;
        GameObject leftProjectileInstance = Instantiate(projectilePrefab, leftSpawnPosition, Quaternion.identity);
        Rigidbody leftProjectileRb = leftProjectileInstance.GetComponent<Rigidbody>();
        leftProjectileRb.AddForce(leftDirection * projectileForce, ForceMode.Impulse);

        // Create the third projectile to the right of the first one
        Quaternion rightRotation = Quaternion.AngleAxis(15f, Vector3.up);
        Vector3 rightDirection = rightRotation * projectileDirection;
        Vector3 rightSpawnPosition = transform.position + rightDirection * 0.5f;
        GameObject rightProjectileInstance = Instantiate(projectilePrefab, rightSpawnPosition, Quaternion.identity);
        Rigidbody rightProjectileRb = rightProjectileInstance.GetComponent<Rigidbody>();
        rightProjectileRb.AddForce(rightDirection * projectileForce, ForceMode.Impulse);
    }
}
