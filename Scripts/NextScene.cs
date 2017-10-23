using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class NextScene : MonoBehaviour
{
	void Start ()
	{
		DontDestroyOnLoad (this.gameObject);
		SceneManager.LoadScene (1);
	}

	void Update ()
	{
		if (Input.touchCount > 0 && Input.GetTouch (0).tapCount == 2 && Input.GetTouch (0).phase == TouchPhase.Ended || Input.GetKeyDown (KeyCode.Space)) {
			int sceneIndex = SceneManager.GetActiveScene ().buildIndex;
			if (sceneIndex < SceneManager.sceneCountInBuildSettings - 1)
				SceneManager.LoadScene (sceneIndex + 1);
			else
				SceneManager.LoadScene (1);
		}
	}
}
