include <../OpenSCADdesigns/MakeInclude.scad>

module itemModule()
{
	
}

module clip()
{
	//tc([-200, -400, -10], 400);
}

if(developmentRender)
{
	difference()
	{
		itemModule();
		clip();
	}
}
else
{
	itemModule();
}
