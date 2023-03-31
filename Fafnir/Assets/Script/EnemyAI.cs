using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAI : MonoBehaviour
{
    private Animator animator;
    private int EnemyHp = 20;
    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void SetInactive()
    {
        gameObject.SetActive(false);
    }

    private IEnumerator SetInactiveAfterAnimation()
    {
        // Wait for the animation to finish playing
        yield return new WaitForSeconds(animator.GetCurrentAnimatorStateInfo(0).length/2);

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
}
