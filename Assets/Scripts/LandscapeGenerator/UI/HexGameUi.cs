using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace LandscapeGenerator
{
    public class HexGameUi : MonoBehaviour
    {
        public HexGrid grid;
        [SerializeField] Toggle editModeToggle;

        HexCell currentCell;
        HexUnit selectedUnit;

        void Update()
        {
            if (!EventSystem.current.IsPointerOverGameObject())
            {
                if (Input.GetMouseButton(0))
                {
                    DoSelection();
                }
                else if (selectedUnit)
                {
                    if (Input.GetMouseButton(1))
                    {
                        DoMove();
                    }
                    else
                    {
                        DoPathfinding();
                    }
                }
            }
        }

        bool UpdateCurrentCell()
        {
            var cell = grid.GetCell(Camera.main.ScreenPointToRay(Input.mousePosition));
            if (cell != currentCell)
            {
                currentCell = cell;
                return true;
            }

            return false;
        }

        void DoSelection()
        {
            grid.ClearPath();
            UpdateCurrentCell();
            if (currentCell)
            {
                selectedUnit = currentCell.Unit;
            }
        }

        void DoPathfinding()
        {
            if (UpdateCurrentCell())
            {
                if (currentCell && selectedUnit.IsValidDestination(currentCell))
                {
                    grid.FindPath(selectedUnit.Location, currentCell, 24);
                }
                else
                {
                    grid.ClearPath();
                }
            }
        }

        void DoMove()
        {
            if (grid.HasPath)
            {
                selectedUnit.Travel(grid.GetPath());
                grid.ClearPath();
            }
        }


        public void SetEditMode()
        {
            enabled = editModeToggle.isOn ? true : false;
            grid.ShowUI(enabled);
            grid.ClearPath();
        }
    }
}
