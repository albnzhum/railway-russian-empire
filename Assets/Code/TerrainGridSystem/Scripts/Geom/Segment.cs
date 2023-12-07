using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace TGS.Geom {
				public class Segment {
								public Point start, end;
								public bool done, deleted;
								public bool border;
								// this border is result of a border crop
								public List<Segment> subdivisions;
								public int territoryIndex = -1;

								public Vector3 startToVector3 {
												get {
																return new Vector3 ((float)start.X, (float)start.Y, 0);
												}
								}

								public Vector3 endToVector3 {
												get {
																return new Vector3 ((float)end.X, (float)end.Y, 0);
												}
								}

								public Segment (Point start, Point end) : this (start, end, false) {
								}

								public Segment (Point start, Point end, bool border) {
												this.start = start;
												this.end = end;
												this.border = border;
												done = true;
								}

								public Segment (Point p) {
												start = p;
								}

								public void Finish (Point p) {
												if (done)
																return;
												end = p;
												done = true;
								}

								public double sqrMagnitude {
												get {
																double dx = end.X - start.X;
																double dy = end.Y - start.Y;
																return dx * dx + dy * dy;
												}
								}

								public double magnitude {
												get {
																double dx = end.X - start.X;
																double dy = end.Y - start.Y;
																return Math.Sqrt (dx * dx + dy * dy);
												}
								}


								public List<Segment> Subdivide (int divisions, double waveAmount) {
												if (subdivisions != null)
																return subdivisions;
			
												// Divide and add random displacement
												subdivisions = new List<Segment> (divisions);
												Point normal = Point.Zero;
												double l = 0;
												if (!border && waveAmount > 0 && divisions > 1) {
																// safety check - length must be > 0.01f;
																l = waveAmount * Math.Sqrt (sqrMagnitude);
																normal = new Point (-(end.Y - start.Y), end.X - start.X);
																normal = normal.Normalized * l;
																if (UnityEngine.Random.value > 0.5f)
																				normal *= -1;
												}
												Point d0 = start;
												for (int d = 1; d < divisions; d++) {
																Point d1 = Point.Lerp (start, end, (double)d / divisions);
																if (!border && waveAmount > 0) {
																				double s = 1 - Math.Abs (d - (double)divisions / 2) / ((double)divisions / 2);
																				d1 += normal * Math.Sin (d * Math.PI / divisions) * s;
																}
																subdivisions.Add (new Segment (d0, d1, border));
																d0 = d1;
												}
												subdivisions.Add (new Segment (d0, end, border));
												return subdivisions;
								}


								public override string ToString () {
												return string.Format ("start:" + start.ToString () + ", end:" + end.ToString ());
								}

								public void CropBottom () {
												start.CropBottom ();
												end.CropBottom ();

												if (Point.EqualsBoth (start, end))
																deleted = true;
								}

								public void CropRight () {
												start.CropRight ();
												end.CropRight ();

												if (Point.EqualsBoth (start, end))
																deleted = true;
								}

				}

}
	