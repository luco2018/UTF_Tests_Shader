using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InfoTexts : MonoBehaviour
{
    private GameObject[] golist;

	// Use this for initialization
	void Start ()
    {

        UpdateList();

    }
	
    public void UpdateList()
    {
        golist = GameObject.FindGameObjectsWithTag("InfoCam");

        for (int i = 0; i < golist.Length; i++)
        {
            golist[i].SetActive(false);
        }
    }

    public void ShowInfoText()
    {
        for (int i = 0; i < golist.Length; i++)
        {
            golist[i].SetActive(true);
        }
    }
}
