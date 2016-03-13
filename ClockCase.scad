pad=0.1;
width=165;
height=110;
ledHeight=11;
pcbThick=1.6;
plexThick=3;
thickness=3;
overHang=5;
$fn=40;
lipGap=.1;

// big standoff
bsH=8.15;
//small Standoff
ssH=6.10;

// Standoff Barrel Width
barW=7;

// Standoff Thread Length, diameter, and gap
sThread=6.5;
sDia=3.5;
sGap=.45;

// Standoff Locations
s1x=68.58;
s1y=43.815;

s2x=-68.58;
s2y=43.815;

s3x=68.58;
s3y=-43.815;

s4x=-67.31;
s4y=-43.815;

button1X=s2x+.45*25.4;
button1Y=s2y-.05*25.4;
button2X=s2x+1.15*25.4;
button2Y=s2y-.05*25.4;
buttonDia=11;

m1yPos=5.08;
m1xPos=5.08;

powerDia=11;
powerDip=5;
powerLocation=36.5;

zThick=ledHeight+plexThick+thickness+pcbThick+overHang;
totalZ=38;
zBack=totalZ-zThick+thickness;

// Back Screw holes
headDia=6;
threadDia=3.5;
screwDepth=totalZ-32.5+thickness;

module SqrCol(radius,length)
{
	translate([-radius,0,-pad])
		union()
		{
			cylinder(r=radius,h=length+2*radius+2*pad);
			translate([-radius,-radius,0])
				cube([radius,2*radius,length+2*radius+2*pad]);
		}

}

module BaseBox(width,depth,height,radius,thickness,bottomThickness)
{
	difference()
	{
		BaseCube(width,depth,height+radius+pad,radius);
		translate([thickness,thickness,bottomThickness])
			BaseCube(width-2*thickness,depth-2*thickness,height+radius,radius);
		translate([-pad,-pad,height])
			cube([width+2*pad,depth+2*pad,radius*2+pad]);
	}
}

module BaseCube(width,depth,height,radius)
{
	translate([radius,radius,radius])
		render()
			minkowski()
			{
				sphere(r=radius);
				cube([width-2*radius,depth-2*radius,height-radius]);
			}
	
}

module BaseSqr(width,depth,height,radius)
{
	translate([radius,radius,0])
		render()
			minkowski()
			{
				cylinder(r=radius,h=height/2);
				cube([width-2*radius,depth-2*radius,height/2]);
			}
	
}

module CurveHole(width,depth,height,radius)
{
	translate([-radius,-radius,0])
		difference()
		{
			cube([width+2*radius,depth+2*radius,height]);
			rotate([0,90,0])
				SqrCol(radius,width);
			rotate([0,90,0])
				translate([0,depth+2*radius,0])
					SqrCol(radius,width);
			rotate([0,90,90])
				SqrCol(radius,depth);
			rotate([0,90,90])
				translate([0,-width-2*radius,0])
					SqrCol(radius,depth);
		}
}

module standoffMount(sHigh,theGap)
{
	difference()
	{
		cylinder(r=barW/2,h=sHigh,$fn=15);
		translate([0,0,sHigh-(sThread+theGap)])
			cylinder(r=sDia/2+theGap,h=sHigh,$fn=15);
	}
}
module standoffMountHole(sHigh,theGap)
{
	cylinder(r=barW/2,h=sHigh,$fn=15);
}


module standoffSet()
{

	mountH=ledHeight+plexThick+thickness-ssH;
	union()
	{
		translate([s1x,s1y,0])
			standoffMount(mountH,sGap);
		translate([s2x,s2y,0])
			standoffMount(mountH,sGap);
		translate([s3x,s3y,0])
			standoffMount(mountH,sGap);
		translate([s4x,s4y,0])
			standoffMount(mountH,sGap);

	}
}
module standoffSetHole()
{

	mountH=ledHeight+plexThick+thickness-ssH;
	union()
	{
		translate([s1x,s1y,0])
			cylinder(r=barW/2-pad,h=mountH,$fn=15);
		translate([s2x,s2y,0])
			cylinder(r=barW/2-pad,h=mountH,$fn=15);
		translate([s3x,s3y,0])
			cylinder(r=barW/2-pad,h=mountH,$fn=15);
		translate([s4x,s4y,0])
			cylinder(r=barW/2-pad,h=mountH,$fn=15);

	}
}

module plexHole()
{
	uLeftx=-78.42;
	uLefty=33.66;

	plexX=147;
	plexY=54;

	lip=3;

	union()
	{
		translate([uLeftx+lip,uLefty-plexY+lip,-pad])
			CurveHole(plexX-2*lip,plexY-2*lip,plexThick+thickness+pad,2);
		translate([uLeftx,uLefty-plexY,thickness])
			cube([plexX,plexY,plexThick+pad]);

	}
}

module photoTranHole()
{
	tranX=55.88;
	tranY=40.01;
	tranDia=5.0;

	translate([tranX,tranY,-pad])
		cylinder(r=tranDia/2,h=plexThick+thickness+2*pad,$fn=15);

}

module thermHole()
{
	thrmW=thickness+4*pad;
	thrmD=10.16;
	thrmH=zThick;

	thrmX=-(width+2*thickness)/2-5+pad+thickness;
	thrmY=27.305;
	thrmZ=zThick-overHang-5;

