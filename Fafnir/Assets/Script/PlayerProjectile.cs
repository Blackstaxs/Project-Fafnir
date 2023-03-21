using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerProjectile : MonoBehaviour
{
    // Start is called before the first frame update
    // GameObject ArCamera;
    //public GameObject playerProjectile;
    //public float shootForce = 500f;

    protected InputAction m_PressAction;

    [SerializeField]
    Rigidbody m_ProjectilePrefab;

    [SerializeField]
    GameObject ArCamera;

    public Rigidbody projectilePrefab
    {
        get => m_ProjectilePrefab;
        set => m_ProjectilePrefab = value;
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
        /*
        if(Input.touchCount > 0 && Input.GetTouch(0).phase ==TouchPhase.Began)
        {
            GameObject bullet = Instantiate(playerProjectile, ArCamera.position, ArCamera.rotation);
            bullet.GetComponent<Rigidbody>().AddForce(ArCamera.forward * shootForce);
        }
        */
    }

    public void attackTest()
    {
        //GameObject bullet = Instantiate(playerProjectile, ArCamera.position, ArCamera.rotation);
        //bullet.GetComponent<Rigidbody>().AddForce(ArCamera.forward * shootForce);
    }

    protected virtual void OnPress(Vector3 position) { }

    public void OnPressBegan(Vector3 position)
    {
        if (m_ProjectilePrefab == null)
            return;

        var ray = ArCamera.GetComponent<Camera>().ScreenPointToRay(position);
        var projectile = Instantiate(m_ProjectilePrefab, ray.origin, Quaternion.identity);
        var rigidbody = projectile.GetComponent<Rigidbody>();
        rigidbody.velocity = ray.direction * m_InitialSpeed;

    }

    protected virtual void OnPressCancel() { }
}
