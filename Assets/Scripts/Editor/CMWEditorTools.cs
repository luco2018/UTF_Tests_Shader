using UnityEditor;
using UnityEngine;
using System.Linq;
using System.Collections.Generic;
using System;

/// <summary>
/// Hierarchy Organizer v1.0 
/// By Isaiah Kelly 
/// isaiah@dangerofdeath.com
/// </summary>

public class CMWEditorTools : EditorWindow
{
	public enum ORDER 
	{
		Ascending, 
		Descending
	}

	bool debugging = false;
	ORDER order = ORDER.Ascending;

	//***************/
	Vector2 scrollPosition;
	bool[] myfunctionlist = new bool[20];
	//***************/
	bool apply=false;
	bool revert=false;
	bool lastapply=false;
	bool lastrevert=false;
	//***************/
	string prefix;
	string suffix;
	string replace;
	string replace_By;
	string insert_Before;
	string insert_Before_Word;
	string insert_After;
	string insert_After_Word;
	//***************/
	GameObject useGameObject;
	//***************/
	string prefix2;
	string suffix2;
	string replace2;
	string replace_By2;
	string insert_Before2;
	string insert_Before_Word2;
	string insert_After2;
	string insert_After_Word2;
	//***************/
	float alignspacex;
	float alignspacey;
	float alignspacez;
	bool alignuseOrix = true;
	bool alignuseOriy = true;
	bool alignuseOriz = true;
	float aligncurrentx;
	float aligncurrenty;
	float aligncurrentz;
	bool alignuseOriAssign = false;
	//***************/
	int rounddp_P = 0;
	int rounddp_R = 0;
	int rounddp_S = 0;
	bool rounduseOriP = true;
	bool rounduseOriR = true;
	bool rounduseOriS = true;
	/****************/
	Vector3 transformcopy_p;
	Quaternion transformcopy_r;
	Vector3 transformcopy_s;
	/****************/
	GameObject useofGameObj2;
	/****************/
	Dictionary<string,int> dictionary;
	AnimationClip[] animationclips;
	string old_eventname;
	string new_eventname;
	/****************/
	MonoScript old_script;
	MonoScript new_script;
	Component old_component;
	Component new_component;


	
	[MenuItem("Window/CMW Editor Tools")]
	public static void ShowWindow ()
	{
		// Show existing window instance. If one doesn't exist, make one.
		EditorWindow.GetWindow (typeof(CMWEditorTools));
	}


