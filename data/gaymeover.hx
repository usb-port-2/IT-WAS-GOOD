import hxvlc.flixel.FlxVideoSprite;
import Sys;

function create(e) {
    e.cancel();

    camera = dieCam = new FlxCamera();
    dieCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(dieCam, false);

    add(vid = new FlxVideoSprite(1024/2 - 498/2, 768/2 - 474/2));
    vid.load(Assets.getPath(Paths.file('vibeos/__.mp4')));
    vid.bitmap.onEndReached.add(() -> Sys.exit(0));
    vid.play();
}