function onLoad() {
	gumGrp = new FlxSpriteGroup();
	gumGrp.camera = camOther;
	add(gumGrp);

	for (i in 0...3) {
		var gum = new FlxSprite().loadGraphic(Paths.image('UI/game/notes/gum/cum' + (i + 1)));
		gum.setGraphicSize(1280, 720);
		gum.updateHitbox();
		gum.alpha = 0;
		gumGrp.add(gum);
	}
}

function setupNote(note) {
	note.reloadNote('gum/');
	note.hitCausesMiss = true;
	note.canMiss = true;
	note.rgbShader.setColors([0xFFFF0000, 0xFF00FF00, 0xFF0000FF]);
}

var gumCount = 0;

function onUpdate(elapsed) {
	if (gumCount >= 3)
		gumCount = 0;
}

function goodNoteHit(note) {
	if (note.noteType == 'Gum Note') {
		gumCount += 1;

		if (gumCount <= 2) {
			FlxTween.cancelTweensOf(gumGrp.members[gumCount]);
			gumGrp.members[gumCount].alpha = 1;
			FlxTween.tween(gumGrp.members[gumCount], {alpha: 0}, 10, {startDelay: 5});
		}
		FlxG.sound.play(Paths.sound("splurge"));
	}
}
