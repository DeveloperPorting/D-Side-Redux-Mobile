function onLoad(){
    var bg:BGSprite = new BGSprite('backgrounds/week3/skyDark', -100, 0, 0.1, 0.1);
    add(bg);

    //addShaderToCamera('game', chromAb);
    //chromAb.setChrome(0.01);

    var city:BGSprite = new BGSprite('backgrounds/week3/cityDark', -10, 0, 0.3, 0.3);
    city.setGraphicSize(Std.int(city.width * 0.85));
    city.updateHitbox();

    phillyCityLights = new FlxTypedGroup();

    for (i in 0...5)
    {
        var light:BGSprite = new BGSprite('backgrounds/week3/win' + i, city.x, city.y, 0.3, 0.3);
        light.visible = false;
        light.setGraphicSize(Std.int(light.width * 0.85));
        light.updateHitbox();
        phillyCityLights.add(light);
    }
    var street:BGSprite = new BGSprite('backgrounds/week3/streetDark', -40, 50);

    var streetBehind:BGSprite = new BGSprite('backgrounds/week3/behindTrainDark', -40, 50);

    peoplelol = new BGSprite('backgrounds/week3/Crowd2DARK', -226, 116, 0.9, 0.9, ['Crowd2 instance 1']);

    add(city);
    add(phillyCityLights);
    add(streetBehind);
    add(street);
    add(peoplelol);
}

function onCountdownTick(){
    if(peoplelol != null) peoplelol.dance(true);
}

function onBeatHit(){
    if(peoplelol != null) peoplelol.dance(true);
}

function deathAnimStart() {
	FlxG.sound.music.fadeOut(0.5, 0.2);
	FlxTimer.wait(0.2, () -> {
		gameovervoiceline = FlxG.sound.play(Paths.sound('gameoverlines/pico/pico_line_' + FlxG.random.int(1, 4)));
		gameovervoiceline.play();
		gameovervoiceline.onComplete = end_voiceline;
	});
}

function end_voiceline() {
	FlxG.sound.music.fadeIn(1.5, 0.2, 1);
}

