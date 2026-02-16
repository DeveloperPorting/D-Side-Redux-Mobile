var peoplelol:BGSprite;
var phillyCityLights:FlxTypedGroup;
var phillyTrain:BGSprite;
var blammedLightsBlack:FlxSprite;
var blammedLightsBlackTween:FlxTween;
var phillyCityLightsEvent:FlxTypedGroup;
var phillyCityLightsEventTween:FlxTween;
var trainSound:FlxSound;

function onLoad(){
    if(!ClientPrefs.lowQuality) {
        var bg:BGSprite = new BGSprite('backgrounds/week3/sky', -100, 0, 0.1, 0.1);
        add(bg);
    }

    var city:BGSprite = new BGSprite('backgrounds/week3/city', -10, 0, 0.3, 0.3);
    city.setGraphicSize(Std.int(city.width * 0.85));
    city.updateHitbox();

    phillyCityLights = new FlxTypedGroup();

    var streetBehind:BGSprite = new BGSprite('backgrounds/week3/behindTrain', -40, 50);

    phillyTrain = new BGSprite('backgrounds/week3/train', 2000, 360);

    trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
    Paths.sound('train_passes');
    FlxG.sound.list.add(trainSound);

    var street:BGSprite = new BGSprite('backgrounds/week3/street', -40, 50);


    add(city);
    add(phillyCityLights);
    add(phillyTrain);
    add(streetBehind);
    add(street);
    if (PlayState.SONG.song.toLowerCase() == 'philly nice'){
        peoplelol = new BGSprite('backgrounds/week3/Crowd1', -40, 215, 0.9, 0.9, ['Crowd1']);
        add(peoplelol);
    }
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