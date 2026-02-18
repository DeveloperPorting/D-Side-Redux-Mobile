var TENMA_X:Float = 913;
var TENMA_Y:Float = 72;
var GODZ_X:Float = 937;
var GODZ_Y:Float = -177;
var ZEPH_X:Float = 1170;
var ZEPH_Y:Float = 166;

var MAZIN_X:Float = 320;
var MAZIN_Y:Float = -92;
var LORDX_X:Float = -90;
var LORDX_Y:Float = -34;
var XENO_X:Float = -190;
var XENO_Y:Float = 134;

function onLoad()
{
    var feast:FlxSprite = new FlxSprite(-700, -600);
    feast.loadGraphic(Paths.image("backgrounds/exe/feast/GODFEAST"));
    add(feast);

    var sunkmit:FlxSprite = new FlxSprite(450);
    sunkmit.frames = Paths.getSparrowAtlas("backgrounds/exe/feast/GodFeastSunkyandMitteSheet");
    sunkmit.animation.addByPrefix('show', 'sunkyiandmitee', 24, true);
    sunkmit.animation.play('show');
    add(sunkmit);

    var table:FlxSprite = new FlxSprite(-300, 154);
    table.frames = Paths.getSparrowAtlas("backgrounds/exe/feast/GodFeastTable");
    table.animation.addByPrefix('table', 'table', 24, true);
    table.animation.play('table');
    add(table);

    scourge = new FlxSprite(1500, -300);
    scourge.frames = Paths.getSparrowAtlas("backgrounds/exe/feast/GodFeastScourgeSheet");
    scourge.animation.addByPrefix('bop', 'scourge', 24, false);
    scourge.scrollFactor.set(0.6, 0.8);
    scourge.zIndex = 999;
    add(scourge);

    fleetway = new FlxSprite(-860, -100);
    fleetway.frames = Paths.getSparrowAtlas("backgrounds/exe/feast/GodFeastFleetwaySuperAssets");
    fleetway.animation.addByPrefix('bop', 'fleetwaysuper', 24, false);
    fleetway.scrollFactor.set(0.6, 0.8);
    fleetway.zIndex = 999;
    add(fleetway);
    
    rhyme = new FlxSprite(ZEPH_X + 5, ZEPH_Y - 33);
    rhyme.frames = Paths.getSparrowAtlas("characters/feast/GodFeastMightyZIPRhyme");
    rhyme.animation.addByPrefix('rhyme', 'mightyrhyme', 24, true);
    // rhyme.animation.play('rhyme');
    rhyme.visible = false;
    rhyme.zIndex = 999;
    add(rhyme);

}

function onCreatePost()
{
    tenma = new Character(913, 72, 'feast-tenma');
    tenma.isPlayer = true;
    tenma.flipX = !tenma.flipX;
    add(tenma);

    godz = new Character(940, -178, 'feast-z');
    godz.isPlayer = true;
    godz.flipX = !godz.flipX;
    add(godz);

    mazin = new Character(219, -90, 'feast-mazin');
    add(mazin);

    lordx = new Character(-191, -32, 'feast-x');
    add(lordx);

    dadGroup.zIndex = 1;
    boyfriendGroup.zIndex = 1;

    blackFade = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
    blackFade.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
    blackFade.alpha = 0;
    blackFade.cameras = [camGame];
    blackFade.zIndex = 2000000;
    stage.add(blackFade);
    refreshZ(stage);

    deadSprite = new FlxSprite().setFrames(Paths.getSparrowAtlas('characters/feast/GodFeastMightyZIPGameOverSheet'));
    deadSprite.animation.addByPrefix('die', 'mightygameover', 24, false);
    // deadSprite.animation.play('die');
    deadSprite.screenCenter();
    // deadSprite.x -= 40;
    deadSprite.y += 150;
    deadSprite.camera = camOther;
    deadSprite.visible = false;
    add(deadSprite);

    // snapCamToPos(boyfriend.x, boyfriend.y, true);
}

