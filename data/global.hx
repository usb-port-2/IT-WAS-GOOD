import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.ShaderResizeFix;
import openfl.system.Capabilities;

var noise:CustomShader = new CustomShader("static");
var time:Float = 0;

var redirectStates:Map<FlxState, String> = [
	TitleState => "MENUS",
	FreeplayState => "MENUS",
	MainMenuState => "MENUS",
];

function new() {
	Framerate.debugMode = 0;

	noise.strengthMulti = 0.6;
	noise.imtoolazytonamethis = 0.3;
	FlxG.game.addShader(noise);
	windowShit(1024, 768, 0.8);
	FlxG.mouse.visible = true;
}

function preStateSwitch() {
	for (redirectState in redirectStates.keys()) 
		if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function update(elapsed:Float) {
	noise.iTime = (time += elapsed / 2);
}

function destroy() {
	FlxG.game.removeShader(noise);
	windowShit(1280, 720);
}

function postStateSwitch()
	windowShit(1024, 768, 0.8);

var winWidth = Math.floor(Capabilities.screenResolutionX * (3 / 4)) > Capabilities.screenResolutionY ? Math.floor(Capabilities.screenResolutionY * (4 / 3)) : Capabilities.screenResolutionX;
var winHeight = Math.floor(Capabilities.screenResolutionX * (3 / 4)) > Capabilities.screenResolutionY ? Capabilities.screenResolutionY : Math.floor(Capabilities.screenResolutionX * (3 / 4));

public static function windowShit(newWidth:Int, newHeight:Int, scale:Float = 0.8){
	if(newWidth == 1024 && newHeight == 768)
		FlxG.resizeWindow(winWidth * scale, winHeight * scale);
	else
		FlxG.resizeWindow(newWidth, newHeight);
	FlxG.resizeGame(newWidth, newHeight);
	FlxG.scaleMode.width = FlxG.width = FlxG.initialWidth = newWidth;
	FlxG.scaleMode.height = FlxG.height = FlxG.initialHeight = newHeight;
	ShaderResizeFix.doResizeFix = true;
	ShaderResizeFix.fixSpritesShadersSizes();
	window.x = Capabilities.screenResolutionX/2 - window.width/2;
	window.y = Capabilities.screenResolutionY/2 - window.height/2;
	window.resizable = !(newWidth == 1024 && newHeight == 768);
}