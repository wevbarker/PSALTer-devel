(*===========================*)
(*  VectorSymmetricTheories  *)
(*===========================*)

Section@"Physically interesting vector symmetries of metric affine gravity";

AllCouplings={
A0,
A1,
A2,
A3,
A4,
A5,
A6,
A7,
A8,
A9,
A10,
A11,
C1,
C2,
C3,
C4,
C5,
C6,
C7,
C8,
C9,
C10,
C11,
C12,
C13,
C14,
C15,
C16};

Comment@{"We will study the four spectra of theories with physically interesting vector symmetries."};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity","VectorSymmetricTheories",
					"AntiWeylTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity","VectorSymmetricTheories",
					"ExtendedProjectiveTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity","VectorSymmetricTheories",
					"ProjectiveTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity","VectorSymmetricTheories",
					"ConcurrentTheory.m"};
