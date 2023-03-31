using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using UnityEngine.InputSystem.EnhancedTouch;
using EnhancedTouch = UnityEngine.InputSystem.EnhancedTouch;
using TMPro;
using UnityEngine.UI;
using System.Linq;
using System;

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
    private GameObject floorPrefab;

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
    public GameObject LogText;
    public GameObject ResetButton;
    public GameObject PlaneButton;
    public GameObject CloudScanButton;
    public GameObject AttackButton;
    private GameObject ScanBot;
    private GameObject Point1;
    public Transform target; // The target object to look at
    private int Phasecheck = 0;
    private int currentIndex = 0;

    //limit points
    private List<GameObject> points = new List<GameObject>();
    private List<Vector3> pointsPositions = new List<Vector3>();
    static List<ARRaycastHit> hits = new List<ARRaycastHit>();
    private bool DetectionOn = false;

    //all Points Scanned
    public Dictionary<ulong, Vector3> SavedPoints = new Dictionary<ulong, Vector3>();


    public List<Vector3> DetectedPlanePositions
    {
        get { return detectedPlanePositions; }
    }

    private void Awake()
    {
        ResetButton.SetActive(false);
        PlaneButton.SetActive(false);
        CloudScanButton.SetActive(false);
        AttackButton.SetActive(false);
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
                    }

                    IntroOff();
                    Phasecheck = 1;
                }
            }
        }

        if(Phasecheck == 1) //Instructions walls
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
                    //CreateWall(points[0].transform.position, points[1].transform.position);
                }
                if (points.Count == 3)
                {
                    //CreateWall(points[1].transform.position, points[2].transform.position);
                    
                }
                if (points.Count == 4)
                {
                    CreateRectangle(points[0].transform.position, points[1].transform.position, points[2].transform.position, points[3].transform.position);
                    currentIndex = 0;
                    Phasecheck = 3;

                }
            }
        }

        if (Phasecheck == 3) //Instructions scan
        {
            foreach (var plane in aRPlaneManager.trackables)
            {
                plane.gameObject.SetActive(false);
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

        if (Phasecheck == 5) //Confirmation step
        {
            ScanBot.GetComponent<TutoBot>().UpdateConfirmationText();
            currentIndex += 1;

            if (currentIndex >= 2)
            {
                Phasecheck = 6;
                GetComponent<SwipeDetection>().isDetectOn = true;
                GetComponent<SwipeDetection>().introEnd = true;
            }
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

    public void EndScan()
    {
        CloudScanButton.SetActive(false);

    }
    
    public void Spawntest()
    {
        if(SavedPoints != null)
        {
            //SavedPoints.Clear
            RemovePointsOutsideArea();
            foreach (var kvp in SavedPoints)
            {
                //ParticleSystem particle = Instantiate(particlePrefab, kvp.Value, Quaternion.identity);
                //particle.Play();
                GameObject newPoint = Instantiate(WallEdge, kvp.Value, Quaternion.identity);
            }

            foreach (GameObject point in points)
            {
                point.SetActive(false);
            }
        }
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

    public void RemovePointsOutsideArea()
    {
        List<ulong> keysToRemove = new List<ulong>();

        foreach (KeyValuePair<ulong, Vector3> savedPoint in SavedPoints)
        {
            if (!IsPointInsideArea(savedPoint.Value))
            {
                keysToRemove.Add(savedPoint.Key);
            }
        }

        foreach (ulong key in keysToRemove)
        {
            SavedPoints.Remove(key);
        }

        foreach (GameObject point in points)
        {
            point.SetActive(false);
        }
        EndScan();
        LogText.SetActive(false);
        currentIndex = 0;
        Phasecheck = 5;
    }

    private bool IsPointInsideArea(Vector3 point)
    {
        // use a polygon intersection algorithm to check if the point is inside the area
        bool inside = false;

        for (int i = 0, j = pointsPositions.Count - 1; i < pointsPositions.Count; j = i++)
        {
            if (((pointsPositions[i].z <= point.z && point.z < pointsPositions[j].z) ||
                 (pointsPositions[j].z <= point.z && point.z < pointsPositions[i].z)) &&
                (point.x < (pointsPositions[j].x - pointsPositions[i].x) * (point.z - pointsPositions[i].z) /
                 (pointsPositions[j].z - pointsPositions[i].z) + pointsPositions[i].x))
            {
                inside = !inside;
            }
        }

        return inside;
    }

    private void CreateRectangle(Vector3 point1, Vector3 point2, Vector3 point3, Vector3 point4)
    {
        Vector3 point3Adjusted = GetAdjustedPoint(point2, point1, point3);
        Vector3 point4Adjusted = GetAdjustedPoint(point1, point2, point4);

        // Check if point4Adjusted is perpendicular to both point3Adjusted and point2
        Vector3 v1 = (point3Adjusted - point2).normalized;
        Vector3 v2 = (point4Adjusted - point3Adjusted).normalized;

        /*
        if (Vector3.Dot(v1, v2) != 0)
        {
            Vector3 perpendicular = Vector3.Cross(v1, v2);
            float angle = Vector3.Angle(v1, perpendicular);
            point4Adjusted = Quaternion.AngleAxis(angle, Vector3.up) * (point3Adjusted - point2) + point3Adjusted;
        }
        */

        CreateWall(point1, point2);
        CreateWall(point1, point3Adjusted);
        CreateWall(point3Adjusted, point4Adjusted);
        CreateWall(point4Adjusted, point2);

        pointsPositions.Add(point1);
        pointsPositions.Add(point2);
        pointsPositions.Add(point3Adjusted);
        pointsPositions.Add(point4Adjusted);

        //update points adjusted
    }

    private Vector3 GetAdjustedPoint(Vector3 point1, Vector3 point2, Vector3 point3)
    {
        Vector3 dir = point2 - point1;
        Vector3 ortho = new Vector3(-dir.z, 0f, dir.x).normalized;

        float dot = Vector3.Dot(ortho, point3 - point2);
        return point2 + ortho * dot;
    }
}
