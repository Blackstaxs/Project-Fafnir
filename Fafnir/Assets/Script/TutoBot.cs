using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.InputSystem.HID;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using EnhancedTouch = UnityEngine.InputSystem.EnhancedTouch;

public class TutoBot : MonoBehaviour
{
    public TextMeshProUGUI textMeshPro;
    public string[] Instructions;
    private int currentIndex = 0;
    private bool TextOn = true;
    private GameObject Intro;
    private GameObject SessionAR;
    private ARRaycastManager SessionRaycast;

    //private GameObject SessionRaycast;
    private GameObject ARwall;

    static List<ARRaycastHit> hits = new List<ARRaycastHit>();
    public GameObject pointPrefab;

    private void Start()
    {

    }
    
    private void OnEnable()
    {
        //EnhancedTouch.EnhancedTouchSupport.Enable();
        //EnhancedTouch.Touch.onFingerDown += FingerDown;

        Intro = GameObject.Find("Intro");
        SessionAR = GameObject.Find("AR Session Origin");
        SessionRaycast = SessionAR.GetComponent<ARRaycastManager>();
        //SessionAR.GetComponent<ARPlaneManager>().enabled = true;
    }
    /*
    private void OnDisable()
    {
        EnhancedTouch.EnhancedTouchSupport.Disable();
        EnhancedTouch.Touch.onFingerDown -= FingerDown;
    }
    
    private void FingerDown(EnhancedTouch.Finger finger)
    {
        if (TextOn == true)
        {
            if (finger.index != 0) return;

            UpdateText();

            currentIndex = (currentIndex + 1) % Instructions.Length;

            if (currentIndex >= 5)
            {
                TextOn = false;

                Intro.GetComponent<PlaceObject>().ButtonsOn();

                //if (SessionAR.GetComponent<ARRaycastManager>().Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
                if (SessionRaycast.Raycast(finger.currentTouch.screenPosition, hits, TrackableType.PlaneWithinPolygon))
                {
                    //Pose hitPose = hits[0].pose;
                    //GameObject newPoint = Instantiate(pointPrefab, hitPose.position, Quaternion.identity);

                    foreach (ARRaycastHit hit in hits)
                    {
                        Pose pose = hit.pose;
                        GameObject newPoint = Instantiate(pointPrefab, pose.position, pose.rotation);
                    }
                }
            }
        }
    }
    */
    
    public void UpdateText()
    {
        textMeshPro.text = Instructions[currentIndex];
        currentIndex = (currentIndex + 1) % Instructions.Length;
    }
}
