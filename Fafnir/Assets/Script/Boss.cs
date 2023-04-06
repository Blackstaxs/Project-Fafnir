using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Device;
using UnityEngine.UIElements;
using UnityEngine.UI;

public class Boss : MonoBehaviour
{
    [SerializeField]
    private GameObject BluePart;

    [SerializeField]
    private GameObject RedPart;

    [SerializeField]
    private GameObject GreenPart;

    [SerializeField]
    private GameObject YellowPart;

    [SerializeField]
    private GameObject ShieldPart;

    [SerializeField]
    private GameObject ProjectilePrefab;

    [SerializeField]
    private GameObject FakeProjectile;

    [SerializeField]
    private GameObject HugeProjectile;

    private Vector3 playerPosition;
    private Vector3 projectileDirection;
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();
    public Dictionary<ulong, Vector3> usedPoints = new Dictionary<ulong, Vector3>();
    private float projectileForce = 2.0f;
    private int BossHp = 30;
    public GameObject spawn1;
    public GameObject spawn2;
    public GameObject spawn3;
    public GameObject spawn4;
    public GameObject spawn5;
    public GameObject spawn6;
    public GameObject spawn7;
    public GameObject spawn8;

    private int CheckRepeat = 0;
    public AudioSource audioSource;
    public AudioClip DamageSound;
    public AudioClip DeathSound;
    public AudioClip TPSound;

    // Start is called before the first frame update
    void Start()
    {
        //GreenAttack();
        //InvokeRepeating("RedAttack", 0f, 2f);
        int randomIndex = Random.Range(0, 4);
        randomAttack(randomIndex);
    }

    private void Awake()
    {
        SavedPoints = PlayerManager.instance.GetSavedPoints();

        RedPart.SetActive(false);
        GreenPart.SetActive(false);
        YellowPart.SetActive(false);
        BluePart.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        playerPosition = PlayerManager.instance.GetPlayerPosition();
        projectileDirection = (playerPosition - transform.position).normalized;
        //projectileDirection.y = 0;
        transform.rotation = Quaternion.LookRotation(projectileDirection, Vector3.up) * Quaternion.Euler(0, -90, 0);
    }

    public void BlueAttack()
    {
        BluePart.SetActive(true);
        int halfCount = SavedPoints.Count / 2;
        List<ulong> keys = new List<ulong>(SavedPoints.Keys);

        for (int i = 0; i < halfCount; i++)
        {
            int randomIndex = Random.Range(0, keys.Count);
            ulong randomKey = keys[randomIndex];
            keys.RemoveAt(randomIndex);

            Vector3 randomValue = SavedPoints[randomKey];
            usedPoints.Add(randomKey, randomValue);
        }

        foreach (Vector3 position in usedPoints.Values)
        {
            GameObject projectileInstance = Instantiate(ProjectilePrefab, position, Quaternion.identity);
            Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
            projectileRb.AddForce(Vector3.up * projectileForce, ForceMode.Impulse);
        }
        usedPoints.Clear();

    }

    private void InstAttack(Transform InitialPosition, GameObject bulletPre)
    {
        if(bulletPre == ProjectilePrefab)
        {
            Vector3 NewDirection = (playerPosition - InitialPosition.position).normalized;
            GameObject projectileInstance = Instantiate(bulletPre, InitialPosition.position, Quaternion.identity);
            Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
            projectileRb.AddForce(NewDirection * projectileForce * 2.0f, ForceMode.Impulse);
        }
        else if (bulletPre == FakeProjectile)
        {
            Vector3 NewDirection = Random.insideUnitSphere.normalized;
            GameObject projectileInstance = Instantiate(bulletPre, InitialPosition.position, Quaternion.identity);
            Rigidbody projectileRb = projectileInstance.GetComponent<Rigidbody>();
            projectileRb.AddForce(NewDirection * projectileForce * 2.0f, ForceMode.Impulse);
        }
    }

