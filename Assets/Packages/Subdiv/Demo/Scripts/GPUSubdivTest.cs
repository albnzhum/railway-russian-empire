using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Subdiv.Demo
{

    [RequireComponent (typeof(MeshFilter))]
    public class GPUSubdivTest : MonoBehaviour {

        [SerializeField] protected ComputeShader subdivCompute;
        [SerializeField, Range(1, 4)] protected int details = 1;
        [SerializeField] bool weld = false;

        [ContextMenu("Subdivide Mesh")]
        void SubdivideMesh()
        {
            var filter = GetComponent<MeshFilter>();
            var source = filter.mesh;
            var mesh = GPUSubdivisionSurface.Subdivide(subdivCompute, SubdivisionSurface.Weld(source, 1f, source.bounds.size.x), details, weld);
            filter.sharedMesh = mesh;
        }
    }
}


