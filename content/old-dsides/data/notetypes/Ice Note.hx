import funkin.objects.Bopper;
import funkin.backend.PlayerSettings;

var snowgrave:Bopper;
var iceReceptors:Array<FlxSprite> = [];
var frozenCounter = 0;

var controls = PlayerSettings.player1.controls;
var iceshake:Int = 0;
var randomx:Int = 0;
var boyx:Int = 0;
var chunkY:Int = 0;
var keycooldown:Int = 0;
var icechunks:FlxSpriteGroup;
var floor:FlxSprite;
var black;
var leftReceptor;
var rightReceptor;

function onCreatePost() {
	frozenBF = new FlxSprite(boyfriend.x - 40, boyfriend.y - 105);
	frozenBF.frames = Paths.getSparrowAtlas("snowgrave");
	frozenBF.animation.addByPrefix("idle","Idle_Frozen",24);
	frozenBF.animation.addByPrefix("0","1",24,false);
	frozenBF.animation.addByPrefix("1","2",24,false);
	frozenBF.animation.addByPrefix("2","3",24,false);
	frozenBF.animation.addByPrefix("3","4",24,false);
	frozenBF.animation.addByPrefix("4","4",24,false); // breakout anim
	frozenBF.antialiasing=true;
	frozenBF.visible=false;
	frozenBF.scrollFactor.set(0.95, 0.95);
	frozenBF.animation.play("idle",true);
	frozenBF.centerOffsets();
	add(frozenBF);

	boyx = boyfriend.x;

	frozenBF.visible = false;
	frozenBF.animation.play('idle');
	stage.add(frozenBF);

	black = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
	black.camera = camHUD;
	black.alpha = 0;
	add(black);

	leftReceptor = new FlxSprite().setFrames(Paths.getSparrowAtlas('iceNOTE_assets'));
	leftReceptor.animation.addByPrefix('idle', 'purple', 24, true);
	leftReceptor.animation.play('idle');
	leftReceptor.camera = camHUD;
	leftReceptor.screenCenter();
	leftReceptor.x -= FlxG.width / 8;
	leftReceptor.color = FlxColor.WHITE;
	add(leftReceptor);
	iceReceptors.push(leftReceptor);

	rightReceptor = new FlxSprite().setFrames(Paths.getSparrowAtlas('iceNOTE_assets'));
	rightReceptor.animation.addByPrefix('idle', 'red', 24, true);
	rightReceptor.animation.play('idle');
	rightReceptor.camera = camHUD;
	rightReceptor.screenCenter();
	rightReceptor.x += FlxG.width / 8;
	rightReceptor.color = 0xFF4a4a4a;
	add(rightReceptor);
	iceReceptors.push(rightReceptor);

	for (i in iceReceptors)
		i.visible = false;
}

function setupNote(note) {
	note.reloadNote('ice');
	note.noAnimation = true;
	note.hitCausesMiss = true;
	note.rgbShader.setColors([0xFFFF0000, 0xFF00FF00, 0xFF0000FF]);
}

var isFrozen = false;

function goodNoteHit(note) {
	if (note.noteType == 'Ice Note' && !isFrozen) {
		keycooldown = 10;
		isFrozen = true;
		frozenCounter = 0;

		boyfriend.visible = false;
		frozenBF.visible = true;
		frozenBF.animation.play('idle');

		playerStrums.inControl = false;
		black.alpha = 0.75;
		for (i in iceReceptors)
			i.visible = true;

		leftReceptor.color = FlxColor.WHITE;
		rightReceptor.color = 0xFF4a4a4a;

		FlxG.sound.play(Paths.sound('ice/freeze'));
	}
}

function struggle() {
	FlxG.sound.play(Paths.sound('ice/struggle'));
	frozenCounter += 1;
	iceshake = 1;
}

function breakout() {
	FlxG.camera.shake(0.015, 0.125);
	isFrozen = false;
	frozenCounter = 0;

	frozenBF.visible = false;
	boyfriend.visible = true;
	boyfriend.dance();

	playerStrums.inControl = true;
	black.alpha = 0;
	for (i in iceReceptors)
		i.visible = false;

	FlxG.sound.play(Paths.sound('ice/breakout'));
}

function onUpdate(elapsed) {
	notes.forEachAlive((note) -> {
		note.noMissAnimation = isFrozen;
	});

	if (keycooldown > 0) {
		keycooldown -= (1) * (elapsed * 60);

		if (keycooldown <= 0) {
			keycooldown = 0;
		}

		// trace(keycooldown);
	}
}

function onKeyPress(key) {
	if (isFrozen && keycooldown == 0) {
		if (frozenCounter % 2 == 0 && controls.NOTE_LEFT_P)
			struggle();
		else if (controls.NOTE_RIGHT_P)
			struggle();

		leftReceptor.color = frozenCounter % 2 == 0 ? FlxColor.WHITE : 0xFF4a4a4a;
		rightReceptor.color = frozenCounter % 2 == 0 ? 0xFF4a4a4a : FlxColor.WHITE;

		if (frozenCounter >= 5)
			breakout();
		else 
			frozenBF.animation.play(frozenCounter - 1);
	}
}
