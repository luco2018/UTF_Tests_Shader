using UnityEngine;

[ExecuteInEditMode]
public class InfoCam : MonoBehaviour
{

    private Camera maincam;

    private Camera infocam;

    public LayerMask mask;
    public LayerMask everythingmask;

    void Start ()
    {
        GameObject exist = GameObject.Find("CameraInfo");
        if(exist != null)
        {
            DestroyImmediate(exist);
        }

		if(infocam == null)
        {
            createInfoCam();
        }
        if(Application.isPlaying)
        infocam.enabled = false;

    }

    private void createInfoCam()
    {
        maincam = Camera.main;
        maincam.cullingMask = everythingmask;
        maincam.cullingMask -= mask;

        GameObject camgo = Instantiate(maincam.gameObject, maincam.transform);
        camgo.transform.localPosition = Vector3.zero;
        camgo.transform.localRotation =Quaternion.Euler(Vector3.zero);
        camgo.transform.localScale = Vector3.one;
        camgo.tag = "InfoCam";
        camgo.name = "CameraInfo";
        infocam = camgo.GetComponent<Camera>();
        infocam.clearFlags = CameraClearFlags.Depth;
        infocam.depth = 1;
        infocam.cullingMask = mask;
        infocam.allowHDR = false;
        infocam.allowMSAA = false;
        infocam.useOcclusionCulling = false;
        infocam.renderingPath = RenderingPath.UsePlayerSettings;

        DestroyImmediate(camgo.GetComponent<InfoCam>());
        DestroyImmediate(camgo.GetComponent<GUILayer>());
        DestroyImmediate(camgo.GetComponent<FlareLayer>());
        DestroyImmediate(camgo.GetComponent<AudioListener>());
    }

}
