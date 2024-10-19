function create() {
    CoolUtil.playMenuSong(true);
    add(new FlxSprite().loadGraphic(Paths.image("menubg"))).alpha = Math.PI/10;
    for(a in 0...4){
        add(sprite = new FlxSprite().loadGraphic(Paths.image("credit/" + ["nep", "moler", "care", "rock"][a])));
        sprite.x = FlxG.width/2.5 - sprite.width / 2 - 100;
        sprite.y = FlxG.height / 5 * (a + 1) - sprite.height/2;
        add(txt = new FunkinText(FlxG.width/2 - 100, sprite.y + 24, 0, ["Nep - Composer, visuals, artist", "Moler - Artist", "Care - Coder", "Gydya - Charter"][a], 48, true)).antialiasing = true;
    }
    add(vig = new FlxSprite().loadGraphic(Paths.image("credit/vig")));
}

function update() {
    vig.alpha = 0.5 + (Math.sin(Conductor.songPosition / 1000) / 2);
    if(controls.BACK) FlxG.switchState(new ModState("MENUS"));
}