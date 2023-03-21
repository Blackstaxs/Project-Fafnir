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
public class PlaceObject : MonoBehaviour
{
    [SerializeField]
    private GameObject preFab;

    [SerializeField]
    private GameObject WallEdge;

    [SerializeField]
    private GameObject wallPrefab;

    [SerializeField]
    private ARRaycastManager aRRaycastManager;

    [SerializeField]
    private ARPlaneManager aRPlaneManager;

    [SerializeField]
    private ARPointCloudManager aRPointCloudManager;

    [SerializeField]
    private GameObject SessionAR;

    //private List<ARRaycastHit> hits = new List<ARRaycastHit>();
    private List<Vector3> detectedPlanePositions = new List<Vector3>();
    public GameObject IntroText;
    public GameObject ResetButton;
    public GameObject PlaneButton;
    public GameObject CloudScanButton;
    public GameObject AttackButton;
    private GameObject ScanBot;
    private GameObject Point1;
    public Transform target; // The target object to look at
    private int Phasecheck = 0;
    private int currentIndex = 0;

    private List<GameObject> points = new List<GameObject>();
    static List<ARRaycastHit> hits = new List<ARRaycastHit>();
    private bool DetectionOn = false;


    public List<Vector3> DetectedPlanePositions
    {
        get { return detectedPlanePositions; }
    }

    private void Awake()
    {
        ResetButton.SetActive(false);
        PlaneButton.SetActive(false);
        CloudScanButton.SetActive(false);
        AttackButton.SetActive(true);
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

        if(Phasecheck== 0) //Place Tutorial Bot
        {
            if (aRRaycastManager.Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
            {
                foreach (ARRaycastHit hit in hits)
                {
                    Pose pose = hit.pose;
                    ScanBot = Instantiate(preFab, pose.position, pose.rotation);

                    if (ScanBot.GetComponent<ARAnchor>() == null)
                    {
                        ScanBot.AddComponent<ARAnchor>();
                    }

                    foreach (var plane in aRPlaneManager.trackables)
                    {
                        plane.gameObject.SetActive(false);
                        //Destroy(plane.gameObject);
                    }
                    IntroOff();
                    Phasecheck = 1;
                }
            }
        }

        if(Phasecheck == 1) //Bot Instructions
        {
            ScanBot.GetComponent<TutoBot>().UpdateWallText();
            currentIndex += 1;

            if(currentIndex >= 5)
            {
                Phasecheck = 2;
                PlaneOn();
            }
        }

        if (Phasecheck == 2) //Placing Walls
        {
            if (aRRaycastManager.Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
            {
                Pose pose = hits[0].pose;
                GameObject newPoint = Instantiate(WallEdge, pose.position, pose.rotation);
                points.Add(newPoint);

                if (points.Count == 2)
                {
                    CreateWall(points[0].transform.position, points[1].transform.position);
                }
                if (points.Count == 3)
                {
                    CreateWall(points[1].transform.position, points[2].transform.position);
                }
                if (points.Count == 4)
                {
                    CreateWall(points[2].transform.position, points[3].transform.position);
                    CreateWall(points[3].transform.position, points[0].transform.position);
                    //SaveRoom();
                    currentIndex = 0;
                    Phasecheck = 3;

                }
            }
        }

        if (Phasecheck == 3) //Test
        {
            foreach (var plane in aRPlaneManager.trackables)
            {
                plane.gameObject.SetActive(false);
                //Destroy(plane.gameObject);

            }

            aRPlaneManager.enabled = false;

            ScanBot.GetComponent<TutoBot>().UpdateCloudText();
            currentIndex += 1;

            if (currentIndex >= 5)
            {
                Phasecheck = 4;
            }
            
        }

        if (Phasecheck == 4) //Point Cloud Scan
        {
            aRPointCloudManager.enabled = true;
            SessionAR.GetComponent<SwitchPointCloudVisualizationMode>().enabled = true;
            SessionAR.GetComponent<TerrainGenerator>().enabled = true;
            CloudScanButton.SetActive(true);
        }
    }

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if(ScanBot != null)
        {
            // Calculate the direction from this object to the target object
            Vector3 direction = target.position - ScanBot.transform.position;
            direction.y = 0;

            // Rotate this object to face the target direction
            ScanBot.transform.rotation = Quaternion.LookRotation(direction, Vector3.up);
        }

        if((Phasecheck == 2) && (DetectionOn == false))
        {
            //PlaneOn();
            //ButtonsOn();
            //aRPointCloudManager.enabled = true;
            //SessionAR.GetComponent<SwitchPointCloudVisualizationMode>().enabled = true;
            //ButtonsOn();
        }

        if (Phasecheck == 3) //Point Cloud Scan
        {

            //aRPointCloudManager.enabled = true;
            //SessionAR.GetComponent<SwitchPointCloudVisualizationMode>().enabled = true;
        }
    }

    public void PlaneOn()
    {
        aRPlaneManager.enabled = true;
        DetectionOn = true;
    }

    public void PlaneOff()
    {
        foreach (var plane in aRPlaneManager.trackables)
        {
            plane.gameObject.SetActive(false);
            Destroy(plane.gameObject);
        }
        aRPlaneManager.enabled = false;
    }

    public void ButtonsOn()
    {
        ResetButton.SetActive(true);
        PlaneButton.SetActive(true);
    }

    public void ResetPlanes()
    {
        foreach (var plane in aRPlaneManager.trackables)
        {
            Destroy(plane.gameObject);
        }

        aRPlaneManager.enabled = false;
    }

    public void IntroOff()
    {
        aRPlaneManager.enabled = false;
        IntroText.SetActive(false);
        //OnDisable();
    }

    private void CreateWall(Vector3 point1, Vector3 point2)
    {
        Vector3 corner1 = point1;
        Vector3 corner2 = point2;

        float width = Vector3.Distance(corner1, corner2);

        Vector3 center = (corner1 + corner2) / 2f;

        Vector3 side1 = (corner2 - corner1).normalized;

        Quaternion platformRotation = Quaternion.LookRotation(side1, Vector3.up);

        GameObject newPlatform = Instantiate(wallPrefab, corner1, platformRotation);

        newPlatform.transform.localScale = new Vector3(1f, 2.5f, width);

        if (newPlatform.GetComponent<ARAnchor>() == null)
        {
            newPlatform.AddComponent<ARAnchor>();
        }
    }
}
