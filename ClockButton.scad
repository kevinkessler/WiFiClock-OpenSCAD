buttonDia=10;
buttonH=10;
buttonC=3.5;
holeDepth=5;
textSize=6;
pad=0.1;
$fn=32;

module button(label,adj)
{
	difference()
	{
		cylinder(r=buttonDia/2,h=buttonH);
		translate([0,0,buttonH-holeDepth])
			cylinder(r=buttonC/2,h=holeDepth+pad);
		translate([textSize/2*adj,-textSize/2,1-pad])
			rotate([0,180,0])
				linear_extrude(height=1)
					text(label,font="Arial",size=textSize);
	}
}

translate([0,20,0])
	button("F",.85);
button("R",1);

