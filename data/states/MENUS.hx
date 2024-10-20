import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
var enterPressed:Bool = false;
// SUPER ASS CODE // WHAT THE FUCK HAPPENED TO THE FORMATTING???
function create() {
CoolUtil.playMenuSong(true);
add(bg = new FunkinSprite().loadGraphic(Paths.image("menubg")));
add(art = new FunkinSprite(287, 159).loadGraphic(Paths.image("menuart")));
add(play = new FunkinSprite(0, -768).loadGraphic(Paths.image("menuplay"))).alpha = 0;
add(credits = new FunkinSprite(0, 768 * 2).loadGraphic(Paths.image("menucredits"))).alpha = 0;
play.x = FlxG.width / 4 - play.width / 2;
credits.x = (FlxG.width / 4 * 3) - credits.width / 2;
add(press = new FunkinSprite(320.5, 650).loadGraphic(Paths.image("menupress")));
press.setGraphicSize(Std.int(press.width * 0.75));
add(new FunkinText(5, 748, 0, "[PRESS O FOR OPTIONS]", 16, true)).antialiasing = FlxG.mouse.visible = true;
add(flash = new FunkinSprite().makeGraphic(FlxG.width, FlxG.height)).alpha = 0;
}
function update() {
art.setPosition(287 + FlxG.random.float(-2, 2), 159 + FlxG.random.float(-2, 2));
if (controls.SWITCHMOD) {
openSubState(new ModSwitchMenu());
persistentUpdate = !(persistentDraw = true);
}
if(FlxG.keys.justPressed.O) FlxG.switchState(new OptionsMenu());
if (!enterPressed && FlxG.keys.justPressed.ANY && !controls.SWITCHMOD && !FlxG.keys.justPressed.O) {
enterPressed = true;
CoolUtil.playMenuSFX(1);
FlxTween.num(0.25, 0, 1.25, {}, (_) -> flash.alpha = _);
FlxTween.tween(press, {y: 768 * 1.1}, 1, {startDelay: 0.25, ease: FlxEase.quartInOut});
FlxTween.tween(art, {alpha: 0}, 2.25, {startDelay: 0.5, ease: FlxEase.quartInOut});
FlxTween.tween(play, {alpha: 1, y: 768 / 2 - play.height / 2}, 2.25, {startDelay: 2, ease: FlxEase.quartInOut});
FlxTween.tween(credits, {alpha: 1, y: 768 / 2 - credits.height / 2}, 2.25, {startDelay: 2, ease: FlxEase.quartInOut});
}
if (enterPressed)
for (a in 0...2) {
[play, credits][a].scale.x = [play, credits][a].scale.y = lerp([play, credits][a].scale.x, FlxG.mouse.overlaps([play, credits][a]) ? 3 : 2.5, 0.33/2);
if (FlxG.mouse.justPressed && FlxG.mouse.overlaps([play, credits][a]))
switch (a) {
case 0:
PlayState.loadSong("it was good");
FlxG.camera.fade(FlxColor.BLACK, 1, false, () -> FlxG.switchState(new PlayState()));
case 1:
FlxG.camera.fade(FlxColor.BLACK, 1, false, () -> FlxG.switchState(new ModState("CREDITS")));
}
}
}
