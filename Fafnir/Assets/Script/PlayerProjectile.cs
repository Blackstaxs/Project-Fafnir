using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TouchPhase = UnityEngine.TouchPhase;

public class PlayerProjectile : MonoBehaviour
{
    // Start is called before the first frame update
    // GameObject ArCamera;
    //public GameObject playerProjectile;
    //public float shootForce = 500f;

    protected InputAction m_PressAction;

    [SerializeField]
    Rigidbody m_Projectile1;

    [SerializeField]
    Rigidbody m_Projectile2;

    [SerializeField]
    Rigidbody m_Projectile3;

    [SerializeField]
    Rigidbody m_Projectile4;

    [SerializeField]
    GameObject ArCamera;

    //switch weapon
    private Vector2 StartPosition;
    private Vector2 CurrentPosition;
    private Vector2 EndPosition;
    public int AttackNumber = 1;
    private bool stopTouch = false;
    public float swipeRange;
    public float tapRange;



    public Rigidbody projectile1
    {
        get => m_Projectile1;
        set => m_Projectile1 = value;
    }

    public Rigidbody projectile2
    {
        get => m_Projectile2;
        set => m_Projectile2 = value;
    }

    public Rigidbody projectile3
    {
        get => m_Projectile3;
        set => m_Projectile3 = value;
    }

    public Rigidbody projectile4
    {
        get => m_Projectile4;
        set => m_Projectile4 = value;
    }

    [SerializeField]
    float m_InitialSpeed = 25;

    public float initialSpeed
    {
        get => m_InitialSpeed;
        set => m_InitialSpeed = value;
    }
    void Start()
    {
        
    }

    protected virtual void Awake()
    {

        m_PressAction = new InputAction("touch", binding: "<Pointer>/press");

        m_PressAction.started += ctx =>
        {
            if (ctx.control.device is Pointer device)
            {
                OnPressBegan(device.position.ReadValue());
            }
        };

        m_PressAction.performed += ctx =>
        {
            if (ctx.control.device is Pointer device)
            {
                OnPress(device.position.ReadValue());
            }
        };

        m_PressAction.canceled += _ => OnPressCancel();
    }

    protected virtual void OnEnable()
    {
        m_PressAction.Enable();
    }

    protected virtual void OnDisable()
    {
        m_PressAction.Disable();
    }

    protected virtual void OnDestroy()
    {
        m_PressAction.Dispose();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void attackTest(){ }

    protected virtual void OnPress(Vector3 position) { }

    public void OnPressBegan(Vector3 position)
    {
        //if (m_ProjectilePrefab == null)
        //    return;
        if(AttackNumber == 1)
        {
            var ray = ArCamera.GetComponent<Camera>().ScreenPointToRay(position);
            var projectile = Instantiate(m_Projectile1, ray.origin, Quaternion.identity);
            var rigidbody = projectile.GetComponent<Rigidbody>();
            rigidbody.velocity = ray.direction * m_InitialSpeed;
        }

        if (AttackNumber == 2)
        {
            var ray = ArCamera.GetComponent<Camera>().ScreenPointToRay(position);
            var projectile = Instantiate(m_Projectile2, ray.origin, Quaternion.identity);
            var rigidbody = projectile.GetComponent<Rigidbody>();
            rigidbody.velocity = ray.direction * m_InitialSpeed;
        }

        if (AttackNumber == 3)
        {
            var ray = ArCamera.GetComponent<Camera>().ScreenPointToRay(position);
            var projectile = Instantiate(m_Projectile3, ray.origin, Quaternion.identity);
            var rigidbody = projectile.GetComponent<Rigidbody>();
            rigidbody.velocity = ray.direction * m_InitialSpeed;
        }

        if (AttackNumber == 4)
        {
            var ray = ArCamera.GetComponent<Camera>().ScreenPointToRay(position);
            var projectile = Instantiate(m_Projectile4, ray.origin, Quaternion.identity);
            var rigidbody = projectile.GetComponent<Rigidbody>();
            rigidbody.velocity = ray.direction * m_InitialSpeed;
        }
    }

    protected virtual void OnPressCancel() { }

    /*
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
                    AttackNumber = 1;
                    stopTouch = true;
                }
                else if (Distance.x > swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    AttackNumber = 2;
                    stopTouch = true;
                }
                else if (Distance.y > swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    AttackNumber = 3;
                    stopTouch = true;
                }
                else if (Distance.y < -swipeRange)
                {
                    //PLayer.GetComponent<Player>().Dash();
                    AttackNumber = 4;
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
    */
}
