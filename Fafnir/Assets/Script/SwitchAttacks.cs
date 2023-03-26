using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.XR.ARFoundation;

public class SwitchAttacks : MonoBehaviour
{
    // Start is called before the first frame update

    //switch weapon
    private Vector2 StartPosition;
    private Vector2 CurrentPosition;
    public int SkillNumber = 1;
    private Vector2 EndPosition;
    private bool stopTouch = false;
    public float swipeRange;
    public float tapRange;
    public Text TestSwipe;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Swiping();
    }

    private void Awake()
    {
        GetComponent<PlayerProjectile>().enabled = false;
    }

    public void AttackOn()
    {
        GetComponent<PlayerProjectile>().enabled = true;
        GetComponent<PlayerProjectile>().AttackNumber = SkillNumber;
        TestSwipe.text = "cambio";
    }

    public void Swiping()
    {
        if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Began)
        {
            StartPosition = Input.GetTouch(0).position;
        }

        if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Moved)
        {
            CurrentPosition = Input.GetTouch(0).position;
            Vector2 Distance = CurrentPosition - StartPosition;

            if (!stopTouch)
            {
                if (Distance.x < -swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    //GetComponent<PlayerProjectile>().AttackNumber = 1;
                    TestSwipe.text = "derecha";
                    SkillNumber = 1;
                    stopTouch = true;
                }
                else if (Distance.x > swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    TestSwipe.text = "izquierda";
                    SkillNumber = 2;
                    //GetComponent<PlayerProjectile>().AttackNumber = 2;
                    stopTouch = true;
                }
                else if (Distance.y > swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    //GetComponent<PlayerProjectile>().AttackNumber = 3;
                    TestSwipe.text = "arriba";
                    SkillNumber = 3;
                    stopTouch = true;
                }
                else if (Distance.y < -swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    //GetComponent<PlayerProjectile>().AttackNumber = 4;
                    TestSwipe.text = "abajo";
                    SkillNumber = 4;
                    stopTouch = true;
                }
            }
        }

        if (Input.touchCount > 0 && Input.GetTouch(0).phase == TouchPhase.Ended)
        {
            stopTouch = false;
            EndPosition = Input.GetTouch(0).position;
        }
    }
}
