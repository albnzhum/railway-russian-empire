using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace TGS
{
    public partial class TerrainGridSystem 
    {
        public override void InstallBindings()
        {
            Container.Bind<TerrainGridSystem>().FromInstance(TerrainGridSystem.Instance);
            
        }
    }
}
