function onLoad() {
	var spr = new FlxSprite(-400, -100).loadGraphic(Paths.image('backgrounds/week7/planemanbg'));
	spr.scrollFactor.set(0.2, 0.2);
	spr.scale.set(0.8, 0.8);
	spr.updateHitbox();
	add(spr);

	var spr = new FlxSprite(-100, -60).loadGraphic(Paths.image('backgrounds/week7/planeman_floor'));
	spr.scrollFactor.set(0.68, 0.68);
	add(spr);

	b3 = new FlxSprite(1500, 450).setFrames(Paths.getSparrowAtlas('backgrounds/week7/b3dad'));
	b3.animation.addByPrefix('idle', 'b3dadinbgidle', 24, false);
	b3.scrollFactor.set(0.68, 0.68);
	add(b3);

	var spr = new FlxSprite(-50, -140).loadGraphic(Paths.image('backgrounds/week7/planeman_tent'));
	spr.scrollFactor.set(0.7, 0.7);
	add(spr);

	bun = new FlxSprite(-210, 520).setFrames(Paths.getSparrowAtlas('backgrounds/week7/BunnyTankGirl'));
	bun.animation.addByPrefix('idle', 'PlaneBunnyTankGirl', 24, false);
	bun.scrollFactor.set(0.68, 0.68);
	add(bun);

	snipe = new FlxSprite(1500, 570).setFrames(Paths.getSparrowAtlas('backgrounds/week7/Sniper'));
	snipe.animation.addByPrefix('idle', 'SniperIdle', 24, false);
	snipe.scrollFactor.set(0.68, 0.68);
	add(snipe);

	tank0 = new FlxSprite(-60, 1100).setFrames(Paths.getSparrowAtlas('backgrounds/week7/PlaneAud1'));
	tank0.animation.addByPrefix('idle', 'PlaneAud1', 24, false);
	tank0.scrollFactor.set(1.7, 1.5);
	tank0.zIndex = 1;
	add(tank0);

	tank2 = new FlxSprite(650, 1400).setFrames(Paths.getSparrowAtlas('backgrounds/week7/PlaneAud2'));
	tank2.animation.addByPrefix('idle', 'PlaneAud2', 24, false);
	tank2.scrollFactor.set(1.7, 1.5);
	tank2.zIndex = 1;
	add(tank2);

	tank3 = new FlxSprite(1450, 1375).setFrames(Paths.getSparrowAtlas('backgrounds/week7/PlaneAud3'));
	tank3.animation.addByPrefix('idle', 'PlanemanAud3', 24, false);
	tank3.scrollFactor.set(1.7, 1.5);
	tank3.zIndex = 1;
	add(tank3);

	tank5 = new FlxSprite(2150, 1400).setFrames(Paths.getSparrowAtlas('backgrounds/week7/PlaneAud4'));
	tank5.animation.addByPrefix('idle', 'PlaneAud4', 24, false);
	tank5.scrollFactor.set(1.7, 1.5);
	tank5.zIndex = 1;
	add(tank5);
}

function onCountdownTick() {
	for (i in [b3, bun, snipe, tank0, tank2, tank3, tank5])
		i.animation.play('idle', true);
}

function onBeatHit() {
	for (i in [b3, bun, snipe, tank0, tank2, tank3, tank5])
		i.animation.play('idle', true);
}
