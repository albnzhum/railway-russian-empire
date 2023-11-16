using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace TGS.Geom {

				public class VoronoiFortune {

								public VoronoiCell[] cells;
								// this is the output
								List<Event> eventQueue;
								int eventQueueTop, eventQueueCount;
								Arc root;
								Dictionary<Point,bool> hit;
								const double X0 = -0.5;
								const double Y0 = -0.5;
								const double X1 = 0.5;
								const double Y1 = 0.5;


								public void AssignData (Point[] centers) {

												if (this.cells == null || this.cells.Length != centers.Length) {
																this.cells = new VoronoiCell[centers.Length];
												}
												for (int k = 0; k < cells.Length; k++) {
																cells [k] = new VoronoiCell (centers [k]);
												}

												if (eventQueue == null) {
																eventQueue = new List<Event> (cells.Length);
												} else {
																eventQueue.Clear ();
												}
												eventQueueCount = 0;
												eventQueueTop = 0;
												root = null;

												if (hit == null) {
																hit = new Dictionary<Point, bool> (cells.Length);
												} else {
																hit.Clear ();
												}
												for (int k = 0; k < cells.Length; k++) {
																Point p = cells [k].center;
																// Checks that p is not near than PRECISION from other point
																while (hit.ContainsKey (p)) {
																				if (p.X > 0) {
																								p.X -= Point.Precision * 2.0f;
																				} else {
																								p.X += Point.Precision * 2.0f;
																				}
																}
																hit[p] = true; //.Add (p, true);
																Event siteEvent = new Event (EVENT_TYPE.SiteEvent);
																siteEvent.p = p;
																siteEvent.x = p.X;
																siteEvent.cell = cells [k];
																eventQueue.Add (siteEvent);
																eventQueueCount++;
												}

												eventQueue.Sort ((Event e1, Event e2) => {
																if (e1.x < e2.x - Point.Precision)
																				return -1;
																else if (e1.x > e2.x + Point.Precision)
																				return 1;
																else if (e1.p.Y < e2.p.Y - Point.Precision)
																				return -1;
																else if (e1.p.Y > e2.p.Y + Point.Precision)
																				return 1;
																else
																				return 0;
												});
								}

								void AddEvent (Event ev) {
												// Binary sort insert
												int max = eventQueueCount, min = eventQueueTop;
												for (;;) {
																if (max == min) {
																				if (eventQueueTop > 0 && max == eventQueueTop) { // optimization - reuse memory slot from older events
																								eventQueueTop--;
																								eventQueue [eventQueueTop] = ev;
																				} else {
																								eventQueue.Insert (max, ev);
																								eventQueueCount++;
																				}
																				return;
																}
																int midPoint = (max + min) / 2;
																Event ev2 = eventQueue [midPoint];
//				if (ev2.x<ev.x) {
//					min = midPoint + 1;
//				} else if (ev2.x==ev.x && ev2.p.y<ev.p.y) {
//					min = midPoint + 1;
//				} else {
//					max = midPoint;
//				}

																if (ev2.x < ev.x - Point.Precision) {
																				min = midPoint + 1;
																} else if (ev2.x - ev.x < Point.Precision && ev2.x - ev.x > -Point.Precision && ev2.p.Y < ev.p.Y - Point.Precision) {
																				min = midPoint + 1;
																} else {
																				max = midPoint;
																}

												}
								}

								public void DoVoronoi () {

												eventQueueTop = 0;
												while (eventQueueTop < eventQueueCount) {
																Event ev = eventQueue [eventQueueTop++];
																if (ev.type == EVENT_TYPE.SiteEvent) {
																				HandleSiteEvent (ev);
																} else {
																				HandleCircleEvent (ev);
																}
												} 
												FinishEdges ();
								}

								void HandleSiteEvent (Event ev) {
												Point p = ev.p;

												if (root == null) {
																root = new Arc (ev.cell, p);
																return;
												}

												Arc i;
												// Find the current arc(s) at height p.y (if there are any).
												for (i = root; i != null; i = i.next) {
																Point z, zz;
																if (Intersect (p, i, out z)) {
																				// New parabola intersects arc i.  If necessary, duplicate i.
																				if (i.next != null && !Intersect (p, i.next, out zz)) {
																								i.next.prev = new Arc (i.cell, i.p, i, i.next);
																								i.next = i.next.prev;
																				} else {
																								i.next = new Arc (i.cell, i.p, i);
																				}
																				i.next.s1 = i.s1;

																				// Add p between i and i->next.
																				i.next.prev = new Arc (ev.cell, p, i, i.next);
																				i.next = i.next.prev;
					
																				i = i.next; // Now i points to the new arc.

																				// Add new half-edges connected to i's endpoints.
																				i.prev.s1 = i.s0 = new Segment (z);
																				i.prev.cell.segments.Add (i.prev.s1);
																				i.cell.segments.Add (i.prev.s1);

																				i.next.s0 = i.s1 = new Segment (z);
																				i.next.cell.segments.Add (i.next.s0);
																				i.cell.segments.Add (i.next.s0);

																				// Check for new circle events around the new arc:
																				CheckCircleEvent (i, p.X);
																				CheckCircleEvent (i.prev, p.X);
																				CheckCircleEvent (i.next, p.X);
																				return;
																}
												}

												// Special case: If p never intersects an arc, append it to the list.
												for (i = root; i.next != null; i = i.next)
																; // Find the last node.
												i.next = new Arc (ev.cell, p, i);

												// Insert segment between p and i
												Point start = new Point (X0 - 1, (i.next.p.Y + i.p.Y) / 2);
												i.next.s0 = i.s1 = new Segment (start);
												i.next.cell.segments.Add (i.next.s0);
												i.cell.segments.Add (i.next.s0);
								}


								/// <summary>
								/// Look for a new circle event for arc i.
								/// </summary>
								void HandleCircleEvent (Event e) {
												if (e.valid) {
																Segment s = new Segment (e.p);

																Arc a = e.a;
																if (a.prev != null) {
																				a.prev.next = a.next;
																				a.prev.s1 = s;
																				a.prev.cell.segments.Add (s);
																}
																if (a.next != null) {
																				a.next.prev = a.prev;
																				a.next.s0 = s;
																				a.next.cell.segments.Add (s);
																}

																if (a.s0 != null)
																				a.s0.Finish (e.p);
																if (a.s1 != null)
																				a.s1.Finish (e.p);

																if (a.prev != null)
																				CheckCircleEvent (a.prev, e.x);
																if (a.next != null)
																				CheckCircleEvent (a.next, e.x);
												}
								}

								void CheckCircleEvent (Arc i, double x0) {
												// Invalidate any old event.
												if (i.e != null && (i.e.x - x0 < Point.Precision || i.e.x - x0 > Point.Precision)) {
																i.e.valid = false;
												}
												i.e = null;

												if (i.prev == null || i.next == null)
																return;

												double x;
												Point o;

												if (Circle (i.prev.p, i.p, i.next.p, out x, out o) && x >= x0 - Point.Precision) {
																// Create new event.
																i.e = new Event (EVENT_TYPE.CircleEvent, x, o, i);
																AddEvent (i.e);
												}
								}

								// Find the rightmost point on the circle through a,b,c.
								bool Circle (Point a, Point b, Point c, out double x, out Point o) {
												// Check that bc is a "right turn" from ab.
												x = 0;
												o = Point.Zero;
												double cv = (b.X - a.X) * (c.Y - a.Y) - (c.X - a.X) * (b.Y - a.Y);
												if (cv >= 0) {
																return false;
												}

												// Algorithm from O'Rourke 2ed p. 189.
												double A = b.X - a.X;
												double B = b.Y - a.Y;
												double C = c.X - a.X;
												double D = c.Y - a.Y;
												double E = A * (a.X + b.X) + B * (a.Y + b.Y);
												double F = C * (a.X + c.X) + D * (a.Y + c.Y);
												double G = 2 * (A * (c.Y - b.Y) - B * (c.X - b.X)); // changed to double to prevent precision problems

												if (G < Point.Precision && G > -Point.Precision) {
																return false;  // Points are co-linear.
												}
			
												// Point o is the center of the circle.
												o.X = (D * E - B * F) / G;
												o.Y = (A * F - C * E) / G;

												// o.x plus radius equals max x coordinate.
												x = o.X + Math.Sqrt ((a.X - o.X) * (a.X - o.X) + (a.Y - o.Y) * (a.Y - o.Y));
												return true;
								}

								// Will a new parabola at point p intersect with arc i?
								bool Intersect (Point p, Arc i, out Point res) {
												res = Point.Zero;
												if ((i.p.X - p.X) < Point.Precision && (i.p.X - p.X) > -Point.Precision) {
																return false;
												}

												double a = 0, b = 0;
												bool prevIsNotNull = i.prev != null;
												bool nextIsNotNull = i.next != null;

//												if (i.prev != null) { // Get the intersection of i->prev, i.
												if (prevIsNotNull) { // Get the intersection of i->prev, i.
																a = Intersection (i.prev.p, i.p, p.X).Y;
												}
//												if (i.next != null) { // Get the intersection of i->next, i.
												if (nextIsNotNull) { // Get the intersection of i->next, i.
																b = Intersection (i.p, i.next.p, p.X).Y;
												}

//												if ((i.prev == null || a <= p.y) && (i.next == null || p.y < b)) {
												if ((!prevIsNotNull || a <= p.Y) && (!nextIsNotNull || p.Y < b)) {
																res.Y = p.Y;
																// Plug it back into the parabola equation.
																res.X = ((i.p.X * i.p.X + (i.p.Y - res.Y) * (i.p.Y - res.Y) - p.X * p.X)
																/ (2 * i.p.X - 2 * p.X));

																return true;
												}
												return false;
								}

								// Where do two parabolas intersect?
								Point Intersection (Point p0, Point p1, double l) {
												Point res = new Point (), p = p0;

												if (p0.X == p1.X)
																res.Y = (p0.Y + p1.Y) / 2;
												else if (p1.X == l)
																res.Y = p1.Y;
												else if (p0.X == l) {
																res.Y = p0.Y;
																p = p1;
												} else {
																// Use the quadratic formula.
																double z0 = 2 * (p0.X - l);
																double z1 = 2 * (p1.X - l);
				
																double a = 1 / z0 - 1 / z1;
																double b = -2 * (p0.Y / z0 - p1.Y / z1);
																double c = (p0.Y * p0.Y + p0.X * p0.X - l * l) / z0
																           - (p1.Y * p1.Y + p1.X * p1.X - l * l) / z1;

																res.Y = (-b - Math.Sqrt (b * b - 4 * a * c)) / (2 * a);
												}
												// Plug back into one of the parabola equations.
												res.X = (p.X * p.X + (p.Y - res.Y) * (p.Y - res.Y) - l * l) / (2 * p.X - 2 * l);
												return res;
								}

								void FinishEdges () {

												// Advance the sweep line so no parabolas can cross the bounding box.
												double l = X1 + (X1 - X0) + (Y1 - Y0);

												// Extend each remaining segment to the new parabola intersections.
												for (Arc i = root; i.next != null; i = i.next) {
																if (i.s1 != null) {
																				i.s1.Finish (Intersection (i.p, i.next.p, l * 2));
																}
												}

												// Crop output
												for (int c = 0; c < cells.Length; c++) {
																VoronoiCell cell = cells [c];
																bool cropped = false;
																// Crop segments if needed
																int segmentCount = cell.segments.Count;
																for (int k = 0; k < segmentCount; k++) {
																				Segment s = cell.segments [k];
																				// is the segment completely outside?
																				if (!s.done || (s.start.X < X0 && s.end.X < X0) || (s.start.Y < Y0 && s.end.Y < Y0) || (s.start.X > X1 && s.end.X > X1) || (s.start.Y > Y1 && s.end.Y > Y1) ||
																				    Point.EqualsBoth (s.start, s.end)) {
																								s.deleted = true;
																								continue;
																				}

																				// is any endpoint outside of the canvas?
																				bool p1inside = PointInsideRect (s.start);
																				if (!p1inside) {
																								s.start = CropPoint (s.start, s, cell);
																								cropped = true;
																				}
																				bool p2inside = PointInsideRect (s.end);
																				if (!p2inside) {
																								s.end = CropPoint (s.end, s, cell);
																								cropped = true;
																				}
																}

																if (cropped) {
																				// join borders with 2 points
																				if (cell.top.Count > 1) {
																								cell.segments.Add (new Segment (cell.top [0], cell.top [1], true));
																				}
																				if (cell.bottom.Count > 1) {
																								cell.segments.Add (new Segment (cell.bottom [0], cell.bottom [1], true));
																				}
																				if (cell.left.Count > 1) {
																								cell.segments.Add (new Segment (cell.left [0], cell.left [1], true));
																				}
																				if (cell.right.Count > 1) {
																								cell.segments.Add (new Segment (cell.right [0], cell.right [1], true));
																				}
																}
												}

												// 2nd step - snap to nearest corners
												Point[] corners = new Point[4];
												corners [0] = new Point (X0, Y0);
												corners [1] = new Point (X0, Y1);
												corners [2] = new Point (X1, Y0);
												corners [3] = new Point (X1, Y1);
												Point np;
												for (int cornerIndex = 0; cornerIndex < corners.Length; cornerIndex++) {
																Point corner = corners [cornerIndex];
																// Get the nearest point of the segments
																VoronoiCell nearestCell = GetNearestCellFrom (corner);
																// this territory is the nearest to the corner so now we can snap the nearest segment safely
																if (GetNearestSegmentPointToCorner (corner, nearestCell.segments, true, out np)) {
																				nearestCell.segments.Add (new Segment (np, corner, true));
																}
																if (GetNearestSegmentPointToCorner (corner, nearestCell.segments, false, out np)) {
																				nearestCell.segments.Add (new Segment (np, corner, true));
																}
												}
								}

								bool GetNearestSegmentPointToCorner (Point corner, List<Segment> segments, bool leftOrRightSides, out Point nearest) {
												double dist, minDist = double.MaxValue;
												Point p;
												nearest = Point.Zero;
												int segmentCount = segments.Count;
												for (int k = 0; k < segmentCount; k++) {
																Segment s = segments [k];
																if (s.deleted)
																				continue;
																p = s.start;
																if (Point.EqualsBoth (p, corner))
																				continue;
																if ((Math.Abs (corner.X - p.X) < Point.Precision && leftOrRightSides) || (Math.Abs (corner.Y - p.Y) < Point.Precision && !leftOrRightSides)) {
																				dist = (p - corner).SqrMagnitude;
																				if (dist < minDist) {
																								minDist = dist;
																								nearest = p;
																				}
																}
																p = segments [k].end;
																if (Point.EqualsBoth (p, corner))
																				continue;
																if ((Math.Abs (corner.X - p.X) < Point.Precision && leftOrRightSides) || (Math.Abs (corner.Y - p.Y) < Point.Precision && !leftOrRightSides)) {
																				dist = (p - corner).SqrMagnitude;
																				if (dist < minDist) {
																								minDist = dist;
																								nearest = p;
																				}
																}
												}
												return minDist < double.MaxValue;

								}

								VoronoiCell GetNearestCellFrom (Point point) {
												double minDist = double.MaxValue;
												int nearest = -1;
												for (int k = 0; k < cells.Length; k++) {
																Point center = cells [k].center; // new Point(cells [k].center.x, cells [k].center.y);
																double dist = (center.X - point.X) * (center.X - point.X) + (center.Y - point.Y) * (center.Y - point.Y);
																if (dist < minDist) {
																				minDist = dist;
																				nearest = k;
																}
												}
												return cells [nearest];
								}

								bool PointInsideRect (Point p) {
												return p.X > X0 && p.X < X1 && p.Y > Y0 && p.Y < Y1;
								}


								Point CropPoint (Point point, Segment s, VoronoiCell cell) {
												// Get line parameters
												Point start = s.start, end = s.end;

												double dy = (end.Y - start.Y) / (end.X - start.X);
												if (point.X < X0) {
																point.Y += dy * (X0 - point.X);
																point.X = X0;
												} else if (point.X > X1) {
																point.Y += dy * (X1 - point.X);
																point.X = X1;
												}
												if (point.Y < Y0) {
																point.X += (Y0 - point.Y) * (1.0f / dy);
																point.Y = Y0;
												} else if (point.Y > Y1) {
																point.X += (Y1 - point.Y) * (1.0f / dy);
																point.Y = Y1;
												}
												if (DoublesAreEqual (point.X, X0))
																cell.left.Add (point);
												if (DoublesAreEqual (point.X, X1))
																cell.right.Add (point);
												if (DoublesAreEqual (point.Y, Y0))
																cell.bottom.Add (point);
												if (DoublesAreEqual (point.Y, Y1))
																cell.top.Add (point);
												return point;
								}

								bool DoublesAreEqual (double d1, double d2) {
												return (d1 - d2 > -Point.Precision && d1 - d2 < Point.Precision);
								}

				}
}