	translate([thrmX,thrmY,thrmZ])
		cube([thrmW,thrmD,thrmH]);
}

module powerHole()
{
	translate([-(width+thickness)/2-thickness*3,-(height+thickness)/2+powerLocation,zThick-(powerDip-powerDia/2)])
		rotate([0,90,0])
			cylinder(r=powerDia/2,h=thickness*3);
}

module lip()
{
	translate([-78.42-12+thickness/2-lipGap,-(height+thickness)/2-lipGap,zThick-thickness])
		BaseSqr(width+thickness+2*lipGap,height+thickness+2*lipGap,thickness+pad,2);
}

module body()
{
	translate([-78.42-12,-(height+2*thickness)/2,0])
		BaseBox(width+2*thickness,height+2*thickness,zThick,2,thickness,2*thickness);

}


module backBody()
{
	rotate([0,180,0])
		translate([-78.42-11.5+(90.42-(width+2*thickness)/2)*2,-(height+2*thickness)/2,0])
			BaseBox(width+2*thickness,height+2*thickness,zBack,2,thickness,thickness);

}

module backLip()
{
	rotate([0,180,0])
	translate([-78.42-11.5+(90.42-(width+2*thickness)/2)*2-3/2*thickness+lipGap,-(height+2*thickness)/2-3/2*thickness+lipGap,zBack-thickness])
		difference()
		{
			BaseSqr(width+4*thickness,height+4*thickness,thickness+2*pad,2);
			translate([2*thickness,2*thickness,-pad])
				BaseSqr(width+thickness-2*lipGap,height+thickness-2*lipGap,thickness+4*pad,2);
		}
}

module backPowerHole()
{
	rotate([0,180,0])
		translate([(width+thickness)/2,-(height+thickness)/2+powerLocation,zBack-(powerDia/2-powerDip)-thickness])
			rotate([0,90,0])
				union()
				{
					cylinder(r=powerDia/2,h=thickness*3);
					translate([-powerDia/2,-powerDia/2,0])
						cube([powerDia/2,powerDia,thickness*3]);
				}
}

module screwHole()
{
	translate([0,0,-screwDepth])
		difference()
		{
			cylinder(r=headDia/2+thickness,h=screwDepth);
			translate([0,0,thickness])
				cylinder(r=headDia/2,h=screwDepth);
			translate([0,0,-pad])
				cylinder(r=threadDia/2,h=screwDepth+2*pad);
		}

}

module screwSet()
{

	mountH=ledHeight+plexThick+thickness-ssH;
	union()
	{
		translate([s1x,s1y,0])
			screwHole();
		translate([s2x,s2y,0])
			screwHole();
		translate([s3x,s3y,0])
			screwHole();
		translate([s4x,s4y,0])
			screwHole();

	}
}

module screwSetHole()
{

	mountH=ledHeight+plexThick+thickness-ssH;
	union()
	{
		translate([s1x,s1y,-thickness-pad])
			cylinder(r=headDia/2+thickness-pad,h=thickness+2*pad,$fn=15);
		translate([s2x,s2y,-thickness-pad])
			cylinder(r=headDia/2+thickness-pad,h=thickness+2*pad,$fn=15);
		translate([s3x,s3y,-thickness-pad])
			cylinder(r=headDia/2+thickness-pad,h=thickness+2*pad,$fn=15);
		translate([s4x,s4y,-thickness-pad])
			cylinder(r=headDia/2+thickness-pad,h=thickness+2*pad,$fn=15);

	}
}

module buttons()
{
	translate([button1X,button1Y,-zBack+thickness+pad])
		cylinder(r=buttonDia/2,h=zBack);
	translate([button2X,button2Y,-thickness-pad])
		cylinder(r=buttonDia/2,h=thickness+2*pad);

}

module standbase()
{
	w=width+2*thickness;
	h=10;
	r=h/2+(w*w)/(8*h);

	translate([0,0,15])
		difference()
		{
			translate([0,0,-r+10])
				sphere(r=r,$fn=100);
			translate([0,0,-r])
				cube([2*r,2*r,2*r],center=true);
		}
	cylinder(r=w/2,h=15+pad,$fn=100);
}

module standslot()
{
	x=zThick+zBack-thickness;
	echo (x);
	translate([0,-(zThick+zBack-thickness+.5)/2,thickness])
		rotate([10,0,0])
			translate([0,(zThick+zBack-thickness+.5)/2,height/2])
				cube([(width+2*thickness)*1.1,zThick+zBack-thickness+.5,height],center=true);
}

module front()
{
	union()
	{
		standoffSet();
		difference()
		{
			body();
			translate([0,0,pad])
				standoffSetHole();
			plexHole();
			photoTranHole();
			lip();
			powerHole();
		}

	}
}

module back()
{
	rotate([180,0,0])
		difference()
		{
			union()
			{
				difference()
				{
					backBody();
					screwSetHole();
					backLip();
					backPowerHole();
				}
				screwSet();
			}
			buttons();
		}
}


module stand()
{
	difference()
	{
		standbase();
		standslot();
	}
}

stand();
translate([200,0,0])
	front();
translate([-200,0,0])
	back();

//front();
//translate([0,0,zBack+zThick-thickness])
//	rotate([0,180,0])
//		back();

