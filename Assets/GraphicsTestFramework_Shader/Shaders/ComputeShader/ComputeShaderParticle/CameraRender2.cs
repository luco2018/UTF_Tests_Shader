using UnityEngine;
using System.Collections;

public class CameraRender2 : MonoBehaviour 
{
	void OnRenderObject()
	{
		if (TestParticle2.list != null)
			foreach(TestParticle2 particle in TestParticle2.list)
				particle.Render();
	}
}