function charBeats()
{
    mazin.onBeatHit(curBeat);
    lordx.onBeatHit(curBeat);
    tenma.onBeatHit(curBeat);
    godz.onBeatHit(curBeat);

    if(curBeat % 2 == 0){
        fleetway.animation.play('bop', true);
        scourge.animation.play('bop', true);
    }
}

function onCountdownTick(){
    charBeats();
}

function onBeatHit(){
    charBeats();

    if (tenma.holdTimer > Conductor.stepCrotchet * 0.0011 * tenma.singDuration
    && StringTools.startsWith(tenma.getAnimName(), 'sing')
    && !StringTools.endsWith(tenma.getAnimName(), 'miss')) tenma.dance();

    if (godz.holdTimer > Conductor.stepCrotchet * 0.0011 * godz.singDuration
    && StringTools.startsWith(godz.getAnimName(), 'sing')
    && !StringTools.endsWith(godz.getAnimName(), 'miss')) godz.dance();
}

function goodNoteHitPre(note)
{
    if(note.noteType != ''){
        var poop = switch(note.noteType)
        {
            case 'Tenma Feast':
                tenma;
            case 'Mazin Feast': 
                tenma;
            case 'GodZ Feast':
                godz;
            case 'Zeph Feast':
                boyfriend;
        }
        playerStrums.owner = poop;

    }else{
        playerStrums.owner = boyfriend;
        
        tenma.playAnim(boyfriend.getAnimName(), true, false, boyfriend.animCurFrame);
        tenma.holdTimer = 0;

        godz.playAnim(boyfriend.getAnimName(), true, false, boyfriend.animCurFrame);
        godz.holdTimer = 0;
    }
    playHUD.iconP1.changeIcon(playerStrums.owner.healthIcon);

}

function opponentNoteHitPre(note)
{
    if(note.noteType != ''){
        var poop = switch(note.noteType)
        {
            case 'Mazin Feast':
                mazin;
            case 'LordX Feast':
                lordx;
            case 'Xeno Feast':
                dad;    
        }
        opponentStrums.owner = poop;
    } else{
        opponentStrums.owner = dad;

        mazin.playAnim(dad.getAnimName(), true, false, dad.animCurFrame);
        mazin.holdTimer = 0;

        lordx.playAnim(dad.getAnimName(), true, false, dad.animCurFrame);
        lordx.holdTimer = 0;
    }

    playHUD.iconP2.changeIcon(opponentStrums.owner.healthIcon);
}

function onEvent(eventName, value1, value2)
{
    switch(eventName){
        case 'Dark Fade':
            var a:Float = Std.parseFloat(value1);
            if(Math.isNaN(a) || a <= 0) a = 0;

            var t:Float = Std.parseFloat(value2);
            if(Math.isNaN(t) || t <= 0) t = 0.5;
            
            FlxTween.tween(blackFade, {alpha: a}, t, {ease:FlxEase.quadInOut});
        case 'Feast Rhyme':
            switch(value1){
                case "yay":
                    rhyme.visible = true;
                    rhyme.animation.play('rhyme');
                    boyfriend.visible = false;
                    FlxTween.tween(camHUD, {alpha: 0}, 2);
                    defaultCamZoom = 0.8;
                case "hey":
                    FlxTween.tween(camHUD, {alpha: 1}, 2);						
                case "nay":
                    boyfriend.visible = true;
                    rhyme.visible = false;	
                    defaultCamZoom = 0.65;
            }
    }
}

var can = true;
function onGameOver()
{
    if(can)
    {
        camOther.zoom -= 0.6;
        
        can = false;
        isDead = true;
        canPause = false;

        volumeMult = 0;
        KillNotes();

        camGame.visible = false;
		camHUD.visible = false;
		deadSprite.visible = true;
        deadSprite.animation.play('die');

        FlxG.sound.play(Paths.sound('start-feast'));
    }

    return ScriptConstants.STOP_FUNC;
}

function onUpdate(elasped)
{
    if(!can)
    {
        if(FlxG.keys.justPressed.ENTER){
			camOther.fade(FlxColor.BLACK, 2);
			FlxTimer.wait(2.1, FlxG.resetState);
        }
    }
}