import hxvlc.flixel.FlxVideoSprite;
import openfl.system.Capabilities;

var scary:Bool = false;
introLength = 1;

PauseSubState.script = "data/pause";
GameOverSubstate.script = "data/gaymeover";

var bnw = new CustomShader("black n white");

function create() { 
    FlxG.cameras.add(camTXT = new HudCamera(), false);
    camTXT.bgColor = camHUD.bgColor;
    camTXT.downscroll = Options.downscroll;

    insert(0, vid = new FlxVideoSprite(1024/2 - 640/2, 768/2 - 480/2));
    vid.load(Assets.getPath(Paths.file('vibeos/_.mkv')));
    vid.scrollFactor.x = vid.scrollFactor.y = camHUD.alpha = camZoomingStrength = 0;
    vid.scale.x = vid.scale.y = 1.6;
    vid.antialiasing = window.borderless = !(FlxG.mouse.visible = false);
}

function stepHit(_:Int) {
    switch(_) {
        case 0:
            vid.play();
            camGame.fade(FlxColor.BLACK, Conductor.crochet/1000, true);
        case 84:
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet/1000) * 48);
        case 280 | 920:
            camZoomingStrength = 2;
            camZoomingInterval = 4;
        case 536:
            camZoomingStrength = camZoomingInterval = 1;
            scary = true;
        case 624 | 752 | 804:
            camZoomingStrength = 0;
            scary = camHUD.alpha == 0;
            camHUD.alpha = (_ == 752 ? 0 : 1);
        case 632:
            camZoomingStrength = 1;
            scary = true;
        case 760:
            camHUD.alpha = 1;
        case 988:
            camZoomingInterval = 2;
        case 1008: camZoomingStrength = camZoomingInterval = 1;
        case 1048:
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet/1000) * 2);
            camZoomingStrength = 0;
        case 1076:
            camHUD.alpha = camZoomingStrength = camZoomingInterval = 1;
            scary = true;
        case 1560: camHUD.alpha = camTXT.alpha = 0;
    }
}

function onDadHit(e) {
    camHUD.shake(0.00125 * (scary ? 2 : 1), Conductor.crochet/1000);
    if (health - 0.023 > 0) health -= 0.023;
}
function onPlayerHit(e) {
    e.showRating = e.showSplash = false;
}
function onGamePause()
    FlxG.game.addShader(bnw);
function destroy() window.borderless = false;
function onSubstateOpen() vid.pause();
function onSubstateClose() {vid.play(); FlxG.game.removeShader(bnw);}
function postUpdate() {
    if(Conductor.songPosition >= 0)
        timerTxt.text = "Time:" + Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2) + "/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2);
}
function postCreate() {    
    healthBar.numDivisions *= 1000;
    healthBar.createFilledBar(FlxColor.RED, FlxColor.WHITE);
    healthBar.percent = health;

    remove(iconP1);
    remove(iconP2);

    timerTxt = new FunkinText(5, 0, Std.int(healthBarBG.width - 100), "Time:0:00/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2), 16);
    for(num => a in [iconP1, iconP2, healthBar, healthBarBG, accuracyTxt, timerTxt, scoreTxt, missesTxt]){
        a.y += 20;
        a.antialiasing = true;
        if(Std.isOfType(a, FlxText)) {
            a.alignment = "left";
            a.size *= 1.5;
            a.camera = camTXT;
            a.setPosition(5, FlxG.height - (a.height * (num-3)) - 5);
        } else {
            a.y += 25;
        }
    }
    add(timerTxt);
}