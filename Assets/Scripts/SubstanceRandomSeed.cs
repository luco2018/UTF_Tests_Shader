using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SubstanceRandomSeed : MonoBehaviour
{
    public bool rebuild = true;
#if !UNITY_WEBGL
    private ProceduralMaterial subMat;

	// Use this for initialization
	void Start ()
	{
		subMat = GetComponent<MeshRenderer> ().material as ProceduralMaterial;
        //InvokeRepeating ("RandomSeed", 1f, 1f);
        if(rebuild)
        RandomSeed();

    }

	public void RandomSeed ()
	{
        //Debug.Log (subMat.name);
        //Debug.Log (subMat.HasProceduralProperty ("$randomseed").ToString ());
        //subMat.SetProceduralFloat ("$randomseed", Random.Range (0, 30));
        subMat.SetProceduralFloat("$randomseed", 15);
        subMat.RebuildTextures ();
	}
#endif
}
