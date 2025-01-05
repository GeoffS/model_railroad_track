include <../OpenSCADdesigns/MakeInclude.scad>

// US Standard wood ties:
prototypeTieWidth = 9 * 25.4;
prototypeTieHeight = 8 * 25.4;
prototypeTieLength = 8.5 * 12 * 25.4;
prototypeTieSpacing = 19 * 25.4;

// HO:
modelScale = 1/87;
modelGauge = 10; //16.5;

tieWidth = prototypeTieWidth * modelScale;
tieHeight = prototypeTieHeight * modelScale;
tieLength = prototypeTieLength * modelScale;
tieSpacing = prototypeTieSpacing * modelScale;

// Micro Engineering Code 83:
// https://cs.trains.com/mrr/f/88/p/85478/1010853.aspx
railBaseWidth = 0.068 * 25.4;
railHeadWidth = 0.033 * 25.4;
railHeight = 0.083 * 25.4;

railSpacingCtrs = modelGauge + railHeadWidth;
echo(str("railSpacingCtrs = ", railSpacingCtrs));

module itemModule()
{
	numTies = 5;
	for (i = [0:1:numTies]) 
	{
		x = tieSpacing * (i - floor(numTies/2));
		translate([x,0,0]) tie();
	}
	
}

module tie()
{
	tcu([-tieWidth/2, -tieLength/2, -tieHeight], [tieWidth, tieLength, tieHeight]);
}

module clip(d=0)
{
	//tc([-200, -400, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
	displayGhost() rails();
	displayGhost() gauge();
}
else
{
	itemModule();
}

module rails()
{
	x = 100;
	y = railSpacingCtrs/2;
	echo(str("y = ", y));
	doubleY() translate([-x/2, y, 0]) 
	{
		rail(x);
	}
}

module rail(x)
{
	// Web:
	ww2 = railHeadWidth/2;
	tcu([0, -ww2/2, 0], [x, ww2, railHeight]);
	
	// Head:
	tcu([0, -railHeadWidth/2, railHeight-railHeadWidth], [x, railHeadWidth, railHeadWidth]);

	// Base:
	bh = railHeadWidth * 0.5;
	tcu([0, -railBaseWidth/2, 0], [x, railBaseWidth, bh]);
}

module gauge()
{
	x = 1;
	z = 10;
	yg = modelGauge - 0.05;
	ozg = railHeight/2;
	tcu([-x/2, -yg/2, ozg], [x, yg, z-ozg]);

	yh = modelGauge + 4;
	ozh = railHeight + 0.05;
	tcu([-x/2, -yh/2, ozh], [x, yh, z-ozh]);
}
