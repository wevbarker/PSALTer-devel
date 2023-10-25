(*=========================*)
(*  IosifidisBarkerTheory  *)
(*=========================*)

Section@"Iosifidis-Barker theory";

Comment@"We now examine the most general case for which all the quadratic curvature parameters are present, but none of the explicit masses.";

AllRules={
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
	(*
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
*)
(*
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0},
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C16->0}
*)
{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0}
};

TestTheory[InputRules_]:=Module[{NewLinearLagrangian},
	NewLinearLagrangian=Measure*NonlinearLagrangian/.InputRules;
	DisplayExpression[NewLinearLagrangian,EqnLabel->"NewMetricAffineEinsteinHilbertTheory"];
	NewLinearLagrangian//=LineariseLagrangian;
	DisplayExpression@InputRules;
	ParticleSpectrum[NewLinearLagrangian,
			ClassName->"MetricAffineGravity",
			TheoryName->"MetricAffineEinsteinHilbertTheory"<>ToString@Length@InputRules,	
			Method->"Hard",
			MaxLaurentDepth->1];	
];

TestTheory/@AllRules;
