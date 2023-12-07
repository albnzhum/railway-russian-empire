using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using TGS.Geom;

namespace TGS
{
    public partial class Territory : IAdmin
    {
        public string Name { get; set; }

        public Region Region { get; set; }

        public Polygon Polygon { get; set; }

        public Vector2 Center;
        public Vector2 ScaledCenter;
        public List<Cell> Cells;
        public Color FillColor = Color.gray;
        public Color FrontierColor = new Color(0, 0, 0, 0);

        public bool Visible { get; set; }

        public bool Neutral { get; set; }

        public Territory(string name)
        {
            this.Name = name;
            Visible = true;
            Cells = new List<Cell>();
        }
    }
}