function onLoad() {
	// var spr = new FlxSprite(-400, -100).loadGraphic(Paths.image('backgrounds/week7/planemanbg'));
	// spr.scrollFactor.set(0.2, 0.2);
	// spr.scale.set(0.8, 0.8);
	// spr.updateHitbox();
	// add(spr);

	var spr = new FlxSprite(-100, -60).loadGraphic(Paths.image('backgrounds/week7/planeman_floor'));
	spr.scrollFactor.set(0.68, 0.68);
	spr.angularVelocity = 200;
	add(spr);
}
