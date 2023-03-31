using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;

public class SwipeDetection : MonoBehaviour 
{
	public static SwipeDetection instance;
	public delegate void Swipe(Vector2 direction);
	public event Swipe swipePerformed;
    public Text TestSwipe;
    public bool isDetectOn = false;
    public bool introEnd = false;

    [SerializeField] private InputAction position, press;
	[SerializeField] private float swipeResistance = 10;

	private Vector2 initialPos;
	private Vector2 currentPos => position.ReadValue<Vector2>();

	private int attack_number = 0;

	public int AttackNumber { get { return attack_number; } }

	private void Awake () 
	{
		position.Enable();
		press.Enable();	
		press.performed += _ => { initialPos = currentPos; };
		press.canceled += _ => DetectSwipe();
		instance = this;
	}

    private void DetectSwipe()
    {
        Vector2 delta = currentPos - initialPos;
        Vector2 direction = Vector2.zero;
        if (isDetectOn == true)
        {

            if (Mathf.Abs(delta.x) > Mathf.Abs(delta.y) && Mathf.Abs(delta.x) > swipeResistance)
            {
                direction.x = Mathf.Sign(delta.x);
                TestSwipe.text = (direction.x > 0) ? "derecha" : "izquierda";
                attack_number = (direction.x > 0) ? 3 : 1;
                if (introEnd == true)
                {
                    if (attack_number == 1)
                    {
                        int currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
                        SceneManager.LoadScene(currentSceneIndex);
                        //introEnd = false;
                    }

                    if (attack_number == 3)
                    {
                        GetComponent<LevelStart>().enabled = true;
                        GetComponent<PlayerProjectile>().enabled = true;
                        introEnd = false;
                    }
                }
                GetComponent<PlayerProjectile>().AttackNumber = attack_number;
            }
            else if (Mathf.Abs(delta.y) > Mathf.Abs(delta.x) && Mathf.Abs(delta.y) > swipeResistance)
            {
                direction.y = Mathf.Sign(delta.y);
                TestSwipe.text = (direction.y > 0) ? "arriba" : "abajo";
                attack_number = (direction.y > 0) ? 2 : 4;
                GetComponent<PlayerProjectile>().AttackNumber = attack_number;
            }

            if (direction != Vector2.zero && swipePerformed != null)
            {
                swipePerformed(direction);
            }
        }
        
    }
}

