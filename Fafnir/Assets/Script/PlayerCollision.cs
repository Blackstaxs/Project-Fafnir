using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PlayerCollision : MonoBehaviour
{
    public Image LeftDamage;
    public Image RightDamage;
    public Image FrontDamage;

    [SerializeField]
    private bool isLeft;

    [SerializeField]
    private bool isRight;

    [SerializeField]
    private bool isFront;

    private float flashTime = 0.2f; // The duration of each flash
    private int numFlashes = 2; // The number of flashes to do
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private void Awake()
    {
        LeftDamage.enabled= false;
        RightDamage.enabled= false; 
        FrontDamage.enabled= false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator FlashImage(Image image)
    {
        for (int i = 0; i < numFlashes; i++)
        {
            image.enabled = true;
            yield return new WaitForSeconds(flashTime);
            image.enabled = false;
            yield return new WaitForSeconds(flashTime);
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Enemy"))
        {
            if (isFront)
            {
                PlayerManager.instance.TakeDamage();
                StartCoroutine(FlashImage(FrontDamage));
            }
            if (isRight)
            {
                PlayerManager.instance.TakeDamage();
                StartCoroutine(FlashImage(RightDamage));
            }
            if (isLeft)
            {
                PlayerManager.instance.TakeDamage();
                StartCoroutine(FlashImage(LeftDamage));
            }   
        }
    }
}