    IEnumerator GreenAttackCoroutine(float CoolD)
    {
        GreenPart.SetActive(true);

        InstAttack(spawn1.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn2.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn3.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn4.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn5.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn6.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn7.transform, ProjectilePrefab);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn8.transform, ProjectilePrefab);
    }

    public void GreenAttack()
    {
        StartCoroutine(GreenAttackCoroutine(0.2f));
    }

    IEnumerator YellowAttackCoroutine(float CoolD)
    {
        YellowPart.SetActive(true);

        InstAttack(spawn1.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn2.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn3.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn4.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn5.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn6.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn7.transform, FakeProjectile);
        yield return new WaitForSeconds(CoolD);

        InstAttack(spawn8.transform, FakeProjectile);
    }

    public void YellowAttack()
    {
        StartCoroutine(YellowAttackCoroutine(0.2f));
    }

    public void RedAttack()
    {
        RedPart.SetActive(true);
        YellowAttackCoroutine(0.5f);
        BlueAttack();
        StartCoroutine(GreenAttackCoroutine(0.3f));
    }

    IEnumerator ToggleShieldPart()
    {
        // Deactivate ShieldPart after 2 seconds
        yield return new WaitForSeconds(3.0f);
        ShieldPart.SetActive(false);

        // Reactivate ShieldPart after 2 more seconds
        yield return new WaitForSeconds(2.0f);
        ShieldPart.SetActive(true);
    }

    public void TakeDamage()
    {
        BossHp -= 5;
        PlayDamageSound();

        if(BossHp <= 0 ) 
        {
            PlayDeathSound();
            PlayerManager.instance.EndGame();
            CancelInvoke("RedAttack");
            CancelInvoke("BlueAttack");
            CancelInvoke("GreenAttack");
            CancelInvoke("YellowAttack");
            gameObject.SetActive(false);
        }
    }

    private IEnumerator NextPhase()
    {
        yield return new WaitForSeconds(4.0f);
        CancelInvoke("RedAttack");
        CancelInvoke("BlueAttack");
        CancelInvoke("GreenAttack");
        CancelInvoke("YellowAttack");
        RedPart.SetActive(false);
        GreenPart.SetActive(false);
        YellowPart.SetActive(false);
        BluePart.SetActive(false);
        BossTP();
    }

    public void BossTP()
    {
        // Get a random key from the dictionary
        List<ulong> keys = new List<ulong>(SavedPoints.Keys);

        ulong randomKey = keys[Random.Range(0, keys.Count)];

        // Get the position associated with the random key
        Vector3 randomPosition = SavedPoints[randomKey];
        Vector3 TestPosition = new Vector3(randomPosition.x, PlayerManager.instance.GetPlayerPosition().y, randomPosition.z);
        Vector3 playerPosition = PlayerManager.instance.GetPlayerPosition();
        Vector3 directionToPlayer = (playerPosition - randomPosition).normalized;
        Vector3 MovePosition = TestPosition + 0.2f * directionToPlayer;
        transform.position = MovePosition;
        usedPoints.Clear();
        int randomIndex = Random.Range(0, 4);
        while (randomIndex == CheckRepeat)
        {
            randomIndex = Random.Range(0, 4);
        }
        randomAttack(randomIndex);
        CheckRepeat = randomIndex;
    }

    public void KeepRed()
    {
        InvokeRepeating("RedAttack", 0f, 2f);
    }

    public void KeepBlue()
    {
        InvokeRepeating("BlueAttack", 0f, 2f);
    }
    public void KeepYellow()
    {
        InvokeRepeating("YellowAttack", 0f, 2f);
    }
    public void KeepGreen()
    {
        InvokeRepeating("GreenAttack", 0f, 2f);
    }

    public void randomAttack(int attacktype)
    {
        switch (attacktype)
        {
            case 0:
                KeepRed();
                StartCoroutine(NextPhase());
                StartCoroutine(ToggleShieldPart());
                break;
            case 1:
                KeepBlue();
                StartCoroutine(NextPhase());
                StartCoroutine(ToggleShieldPart());
                break;
            case 2:
                KeepYellow();
                StartCoroutine(NextPhase());
                StartCoroutine(ToggleShieldPart());
                break;
            case 3:
                KeepGreen();
                StartCoroutine(NextPhase());
                StartCoroutine(ToggleShieldPart());
                break;
            default:
                Debug.LogError("Invalid attack type specified");
                return;
        }
    }

    private void PlayDamageSound()
    {
        audioSource.PlayOneShot(DamageSound);
    }

    private void PlayDeathSound()
    {
        audioSource.PlayOneShot(DeathSound);
    }

    private void PlayTPSound()
    {
        audioSource.PlayOneShot(TPSound);
    }
}
