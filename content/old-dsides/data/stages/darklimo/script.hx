import funkin.objects.Bopper;

function onLoad()
{
    var skyBG:BGSprite = new BGSprite('backgrounds/week4/limoSunsetNight', -120, -50, 0.1, 0.1);
    add(skyBG);

    limoFireworks = new FlxTypedGroup();
    for (i in 0...4)
    {
        var firework:FlxSprite = new FlxSprite((400 * i) - 300, -300);
        firework.frames = Paths.getSparrowAtlas('backgrounds/week4/firework' + i);
        firework.animation.addByIndices('firework', "Firework" + i, [0, 2, 4, 5, 6, 7, 8, 10, 11, 13, 14, 15, 16, 17, 18], "", 24, false);
        firework.animation.play('firework');
        firework.scrollFactor.set(0.2, 0.2);
        firework.visible = false;
        //firework.visible = true;
        firework.setGraphicSize(Std.int(firework.width * 0.65));
        firework.updateHitbox();
        firework.antialiasing = true;
        limoFireworks.add(firework);
    }
    add(limoFireworks);

    bgLimo = new BGSprite('backgrounds/week4/bgLimoDARK', -100, 480, 0.4, 0.4);
    add(bgLimo);

    grpLimoDancers = new FlxTypedGroup();
    add(grpLimoDancers);

    for (i in 0...5)
    {
        var dancer:Bopper = new Bopper((420 * i) + 130, bgLimo.y - 375);
        dancer.frames = Paths.getSparrowAtlas("backgrounds/week4/limoDancer");
        dancer.animation.addByIndices('danceLeft', 'bg dancer sketch DARK', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
        dancer.animation.addByIndices('danceRight', 'bg dancer sketch DARK', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
        dancer.scrollFactor.set(0.4, 0.4);
        grpLimoDancers.add(dancer);
    }

    limo = new BGSprite('backgrounds/week4/limoDriveDARK', -120, 550, 1, 1, ['Limo stage'], true);
    // limo.zIndex = 999;
    add(limo);
}

var curLight = 0;
function onBeatHit()
{
    for(i in grpLimoDancers.members) i.dance();

    if(PlayState.SONG.song.toLowerCase() != 'milf') return;

    if (curBeat % 2 == 0)
    {
        curLight = FlxG.random.int(0, 1);

        limoFireworks.members[curLight].visible = true;
        limoFireworks.members[curLight].animation.play('firework');
    }
    if (curBeat % 2 == 1)
    {
        curLight = FlxG.random.int(2, 3);

        limoFireworks.members[curLight].visible = true;
        limoFireworks.members[curLight].animation.play('firework');
    }

}

function onCountdownTick()
{
    for(i in grpLimoDancers.members) i.dance();

}

function deathAnimStart() {
	FlxG.sound.music.fadeOut(0.5, 0.2);
	FlxTimer.wait(0.2, () -> {
		gameovervoiceline = FlxG.sound.play(Paths.sound('gameoverlines/mm/mm_line_' + FlxG.random.int(1, 6)));
		gameovervoiceline.play();
		gameovervoiceline.onComplete = end_voiceline;
	});
}

function end_voiceline() {
	FlxG.sound.music.fadeIn(1.5, 0.2, 1);
}