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
    private int EnemyHp = 10;
    private Vector3 playerPosition;
    private Vector3 projectileDirection;

    private float jumpHeight = 1f;
    private float jumpDuration = 2f;
    private float RandomjumpDuration = 4f;

    public GameObject projectilePrefab;
    private float projectileForce = 2.0f;
    private float slowForce = 0.5f;

    private float lastDamageTime;
    private const float damageCooldown = 1.0f; // 1 second cooldown

    public GameObject SpawnPoint1;
    public GameObject SpawnPoint2;
    public GameObject SpawnPoint3;
    public GameObject SpawnPoint4;
    private float damageCheck;
    Dictionary<ulong, Vector3> savedPoints = new Dictionary<ulong, Vector3>();

    public AudioSource audioSource;
    public AudioClip DamageSound;
    public AudioClip DeathSound;
    private bool isDeath = false;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        if(isRed)
        {
            JumpMove();
            damageCheck = 1;
            InvokeRepeating("rangedAttack", 2f, 4f);
        }

        else if(isBlue)
        {
            damageCheck = 1.05f;
            InvokeRepeating("volleyAttack", 2f, 4f);
        }

        else if(isGreen)
        {
            DoRandomJumpMove();
            damageCheck = 0.95f;
            InvokeRepeating("rangedAttack", 2f, 4f);
        }

        else if(isYellow)
        {
            RandomAirMove();
            damageCheck = 0.9f;
            InvokeRepeating("rangedAttack360", 2f, 4f);
        }
    }

    private void Awake()
    {
        savedPoints = PlayerManager.instance.GetSavedPoints();
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

        else if (isBlue)
        {
            CancelInvoke("volleyAttack");
        }

        else if (isGreen)
        {
            CancelInvoke("rangedAttack");
        }

        else if(isYellow)
        {
            CancelInvoke("rangedAttack360");
        }


        // Set the game object to inactive
        gameObject.SetActive(false);
    }

    private void OnCollisionEnter(Collision collision)
    {
        Rigidbody collisionRigidbody = collision.gameObject.GetComponent<Rigidbody>();

        if (collisionRigidbody.mass == damageCheck)
        {
            if (collision.gameObject.CompareTag("Projectile"))
        {
            float currentTime = Time.time;
            if (EnemyHp > 0 && (currentTime - lastDamageTime) >= damageCooldown)
            {
                animator.Play("Damage");
                PlayDamageSound();
                EnemyHp -= 5;
                // Update the last damage time
                lastDamageTime = currentTime;
            }
            else if (EnemyHp <= 0) 
            {
                if(isDeath == false)
                    {
                        isDeath = true;
                        PlayerManager.instance.EnemyDeath();
                        PlayDeathSound();
                        animator.Play("Die");
                        StartCoroutine(SetInactiveAfterAnimation());
                    }
            }
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

    private void InstAttack(Transform InitialPosition, Vector3 instDirection)
    {
        GameObject projectileInstance = Instantiate(projectilePrefab, InitialPosition.position, Quaternion.identity);
        Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
        projectileRb.AddForce(instDirection * projectileForce, ForceMode.Impulse);
    }

    private void rangedAttack360()
    {
        animator.Play("Attack360");

        // Get a random direction in which to spawn the projectiles
        Vector3 spawnDirection = Random.insideUnitSphere.normalized;

        InstAttack(SpawnPoint1.transform, spawnDirection);
        InstAttack(SpawnPoint2.transform, spawnDirection);
        InstAttack(SpawnPoint3.transform, spawnDirection);
        InstAttack(SpawnPoint4.transform, spawnDirection);
    }

    private void volleyAttack()
    {
        animator.Play("Attack");
        Vector3 projectileDirection = (playerPosition - SpawnPoint1.transform.position).normalized;

        Vector3 FrontspawnPosition = SpawnPoint1.transform.position + projectileDirection * 0.5f;

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

    private void PlayDamageSound()
    {
        audioSource.PlayOneShot(DamageSound);
    }

    private void PlayDeathSound()
    {
        audioSource.PlayOneShot(DeathSound);
    }
}
