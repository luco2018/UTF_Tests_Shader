using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleObjects : MonoBehaviour 
{
	public GameObject[] gameobjects;

	public void showObject(int id)
	{
		for (int i = 0; i < gameobjects.Length; i++) 
		{
			if (i == id) 
			{
				gameobjects [i].SetActive (true);
			} 
			else 
			{
				gameobjects [i].SetActive (false);
			}
		}
	}
}
