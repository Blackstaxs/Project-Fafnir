using UnityEngine;

public class FollowCamera : MonoBehaviour
{
    [SerializeField]
    private Camera arCamera;

    private void LateUpdate()
    {
        // Set the position of the canvas to match the position of the AR camera
        transform.position = arCamera.transform.position;

        // Set the rotation of the canvas to match the rotation of the AR camera
        transform.rotation = arCamera.transform.rotation;
    }
}

