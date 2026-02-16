function onLoad(){
    halloweenBG = new BGSprite('backgrounds/week2/halloween_bgmonster', -200, -100, 1, 1, ['halloweem bg0', 'halloweem bg lightning strike']);
    add(halloweenBG);

    halloweenWhite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
    halloweenWhite.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.WHITE);
    halloweenWhite.alpha = 0;
    halloweenWhite.blend = BlendMode.ADD;

    //PRECACHE SOUNDS
    Paths.sound('thunder_1');
    Paths.sound('thunder_2');
}


var lightningStrikeBeat:Int = 0;
var lightningOffset:Int = 8;
function onBeatHit(){
    if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
        lightningStrikeShit();
}

function onSongStart(){
    lightningStrikeShit();
}

function lightningStrikeShit()
{
    FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
    if(!ClientPrefs.lowQuality) halloweenBG.animation.play('halloweem bg lightning strike');

    lightningStrikeBeat = curBeat;
    lightningOffset = FlxG.random.int(8, 24);
    for(m in [gf, boyfriend]){
        if(m.animOffsets.exists('scared')) {
            m.playAnim('scared', true);
            m.specialAnim = true;
            new FlxTimer().start(1, ()->{ m.specialAnim = false; m.dance(); });
        }
    }

    if(ClientPrefs.camZooms) {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;

        if(!camZooming) { //Just a way for preventing it to be permanently zoomed until Skid & Pump hits a note
            FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.5);
            FlxTween.tween(camHUD, {zoom: 1}, 0.5);
        }
    }

    if(ClientPrefs.flashing) {
        halloweenWhite.alpha = 0.4;
        FlxTween.tween(halloweenWhite, {alpha: 0.5}, 0.075);
        FlxTween.tween(halloweenWhite, {alpha: 0}, 0.25, {startDelay: 0.15});
    }
}