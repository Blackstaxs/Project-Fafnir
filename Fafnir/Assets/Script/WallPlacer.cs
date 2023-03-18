using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.SceneManagement;
using UnityEngine.InputSystem.EnhancedTouch;
using EnhancedTouch = UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.XR.ARSubsystems;

[Serializable]
public struct RoomInfo
{
    public Vector3 Point1;
    public Vector3 Point2;
    public Vector3 Point3;
    public Vector3 Point4;
}

public class WallPlacer : MonoBehaviour
{
    [SerializeField]
    private ARRaycastManager raycastManager;

    [SerializeField]
    private ARPlaneManager aRPlaneManager;

    [SerializeField]
    private GameObject pointPrefab;

    [SerializeField]
    private GameObject platformPrefab;

    [SerializeField]
    private GameObject wallPrefab;

    private List<GameObject> points = new List<GameObject>();

    private Vector2 touchPosition = default;

    static List<ARRaycastHit> hits = new List<ARRaycastHit>();

    private void Start()
    {

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

    private void CreateRoom(Vector3 point1, Vector3 point2, Vector3 point3, Vector3 point4)
    {
            CreateWall(point1, point2);
            CreateWall(point2, point3);
            CreateWall(point3, point4);
            CreateWall(point4, point1);
            //GetComponent<ARPlaneManager>().enabled = false;
    }

    public void SaveRoom()
    {
        if (points.Count != 4)
            return;

        var json = JsonUtility.ToJson(new RoomInfo()
        {
            Point1 = points[0].transform.position,
            Point2 = points[1].transform.position,
            Point3 = points[2].transform.position,
            Point4 = points[3].transform.position,
        });

        PlayerPrefs.SetString("room", json);
    }

    public void LoadRoom()
    {
        if (!PlayerPrefs.HasKey("room"))
            return;

        RoomInfo roomInfo = JsonUtility.FromJson<RoomInfo>(PlayerPrefs.GetString("room"));

        CreateRoom(roomInfo.Point1, roomInfo.Point2, roomInfo.Point3, roomInfo.Point4);
    }

    private void FingerDown(EnhancedTouch.Finger finger)
    {
        if (finger.index != 0) return;

        //Touch touch = Input.GetTouch(0);
        //touchPosition = touch.position;

        if (raycastManager.Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
        {
            Pose hitPose = hits[0].pose;
            GameObject newPoint = Instantiate(pointPrefab, hitPose.position, Quaternion.identity);
            points.Add(newPoint);

            if (points.Count == 2)
            {
                CreateWall(points[0].transform.position, points[1].transform.position);
            }
            else if (points.Count == 3)
            {
                CreateWall(points[1].transform.position, points[2].transform.position);
            }
            else if (points.Count == 4)
            {
                CreateWall(points[2].transform.position, points[3].transform.position);
                CreateWall(points[3].transform.position, points[0].transform.position);
                SaveRoom();

                foreach (var plane in GetComponent<ARPlaneManager>().trackables)
                {
                    plane.gameObject.SetActive(false);
                }
                GetComponent<ARPlaneManager>().enabled = false;
            }

            if (points.Count == 4)
            {
                return;
            }
        }
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
    }

    public void ResetBuilds()
    {
        //SceneManager.LoadScene(0);
        aRPlaneManager.enabled= true;
    }
}
