function onLoad()
{
    var bg = new BGSprite('backgrounds/exe/too-slow/background ladders', -200, -290, 0.75, 0.75);
    add(bg);
    var icicles = new BGSprite('backgrounds/exe/too-slow/icicles background', -121, -75, 0.85, 0.85);
    add(icicles);
    fakeTooSlow = new BGSprite('backgrounds/exe/too-slow/main stage', -490, 6, 1, 1);
    add(fakeTooSlow);
    urTooSlow = new BGSprite('backgrounds/exe/too-slow/main stage spoopy', -490, 6, 1, 1);
    add(urTooSlow);
    urTooSlow.visible=false;
}

function onCreatePost()
{
    blackFade = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
    blackFade.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
    blackFade.alpha = 0;
    blackFade.cameras = [camGame];
    add(blackFade);
}

function onStepHit()
{
    if(curStep > 1088 && curStep < 1210)vocals.volume = 1;
    switch (curStep)
    {
        case 384:
            FlxTween.tween(blackFade, {alpha: 1}, 0.45);
            FlxTween.tween(playHUD.iconP2, {alpha: 0}, 0.45);
        case 447:
            urTooSlow.visible = true;
            fakeTooSlow.visible = false;
        case 448:
            // timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
            // timeBar.updateBar();
            camHUD.flash(FlxColor.WHITE, 1);
            blackFade.alpha = 0;
            playHUD.iconP2.alpha = 1;
        case 1088:
            defaultCamZoom = 1.4;
            FlxTween.tween(camHUD, {alpha: 0}, 0.45);
        case 1210:
            FlxTween.tween(camHUD, {alpha: 1}, 0.45);
        case 1344:
            defaultCamZoom = 0.8;
        case 1760:
            if (ClientPrefs.camZooms)
                defaultCamZoom = 1.0;
        case 1765:
            if (ClientPrefs.camZooms)
                defaultCamZoom = 1.2;
        case 1769:
            if (ClientPrefs.camZooms)
                defaultCamZoom = 1.5;
        case 1776:
            if (ClientPrefs.camZooms)
                defaultCamZoom = 1.7;
    }   
}