using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Subdiv.Demo
{

    [RequireComponent (typeof(MeshFilter))]
    public class CPUSubdivTest : MonoBehaviour {

        [SerializeField, Range(1, 4)] protected int details = 1;
        [SerializeField] bool weld = false;

        [ContextMenu("Subdivide Mesh")] // Этот метод будет вызываться при нажатии правой кнопкой мыши на компоненте в инспекторе.
        void SubdivideMesh()
        {
            var filter = GetComponent<MeshFilter>();
            var source = filter.mesh;
            var mesh = SubdivisionSurface.Subdivide(SubdivisionSurface.Weld(source, 1f, source.bounds.size.x), details, weld);
            filter.mesh = mesh;
        }

    }

}


