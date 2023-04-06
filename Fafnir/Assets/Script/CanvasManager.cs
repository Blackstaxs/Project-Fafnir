using UnityEngine;
using UnityEngine.UI;

public class CanvasManager : MonoBehaviour
{
    private Camera arCamera;
    private Canvas canvas;

    void Start()
    {
        arCamera = GetComponent<Camera>();
        canvas = GetComponentInChildren<Canvas>();
    }

    void Update()
    {
        canvas.transform.position = arCamera.transform.position + arCamera.transform.forward * 0.5f;
        canvas.transform.rotation = arCamera.transform.rotation;
    }
}
