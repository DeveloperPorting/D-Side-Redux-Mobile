import funkin.objects.Bopper;

function onLoad()
{
    var zardy1:FlxSprite = new FlxSprite(-1000, -350).loadGraphic(Paths.image("backgrounds/zardy/zardybg"));

    var zardy2:FlxSprite = new FlxSprite(-1000, -350).loadGraphic(Paths.image("backgrounds/zardy/zardyclouds"));
    zardy2.active = true;
    zardy2.velocity.x = FlxG.random.float(10, -20); // the fog shouldn't walk away anymore [ untested ]
    
    var zardy3:FlxSprite = new FlxSprite(-1000, -350).loadGraphic(Paths.image("backgrounds/zardy/zardyfar1"));
    zardy3.scrollFactor.set(0.75, 0.95);

    var zardy4:FlxSprite = new FlxSprite(-1000, -350).loadGraphic(Paths.image("backgrounds/zardy/zardyground"));

    baddest_bitch = new FlxSprite(300, 25);
    baddest_bitch.frames = Paths.getSparrowAtlas("backgrounds/zardy/SHES SO FINE BRO");
    baddest_bitch.animation.addByPrefix("idle", "LILA idle", 24, true);
    baddest_bitch.animation.play("idle");

    THE_FOG = new FlxSprite();
    THE_FOG.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
    THE_FOG.scrollFactor.set(0, 0);
    THE_FOG.screenCenter();
    THE_FOG.zIndex = 2;
    add(THE_FOG);

    zardyFX = new FlxSprite(-1000, -350).loadGraphic(Paths.image("backgrounds/zardy/zardyeffectoverlay")); // image loads with the stage instead
    zardyFX.zIndex = 1;
    add(zardyFX);

    add(zardy1);
    add(zardy2);
    add(zardy3);
    add(zardy4);
    add(baddest_bitch);
}

function onCreatePost()
{
    skipCountdown = true;
    camHUD.alpha = 0;
    camGame.zoom = 0.8;

    modManager.queueFuncOnce(62 * 4, ()->{
        FlxTween.tween(camHUD, {alpha: 1}, 1);
        FlxTween.tween(THE_FOG, {alpha: 0}, 1);
        // FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {ease: FlxEase.quadInOut});
    });

    modManager.queueFuncOnce(589 * 4, ()->{
        FlxTween.tween(camHUD, {alpha: 0}, 0.5);
        FlxTween.tween(THE_FOG, {alpha: 1}, 0.5);
    });

    spookyDeath = new Bopper().setFrames(Paths.getSparrowAtlas('backgrounds/zardy/dead'));
	spookyDeath.addAnimByPrefix('dead', 'spooky DEATH', 24, true);
	spookyDeath.addAnimByPrefix('retry', 'spooky RETRY', 24, false);
	spookyDeath.playAnim('dead');
	spookyDeath.camera = camOther;
	spookyDeath.screenCenter();
	spookyDeath.visible = false;
	add(spookyDeath);
}

function onMoveCamera(focus)
{
    defaultCamZoom = focus == 'dad' ? 0.625 : 0.8;
}

var can = true;
var fuck = false;
function onGameOver()
{
	if(can)
	{
		can = false;
		fuck = false;
		isDead = true;
		canPause = false;

		volumeMult = 0;
		KillNotes();

		camGame.visible = false;
		camHUD.visible = false;
		spookyDeath.visible = true;
	}

	return ScriptConstants.STOP_FUNC;
}

var totalElapsed = 0;
function onUpdate(elapsed)
{
	if(!can && !fuck)
	{
		if(FlxG.keys.justPressed.ENTER)
		{
			fuck = true;
			FlxG.sound.play(Paths.sound("skidyeah"));
			spookyDeath.playAnim('retry');
			spookyDeath.y -= 100;

			camOther.fade(FlxColor.BLACK, 2);
			FlxTimer.wait(2.1, FlxG.resetState);

		}
	}
}