﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshColor : MonoBehaviour
{
    public Color input_color;

    void Start ()
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;

        // create new colors array where the colors will be created.
        Color[] colors = new Color[vertices.Length];

        for (int i = 0; i < vertices.Length; i++)
            colors[i] = input_color;

        // assign the array of colors to the Mesh.
        mesh.colors = colors;
    }


}
