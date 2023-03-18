using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.InputSystem.EnhancedTouch;
using EnhancedTouch = UnityEngine.InputSystem.EnhancedTouch;
using TMPro;
using UnityEngine.UI;

[RequireComponent(typeof(ARRaycastManager), typeof(ARPlaneManager))]
public class ScanManager : MonoBehaviour
{
    [SerializeField]
    private GameObject preFab;

    public ARRaycastManager aRRaycastManager;
    public ARPlaneManager aRPlaneManager;
    private List<ARRaycastHit> hits = new List<ARRaycastHit>();
    private List<Vector3> detectedPlanePositions = new List<Vector3>();
    public GameObject IntroText;
    public GameObject ResetButton;
    private GameObject TutoBot;
    public Transform target; // The target object to look at

    //Tutorial Bot
    public string[] Instructions;
    private int currentIndex = 0;
    private bool TextOn = true;
    public TextMeshProUGUI textMeshPro;
    private string BotTextmesh;


    public List<Vector3> DetectedPlanePositions
    {
        get { return detectedPlanePositions; }
    }

    private void Awake()
    {
        ResetButton.SetActive(false);
        //aRRaycastManager = GetComponent<ARRaycastManager>();
        //aRPlaneManager = GetComponent<ARPlaneManager>();
    }

    private void OnEnable()
    {
        EnhancedTouch.EnhancedTouchSupport.Enable();
        EnhancedTouch.Touch.onFingerDown += FingerDown;
    }

    private void OnDisable()
    {
        EnhancedTouch.EnhancedTouchSupport.Disable();
        EnhancedTouch.Touch.onFingerDown -= FingerDown;
    }

    private void FingerDown(EnhancedTouch.Finger finger)
    {
        if (finger.index != 0) return;

        if (TutoBot == null)
        {
            if (aRRaycastManager.Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
            {
                foreach (ARRaycastHit hit in hits)
                {
                    Pose pose = hit.pose;
                    TutoBot = Instantiate(preFab, pose.position, pose.rotation);
                    BotTextmesh = TutoBot.GetComponent<TextMeshProUGUI>().text;

                    foreach (var plane in aRPlaneManager.trackables)
                    {
                        //plane.gameObject.SetActive(false);
                        Destroy(plane.gameObject);
                    }
                    aRPlaneManager.enabled = false;
                    //IntroText.SetActive(false);
                    //OnDisable();
                }
            }
        }

        else
        {
            BotTextmesh = "wrking";
        }

    }

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if(TutoBot!= null)
        {
            // Calculate the direction from this object to the target object
            Vector3 direction = target.position - TutoBot.transform.position;
            direction.y = 0;

            // Rotate this object to face the target direction
            TutoBot.transform.rotation = Quaternion.LookRotation(direction, Vector3.up);
        }
    }

    public void PlaneOn()
    {
        aRPlaneManager.enabled = true;
    }

    public void ResetOn()
    {
        ResetButton.SetActive(true);
    }

    public void Reset()
    {
        foreach (var plane in aRPlaneManager.trackables)
        {
            Destroy(plane.gameObject);
        }
        aRPlaneManager.enabled = false;

        aRPlaneManager.enabled = true;
    }
}