	void OnGUI () 
	{
		//***************
		scrollPosition = GUILayout.BeginScrollView(scrollPosition,GUILayout.Width(0),GUILayout.Height(0));

		GUIStyle myFoldoutStyle = new GUIStyle(EditorStyles.foldout);
		//Color myStyleColor = Color.blue;
		myFoldoutStyle.fontStyle = FontStyle.Bold;
		//myFoldoutStyle.normal.background;
		myFoldoutStyle.normal.textColor = Color.grey;
		myFoldoutStyle.onNormal.textColor = Color.cyan;
		myFoldoutStyle.hover.textColor = Color.cyan;
		myFoldoutStyle.onHover.textColor = Color.cyan;
		myFoldoutStyle.focused.textColor = Color.cyan;
		myFoldoutStyle.onFocused.textColor = Color.cyan;
		myFoldoutStyle.active.textColor = Color.cyan;
		myFoldoutStyle.onActive.textColor = Color.cyan;
		//***************

		//************************************ my Organiser ***********************************************/
		//myfunctionlist[0] = EditorGUILayout.Foldout(myfunctionlist[0], "Hierarchy Organizer",myFoldoutStyle);
		if(myfunctionlist[0])
		{
			/*
			GUI.color = Color.cyan;
			GUILayout.Label ("Hierarchy Organizer", EditorStyles.boldLabel);
			GUI.color = Color.white;
			order = (ORDER) EditorGUILayout.EnumPopup ("Sorting Order", order);
			GUILayout.Space (10);
			if (GUILayout.Button ("Sort Everything"))
				SortAll ();
			if (GUILayout.Button ("Sort Children of Selected"))
				SortSelected ();
			GUILayout.Space (30);
			*/
		}
		//************************************ my Testing Tools ***********************************************/
		//myfunctionlist[1] = EditorGUILayout.Foldout(myfunctionlist[1], "Testing Tools",myFoldoutStyle);
		if(myfunctionlist[1])
		{
			/*
			GUI.color = Color.cyan;
			debugging = EditorGUILayout.BeginToggleGroup ("Testing Tools", debugging);
			GUI.color = Color.white;
			if (GUILayout.Button ("Create Random Objects"))
				CreateRandomObjects ();
			numberOfObjects = EditorGUILayout.IntField ("Number of Objects", numberOfObjects);
			nameLength = EditorGUILayout.IntField ("Random Name Length", nameLength);
			asChildren = EditorGUILayout.Toggle ("Create as children", asChildren);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (30);
			*/
		}
		//************************************ Apply all / Revert all ***********************************************/
		myfunctionlist[2] = EditorGUILayout.Foldout(myfunctionlist[2], "Apply or Revert All",myFoldoutStyle);
		if(myfunctionlist[2])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Apply or Revert All", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			if (GUILayout.Button ("Apply All"))
				ApplyAll();
			GUILayout.Space (15);
			GUI.color = Color.yellow;
			GUILayout.Label ("*Revert All creates new object, i.e. break object links", EditorStyles.label);
			GUI.color = Color.white;
			if (GUILayout.Button ("Revert All"))
				RevertAll();
			GUILayout.Space (30);
		}
		//************************************ change obj names ***********************************************/
		myfunctionlist[3] = EditorGUILayout.Foldout(myfunctionlist[3], "Change Object Names",myFoldoutStyle);
		if(myfunctionlist[3])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Change Object Names", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			prefix = EditorGUILayout.TextField("Add Prefix", prefix);
			suffix = EditorGUILayout.TextField("Add Suffix", suffix);
			GUILayout.Space (10);
			replace = EditorGUILayout.TextField("Replace Text", replace);
			replace_By = EditorGUILayout.TextField("Replace By", replace_By);
			GUILayout.Space (10);
			insert_Before = EditorGUILayout.TextField("Insert Before Text", insert_Before);
			insert_Before_Word = EditorGUILayout.TextField("Insert Before By", insert_Before_Word);
			GUILayout.Space (10);
			insert_After = EditorGUILayout.TextField("Insert After Text", insert_After);
			insert_After_Word = EditorGUILayout.TextField("Insert After By", insert_After_Word);
			GUILayout.Space (10);
			if (GUILayout.Button ("Change Names"))
				ChangeObjNames();
			GUILayout.Space (30);
		}
		//************************************ replace game objects ***********************************************/
		myfunctionlist[4] = EditorGUILayout.Foldout(myfunctionlist[4], "Replace Objects by Object",myFoldoutStyle);
		if(myfunctionlist[4])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Replace Objects by Object", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view, then assign a GameObject / Prefab", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			useGameObject = (GameObject)EditorGUILayout.ObjectField(useGameObject,typeof(GameObject), true);
			if (GUILayout.Button ("Replace Ojects"))
				ReplaceGameObjects();
			GUILayout.Space (30);
		}
		//************************************ unlink prefab ***********************************************/
		myfunctionlist[5] = EditorGUILayout.Foldout(myfunctionlist[5], "Unlink Prefab",myFoldoutStyle);
		if(myfunctionlist[5])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Unlink Prefab", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			if (GUILayout.Button ("Unlink"))
				UnlinkPrefab();
			GUILayout.Space (30);
		}
		//************************************ rename prefab ***********************************************/
		myfunctionlist[6] = EditorGUILayout.Foldout(myfunctionlist[6], "Rename Prefab",myFoldoutStyle);
		if(myfunctionlist[6])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Rename Prefab", EditorStyles.boldLabel);
			GUILayout.Label ("Select the Prefabs in Project view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			prefix2 = EditorGUILayout.TextField("Add Prefix", prefix2);
			suffix2 = EditorGUILayout.TextField("Add Suffix", suffix2);
			GUILayout.Space (10);
			replace2 = EditorGUILayout.TextField("Replace Text", replace2);
			replace_By2 = EditorGUILayout.TextField("Replace By", replace_By2);
			GUILayout.Space (10);
			insert_Before2 = EditorGUILayout.TextField("Insert Before Text", insert_Before2);
			insert_Before_Word2 = EditorGUILayout.TextField("Insert Before By", insert_Before_Word2);
			GUILayout.Space (10);
			insert_After2 = EditorGUILayout.TextField("Insert After Text", insert_After2);
			insert_After_Word2 = EditorGUILayout.TextField("Insert After By", insert_After_Word2);
			GUILayout.Space (10);
			if (GUILayout.Button ("Change Names"))
				RenamePrefab();
			GUILayout.Space (30);
		}
		//************************************ transform copier ***********************************************/
		myfunctionlist[7] = EditorGUILayout.Foldout(myfunctionlist[7], "Transform Copier",myFoldoutStyle);
		if(myfunctionlist[7])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Transform Copier", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			if (GUILayout.Button ("Copy Transform"))
				TransformCopier(1);
			GUILayout.Space (10);
			if (GUILayout.Button ("Paste Transform"))
				TransformCopier(2);
			GUILayout.Space (5);
			if (GUILayout.Button ("Paste Position"))
				TransformCopier(3);
			if (GUILayout.Button ("Paste Rotation"))
				TransformCopier(4);
			if (GUILayout.Button ("Paste Scale"))
				TransformCopier(5);
			GUILayout.Space (30);
		}
		//************************************ round transform value ***********************************************/
		myfunctionlist[8] = EditorGUILayout.Foldout(myfunctionlist[8], "Round transform value",myFoldoutStyle);
		if(myfunctionlist[8])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Round transform value", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			rounduseOriP = EditorGUILayout.BeginToggleGroup ("Uncheck to Keep Original P", rounduseOriP);
			rounddp_P = EditorGUILayout.IntField ("Round P to d.p.", rounddp_P);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (15);
			rounduseOriR = EditorGUILayout.BeginToggleGroup ("Uncheck to Keep Original R", rounduseOriR);
			rounddp_R = EditorGUILayout.IntField ("Round R to d.p.", rounddp_R);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (15);
			rounduseOriS = EditorGUILayout.BeginToggleGroup ("Uncheck to Keep Original S", rounduseOriS);
			rounddp_S = EditorGUILayout.IntField ("Round S to d.p.", rounddp_S);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (15);
			if (GUILayout.Button ("Round"))
				RoundTransform();
			GUILayout.Space (30);
		}
		//************************************ evenly align objects ***********************************************/
		myfunctionlist[9] = EditorGUILayout.Foldout(myfunctionlist[9], "Evenly Align Objects Position",myFoldoutStyle);
		if(myfunctionlist[9])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Evenly Align Objects Position", EditorStyles.boldLabel);
			GUILayout.Label ("Select the GameObjects in Hierarchy view", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			alignuseOrix = EditorGUILayout.BeginToggleGroup ("Uncheck to Use Original x", alignuseOrix);
				alignspacex = EditorGUILayout.FloatField ("Object Spacing x", alignspacex);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (15);
			alignuseOriy = EditorGUILayout.BeginToggleGroup ("Uncheck to Use Original y", alignuseOriy);
				alignspacey = EditorGUILayout.FloatField ("Object Spacing y", alignspacey);
			EditorGUILayout.EndToggleGroup ();
			GUILayout.Space (15);
			alignuseOriz = EditorGUILayout.BeginToggleGroup ("Uncheck to Use Original z", alignuseOriz);
				alignspacez = EditorGUILayout.FloatField ("Object Spacing z", alignspacez);
			EditorGUILayout.EndToggleGroup ();
			if (GUILayout.Button ("Align Ojects"))
				EvenlyAlignObjects();
			GUILayout.Space (30);
		}
		//************************************ random generate object ***********************************************/
		//myfunctionlist[10] = EditorGUILayout.Foldout(myfunctionlist[10], "Random Generate Ogject [NOT YET]",myFoldoutStyle);
		if(myfunctionlist[10])
		{
			/*
			GUI.color = Color.cyan;
			GUILayout.Label ("Random Generate Ogject", EditorStyles.boldLabel);
			GUI.color = Color.white;
			if (GUILayout.Button ("Generate"))
				RandomGenerateObj();
			GUILayout.Space (30);
			*/
		}
		//************************************ create prefabs ***********************************************/
		myfunctionlist[11] = EditorGUILayout.Foldout(myfunctionlist[11], "Create Prefabs",myFoldoutStyle);
		if(myfunctionlist[11])
		{
			GUI.color = Color.cyan;
			GUILayout.Label ("Create Prefabs", EditorStyles.boldLabel);
			GUI.color = Color.yellow;
			GUILayout.Label ("Select the GameObjects you want to make prefabs in Hierarchy view, and assign a prefab/fbx from destination folder to below:", EditorStyles.wordWrappedLabel);
			GUI.color = Color.white;
			useofGameObj2 = (GameObject)EditorGUILayout.ObjectField(useofGameObj2,typeof(GameObject), true);
			if (GUILayout.Button ("Create"))
				CreatePrefabs();
			GUILayout.Space (30);
		}
		//************************************ change animation events ***********************************************/
        /*
		myfunctionlist[12] = EditorGUILayout.Foldout(myfunctionlist[12], "Change Animation Event Names",myFoldoutStyle);
		if(myfunctionlist[12])
		{
			GUI.color = Color.white;
			GUILayout.Label ("Change Animation Event Names", EditorStyles.boldLabel);
			GUILayout.Label ("Select Animation Clip files in Project View", EditorStyles.label);
			GUILayout.Space (15);

			GUILayout.Label ("Events in the Selected Animation Clips", EditorStyles.boldLabel);
			if (GUILayout.Button ("Show All Animation Events"))
			{
				dictionary = ShowAllAnimationEvent ();
			}

			if(animationclips != null)
			GUILayout.Label ("No. of Selected Animation Clips is "+animationclips.Length, EditorStyles.label);
			if (dictionary != null)
			{
				foreach (KeyValuePair<string, int> entry in dictionary)
				{
					GUILayout.Label (entry.Value + "x " + entry.Key, EditorStyles.label);
				}
			}
			GUILayout.Space (15);

			GUILayout.Label ("Type old and new function names", EditorStyles.boldLabel);
			old_eventname = EditorGUILayout.TextField("Old EventName", old_eventname);
			new_eventname = EditorGUILayout.TextField("New EventName", new_eventname);
			if (GUILayout.Button ("Change"))
				ChangeAnimationEventName();
			GUILayout.Space (30);
		}
        */
		//************************************ current animation mode stat ***********************************************/
		/*
		myfunctionlist[13] = EditorGUILayout.Foldout(myfunctionlist[13], "Change Object Component",myFoldoutStyle);
		if(myfunctionlist[13])
		{
			GUI.color = Color.white;
			GUILayout.Label ("Change Object Component", EditorStyles.boldLabel);
			GUILayout.Label ("Old Component", EditorStyles.label);
			old_script = (MonoScript) EditorGUILayout.ObjectField(old_script,typeof(MonoScript), true);
			GUILayout.Label ("New Component", EditorStyles.label);
			new_script = (MonoScript) EditorGUILayout.ObjectField(new_script,typeof(MonoScript), true);
			if (GUILayout.Button ("Change"))
				ChangeObjectComponent();
			GUILayout.Space (30);
		}
		*/


		//***************
		GUILayout.Space (70);
		GUILayout.EndScrollView();
		//***************
	}

	void TransformCopier(int mycase)
	{
		switch(mycase)
		{
			case 1: 
				transformcopy_p = Selection.gameObjects.First().transform.localPosition;
				transformcopy_r = Selection.gameObjects.First().transform.localRotation;
				transformcopy_s = Selection.gameObjects.First().transform.localScale;
				break;
			case 2: 
				Selection.gameObjects.First().transform.localPosition = transformcopy_p;
				Selection.gameObjects.First().transform.localRotation = transformcopy_r;
				Selection.gameObjects.First().transform.localScale = transformcopy_s;
				break;
			case 3: 
				Selection.gameObjects.First().transform.localPosition = transformcopy_p;
				break;
			case 4: 
				Selection.gameObjects.First().transform.localRotation = transformcopy_r;
				break;
			case 5: 
				Selection.gameObjects.First().transform.localScale = transformcopy_s;
				break;
			default: break;
		}
	}

	void RandomGenerateObj()
	{

	}

	void RoundTransform()
	{
		foreach (Transform t in Selection.transforms)
		{
			if(rounduseOriP)
			{
				t.localPosition = new Vector3(Mathf.Round(t.localPosition.x * Mathf.Pow(10,rounddp_P)) / Mathf.Pow(10,rounddp_P),
				                              Mathf.Round(t.localPosition.y * Mathf.Pow(10,rounddp_P)) / Mathf.Pow(10,rounddp_P),
				                              Mathf.Round(t.localPosition.z * Mathf.Pow(10,rounddp_P)) / Mathf.Pow(10,rounddp_P)
				                              );
			}
			if(rounduseOriR)
			{

				t.localEulerAngles = new Vector3(Mathf.Round(t.localEulerAngles.x * Mathf.Pow(10,rounddp_R)) / Mathf.Pow(10,rounddp_R),
				                                 Mathf.Round(t.localEulerAngles.y * Mathf.Pow(10,rounddp_R)) / Mathf.Pow(10,rounddp_R),
				                                 Mathf.Round(t.localEulerAngles.z * Mathf.Pow(10,rounddp_R)) / Mathf.Pow(10,rounddp_R)
												 );
			}
			if(rounduseOriS)
			{
				t.localScale = new Vector3(Mathf.Round(t.localScale.x * Mathf.Pow(10,rounddp_S)) / Mathf.Pow(10,rounddp_S),
				                           Mathf.Round(t.localScale.y * Mathf.Pow(10,rounddp_S)) / Mathf.Pow(10,rounddp_S),
				                           Mathf.Round(t.localScale.z * Mathf.Pow(10,rounddp_S)) / Mathf.Pow(10,rounddp_S)
				                           );
			}
		}
	}

	void EvenlyAlignObjects()
	{
		Vector3 newposition;
		int index=0;
		foreach (Transform t in Selection.transforms)
		{
			if(alignuseOrix)
			{
				newposition.x=alignspacex*index;
			}
			else
			{
				newposition.x = t.localPosition.x;
			}

			if(alignuseOriy)
			{
				newposition.y=alignspacey*index;
			}
			else
			{
				newposition.y = t.localPosition.y;
			}

			if(alignuseOriz)
			{
				newposition.z=alignspacez*index;
			}
			else
			{
				newposition.z = t.localPosition.z;
			}

			t.localPosition = newposition;

			index++;
		}
	}

	void UnlinkPrefab()
	{
		foreach (GameObject go in Selection.gameObjects)
		{
			string name = go.name;
			Transform parent = go.transform.parent;
			go.transform.parent = null;
			GameObject unprefabedGO = (GameObject)UnityEngine.Object.Instantiate(go);
			unprefabedGO.name = go.name;
			unprefabedGO.active = go.active;
			DestroyImmediate(go);
			unprefabedGO.transform.parent = parent;
		}
	}


	void ReplaceGameObjects()
	{
		foreach (Transform t in Selection.transforms)
		{
			GameObject newObject = PrefabUtility.InstantiatePrefab(useGameObject) as GameObject;
			if(newObject == null)
			{
				newObject = Instantiate(useGameObject) as GameObject;
			}
			Transform newT = newObject.transform;
			newT.parent = t.parent;
			newT.position = t.position;
			newT.rotation = t.rotation;
			newT.localScale = t.localScale;
			//newT.parent = t.parent;
		}
		
		foreach (GameObject go in Selection.gameObjects)
		{
			DestroyImmediate(go);
		}
	}

	void CreatePrefabs()
	{
		string path = AssetDatabase.GetAssetPath(useofGameObj2);
		string removename = useofGameObj2.name;
		path = path.Substring(0,path.IndexOf(removename));
		foreach (Transform t in Selection.transforms)
		{
			string name = t.gameObject.name;
			UnityEngine.Object prefab = EditorUtility.CreateEmptyPrefab(path + name + ".prefab");
			EditorUtility.ReplacePrefab(t.gameObject, prefab);
		}
		AssetDatabase.Refresh();
	}

	void ChangeObjNames()
	{
		GameObject[] myselectedlist = new GameObject[Selection.gameObjects.Length];
		if(myselectedlist.Length == 0) //Project View
		{
			UnityEngine.Object[] myselectedlist2 = Selection.GetFiltered (typeof(UnityEngine.Object), SelectionMode.DeepAssets);
			foreach (UnityEngine.Object go in myselectedlist)
			{
				go.name = prefix+go.name+suffix;
				if(replace != null && replace != "") go.name = go.name.Replace(replace,replace_By);
				if(insert_Before != null && insert_Before != "") go.name = go.name.Insert(go.name.IndexOf(insert_Before),insert_Before_Word);
				if(insert_After != null && insert_After != "") go.name = go.name.Insert(go.name.IndexOf(insert_After)+insert_After.Length,insert_After_Word);
			}
		}
		else // Hierachy View
		{
			foreach (GameObject go in Selection.gameObjects)
			{
				go.name = prefix+go.name+suffix;
				if(replace != null && replace != "") go.name = go.name.Replace(replace,replace_By);
				if(insert_Before != null && insert_Before != "") go.name = go.name.Insert(go.name.IndexOf(insert_Before),insert_Before_Word);
				if(insert_After != null && insert_After != "") go.name = go.name.Insert(go.name.IndexOf(insert_After)+insert_After.Length,insert_After_Word);
			}
		}

	}

	void RenamePrefab()
	{
		if(Selection.gameObjects.Length > 0) //Project View
		{
			string ret;
			foreach (GameObject go in Selection.gameObjects)
			{
				ret = AssetDatabase.RenameAsset(EditorUtility.GetAssetPath(go),
				                                prefix2+go.name.ToString()+suffix2);
				if(replace2 != null && replace2 != "") ret = AssetDatabase.RenameAsset(EditorUtility.GetAssetPath(go),go.name.Replace(replace2,replace_By2).ToString());
				if(insert_Before2 != null && insert_Before2 != "") ret = AssetDatabase.RenameAsset(EditorUtility.GetAssetPath(go),go.name.Insert(go.name.IndexOf(insert_Before2),insert_Before_Word2).ToString());
				if(insert_After2 != null && insert_After2 != "") ret =AssetDatabase.RenameAsset(EditorUtility.GetAssetPath(go),go.name.Insert(go.name.IndexOf(insert_After2)+insert_After2.Length,insert_After_Word2).ToString());
			}
			AssetDatabase.Refresh();
		}
	}
	
	void ApplyAll()
	{
		foreach (GameObject go in Selection.gameObjects)
		{
			PrefabUtility.ReplacePrefab(go, PrefabUtility.GetPrefabParent(go), ReplacePrefabOptions.ConnectToPrefab);
		}
	}

	void RevertAll()
	{
		foreach (GameObject go in Selection.gameObjects)
		{
			GameObject newObject = PrefabUtility.InstantiatePrefab(PrefabUtility.GetPrefabParent(go)) as GameObject;
			newObject.transform.parent = go.transform.parent;
			newObject.transform.position = go.transform.position;
            newObject.transform.rotation = go.transform.rotation;
            newObject.transform.localScale = go.transform.localScale;

			DestroyImmediate(go);
		}
	}	


	void SortAll ()
	{
		Transform[] transforms = FindObjectsOfType (typeof(Transform)) as Transform[];
		int index = 0;
		if (order == ORDER.Ascending)
		{
			foreach (var tr in transforms.Cast<Transform>().OrderBy (t=>t.name))
			{
				tr.SetSiblingIndex (index);
				index ++;
			}
		}
		else if (order == ORDER.Descending)
		{
			foreach (var tr in transforms.Cast<Transform>().OrderByDescending (t=>t.name))
			{
				tr.SetSiblingIndex (index);
				index ++;
			}
		}
	}


	void SortSelected ()
	{
		if (Selection.activeTransform)
		{
			Transform selected = Selection.activeTransform;
			Transform[] transforms = selected.GetComponentsInChildren<Transform>();
			int index = 0;
			if (order == ORDER.Ascending)
			{
				foreach (var tr in transforms.Cast<Transform>().OrderBy (t=>t.name))
				{
					if (tr.parent != false)
					{
						tr.SetSiblingIndex (index);
						index ++;
					}
				}
			}
			else if (order == ORDER.Descending)
			{
				foreach (var tr in transforms.Cast<Transform>().OrderByDescending (t=>t.name))
				{
					if (tr.parent != false)
					{
						tr.SetSiblingIndex (index);
						index ++;
					}
				}
			}
		}
		else
		{
			Debug.LogWarning("No Object selected for sorting.");
		}
	}

	Dictionary<string,int> ShowAllAnimationEvent()
	{
		UnityEngine.Object[] objs = Selection.GetFiltered (typeof(UnityEngine.Object), SelectionMode.DeepAssets);
		animationclips = new AnimationClip[objs.Length];
		for (int i = 0; i < objs.Length; i++)
		{
			AnimationClip aniclip = null;
			try 
			{
				aniclip = (AnimationClip)objs [i];
			} 
			catch 
			{
			}

			if (aniclip!= null)
			{
				if(!aniclip.isHumanMotion)
				animationclips [i] = aniclip;
			}
		}

		//List of Events
		Dictionary<string, int> dictionary = new Dictionary<string, int>();

		foreach (AnimationClip ac in animationclips)
		{
			if (ac != null)
			{
				AnimationEvent[] evnt = AnimationUtility.GetAnimationEvents (ac);

				// This is for checking
				foreach (AnimationEvent ae in evnt)
				{
					if (dictionary.ContainsKey (ae.functionName.ToString ()))
					{
						dictionary [ae.functionName.ToString ()] += 1; 
					}
					else
					{
						dictionary.Add (ae.functionName.ToString (), 1);
					}
				}
			}
		}

		return dictionary;
	}

	void ChangeAnimationEventName()
	{
		UnityEngine.Object[] objs = Selection.GetFiltered (typeof(UnityEngine.Object), SelectionMode.DeepAssets);
		animationclips = new AnimationClip[objs.Length];
		for (int i = 0; i < objs.Length; i++)
		{
			AnimationClip aniclip = null;
			try 
			{
				aniclip = (AnimationClip)objs [i];
			} 
			catch 
			{
			}

			if (aniclip!= null)
			{
				if(!aniclip.isHumanMotion)
					animationclips [i] = aniclip;
			}
		}

		foreach (AnimationClip ac in animationclips)
		{
			AnimationEvent[] evnt = AnimationUtility.GetAnimationEvents(ac);

			// This is for particle system change event name
			foreach (AnimationEvent ae in evnt)
			{
				if (ae.functionName == old_eventname)
				{
					ae.functionName = new_eventname;
					Debug.Log ("Changed event names from " + ac.name + " to " + new_eventname);
				}
				AnimationUtility.SetAnimationEvents(ac,evnt);
			}

			
			// This is for animation change event name
			/*
			AnimationEvent[] evntnew = new AnimationEvent[100];
			int evntnew_id = 0;
			foreach (AnimationEvent ae in evnt)
			{
				if (ae.functionName == "playAni")
				{
					//New event for setid
					AnimationEvent setidevent = new AnimationEvent ();
					setidevent.functionName = "SetAnimatorIndex";
					setidevent.intParameter = 0;
					setidevent.time = ae.time;

					ae.functionName = new_eventname;
					Debug.Log ("Changed event names in " + ac.name);

					//Assign to new array
					evntnew [evntnew_id] = setidevent;
					evntnew_id++;
				}
				else if(ae.functionName == "playAni2")
				{
					//New event for setid
					AnimationEvent setidevent = new AnimationEvent ();
					setidevent.functionName = "SetAnimatorIndex";
					setidevent.intParameter = 1;
					setidevent.time = ae.time;

					ae.functionName = new_eventname;
					Debug.Log ("Changed event names in " + ac.name);

					//Assign to new array
					evntnew [evntnew_id] = setidevent;
					evntnew_id++;
				}
				evntnew [evntnew_id] = ae;
				evntnew_id++;
			}
			AnimationEvent[] evntnew_trim = new AnimationEvent[evntnew_id];
			for (int j = 0; j < evntnew_trim.Length; j++)
			{
				evntnew_trim [j] = evntnew [j];
			}
			AnimationUtility.SetAnimationEvents(ac,evntnew_trim);
			*/

		}
	}

	void ChangeObjectComponent() //CMW
	{
		if (Selection.gameObjects.Length > 0 && old_script != null && new_script != null)
		{
			System.Type oldtype = old_script.GetClass();
			System.Type newtype = new_script.GetClass();
			foreach (GameObject obj in Selection.gameObjects)
			{
				if (obj.GetComponent (oldtype) != null)
				{
					obj.AddComponent (newtype);

					//CUSTOM SCRIPT CHANGER

					//PlayParticleEffect => ParticleEffectAnimation
					/* 
					ParticleEffectAnimation pea = obj.GetComponent<ParticleEffectAnimation>();
					PlayParticleEffect ppe = obj.GetComponent<PlayParticleEffect>();
					pea.Ps = ppe.ps;
					DestroyImmediate(ppe);
					*/


					// PlayAnimation => PlayAnimationState
					/*
					PlayAnimation oldcomp = obj.GetComponent<PlayAnimation>();
					PlayAnimationState newcomp = obj.GetComponent<PlayAnimationState>();

					if (oldcomp.animator != null && oldcomp.animator2 == null) //only 1 animator
					{
						newcomp.animator = new Animator[1];
						newcomp.animator [0] = oldcomp.animator;
						DestroyImmediate(oldcomp);
					}
					else if (oldcomp.animator != null && oldcomp.animator2 != null) //used 2 animator
					{
						newcomp.animator = new Animator[2];
						newcomp.animator [0] = oldcomp.animator;
						newcomp.animator [1] = oldcomp.animator2;
						DestroyImmediate(oldcomp);
					}
					else if (oldcomp.animator == null && oldcomp.animator2 == null) //empty script!
					{
						DestroyImmediate(oldcomp);
					}
					*/


					//

				}
			}
		}
	}


	//TESTING TOOLS
	public int numberOfObjects = 25;
	public int nameLength = 5;
	public bool asChildren = false;

	//List<GameObject> = new junkList List<GameObject>();
	GameObject parentObject;
	

	public void CreateRandomObjects ()
	{
		if (asChildren)
		{
			parentObject = new GameObject();
			parentObject.name = RandomString(nameLength) + " (parent)";
		}
		
		// Create new objects in the scene.
		for (int i = 0; i < numberOfObjects; i ++)
		{
			var go = new GameObject();
			go.name = RandomString(nameLength);
			
			if (asChildren)
				go.transform.parent = parentObject.transform;
		}
	}
	
	string RandomString (int length)
	{
		string chars = "_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		string returnString = "";
		
		for (int i = 0; i < length; i++) 
		{
			returnString += chars [UnityEngine.Random.Range(0, chars.Length)];
		}
		
		return returnString;
	}

	void OnInspectorUpdate() 
	{
		this.Repaint();
	}
}







//*****************************************************************************************************************************************************
public class AlphaNumericSort : BaseHierarchySort
{
	public override int Compare(GameObject lhs, GameObject rhs)
	{
		if (lhs == rhs) return 0;
		if (lhs == null) return -1;
		if (rhs == null) return 1;
		return EditorUtility.NaturalCompare(lhs.name, rhs.name);
	}
}
