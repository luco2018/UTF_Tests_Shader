using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class SceneLayoutTools
{

	public static void DoSomething (string str)
	{
		if (Selection.activeObject)
			Debug.Log (str + Selection.activeGameObject.name);
	}
}
