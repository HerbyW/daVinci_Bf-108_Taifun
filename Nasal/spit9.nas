var alt = props.globals.getNode("instrumentation/altimeter/pressure-alt-ft");

aircraft.steering.init();

aircraft.livery.init("Aircraft/daVinci_Bf-108_Taifun/Models/Liveries", "sim/model/livery/name");

var logo_dialog = gui.OverlaySelector.new("Select Logo", "Aircraft/Generic/Logos", "sim/model/logo/name", nil, "sim/multiplay/generic/string");


########################################################################################################

# Landing Gears Control with help from: 707 Hangar of Constance

# prevent retraction of the landing gear when any of the wheels are compressed
setlistener("/controls/gear/gear-down", func
 {
 var down = props.globals.getNode("/controls/gear/gear-down").getBoolValue();
 var crashed = getprop("/sim/crashed") or 0;
 if (!down and (getprop("/gear/gear[0]/wow") or getprop("/gear/gear[1]/wow") or getprop("/gear/gear[4]/wow")))
  {
    if(!crashed){
  		props.globals.getNode("/controls/gear/gear-down").setBoolValue(1);
    }else{
  		props.globals.getNode("/controls/gear/gear-down").setBoolValue(0);
    }
  }
 });
 
var gearstate = 0;
setlistener("/gear/gear/position-norm", func
  { if (getprop("/gear/gear/position-norm") == 1)
    { gearstate = 0 ;}
    if (getprop("/gear/gear/position-norm") < 1)
    { gearstate = 1 ;}
    if (getprop("/gear/gear/position-norm") == 0)
    { gearstate = 0 ;}
    setprop("/gear/state", gearstate)
  }
);

setlistener("/position/gear-agl-m", func
  {
    if ((getprop("/gear/gear/position-norm") == 0) and (getprop("/position/gear-agl-m") < 100))
    {setprop("/gear/warning", 1);}
      else setprop("/gear/warning", 0)
  });


#############################################################################################################
