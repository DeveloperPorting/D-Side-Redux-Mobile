import funkin.data.Chart;

var shitcumfartbg:FlxSprite;

typedef Anim = {
	var time:Float;
	var data:Int;
	var length:Int;
}

var anims:Array<Anim> = [];
var zooming = false;
var p2 = [];

function makeSpr(x,y,anim)
{
	var spr = new FlxSprite(x,y).setFrames(Paths.getSparrowAtlas('backgrounds/and'));
	spr.animation.addByPrefix('idle', anim, 24, false);
	spr.animation.play('idle');

	return spr;
}

function onLoad() {
	sky = makeSpr(-200, -150, 'sky');
	sky.scrollFactor.set(0.55, 0.55);
	sky.antialiasing = true;
	add(sky);

	stones = makeSpr(0, 475, 'stones');
	stones.scrollFactor.set(0.8, 0.8);
	stones.antialiasing = true;
	add(stones);

	floor = makeSpr(0, 475, 'floor');
	floor.antialiasing = true;
	add(floor);

	sky2 = makeSpr(-200, 0, '2sky');
	sky2.scrollFactor.set(0.55, 0.55);
	sky2.antialiasing = true;
	add(sky2);

	stone2 = makeSpr(-200, 0, '2stone');
	stone2.scrollFactor.set(0.8, 0.8);
	stone2.antialiasing = true;
	add(stone2);

	floor2 = makeSpr(0, 400, '2floor');
	floor2.antialiasing = true;
	add(floor2);

	p2 = [sky2, stone2, floor2];
	for (i in p2)
		i.visible = false;

	shitold = makeSpr(0,0,'shit');
	shitold.visible = false;
	add(shitold);

	if(!ClientPrefs.lowQuality){
		skrinkly = new Character(1600, 850, 'skrinkly');
		skrinkly.zIndex = 1;
		add(skrinkly);

		crowdChart = Chart.fromPath(Paths.json('and/data/crowd'));
		if (crowdChart != null) {
			for (section in crowdChart.notes) {
				for (note in section.sectionNotes) {
					anims.push({
						time: note[0],
						data: Math.floor(note[1] % 4),
						length: note[2]
					});
				}
			}
		}
	}
}

function onCreatePost() {
	if (ClientPrefs.shaders && !ClientPrefs.lowQuality) {
		var orang = newShader('colorcorrection');
		orang.setFloat('brightness', 0.0);
		orang.setFloat('contrast', 1.4);
		orang.setFloat('saturation', 0.9);
		orang.setFloat('customred', 0.235);
		orang.setFloat('customgreen', 0.05);
		orang.setFloat('customblue', 0.05);
		camGame.addShader(orang);
	}

	death = new FunkinVideoSprite();
	death.onFormat(() -> {
		death.camera = camOther;
		death.screenCenter();
	});
	death.load(Paths.video('death'));
	death.onEnd(FlxG.resetState);
	add(death);

	modManager.queueFuncOnce(2016, ()->{
		camHUD.fade(FlxColor.BLACK, 3);
	});
}

function onEvent(eventName, value1, value2) {
	switch (eventName) {
		case 'Play Animation':
			if(value1 == 'cumsplode'){
				dad.onAnimationFinish.add(()->{
					dad.visible = false;
				});
			}
		case 'Transformations':
			switch (value1) {
				case 'rareblin':
					FlxG.camera.flash(0xFFFFFFFF, 1);
					shitold.visible = true;
					if(!ClientPrefs.lowQuality)
						skrinkly.visible = false;
				case 'nvm fuck you bitch':
					FlxG.camera.flash(0xFFFFFFFF, 1);
					shitold.visible = false;
					if(!ClientPrefs.lowQuality)
						skrinkly.visible = true;
				// unimplemented. will be in 2.0 probably
				// case 'cumlord entrance':
				//     shitcumfartbg.visible = true;
				//     shitcumfartbg.animation.play("entr");
				case 'evil bye':
					dad.visible = false;
				case 'flash':
					FlxG.camera.flash(0xFFFFFFFF, 0.3);
				case 'cumlord transition':
					zooming = true;
					if(!ClientPrefs.lowQuality)
						skrinkly.visible = false;
					FlxG.camera.flash(0xFFFFFFFF, 1);
					defaultCamZoom = 0.85;

					for (i in p2)
						i.visible = true;
			}
	}
}

function onBeatHit() {
	if(ClientPrefs.lowQuality) return;

	if (!StringTools.contains(skrinkly.getAnimName(), 'sing') && curBeat % 2 == 0)
		skrinkly.dance();
}

var singAnimations:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

function onUpdate(elapsed) {
	if(ClientPrefs.lowQuality) return;

	for (anim in anims) {
		if (anim.time <= Conductor.songPosition) {
			var animToPlay:String = singAnimations[anim.data];
			skrinkly.holdTimer = 0;
			skrinkly.playAnim(animToPlay, true);
			var holdingTime = Conductor.songPosition - anim.time;
			if (anim.length == 0 || anim.length < holdingTime)
				anims.remove(anim);
		}
	}
}

function onMoveCamera(focus) {
	if (!zooming)
		return;

	switch (focus) {
		case 'dad':
			defaultCamZoom = 0.7;
		default:
			defaultCamZoom = 0.6;
	}
}

var can = true;

function onGameOver() {
	if (can) {
		can = false;

		KillNotes();
		volumeMult = 0;
		camGame.visible = false;

		death.play();
	}
	return ScriptConstants.STOP_FUNC;
}
