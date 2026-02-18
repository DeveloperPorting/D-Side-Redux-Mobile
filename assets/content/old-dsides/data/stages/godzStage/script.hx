function onLoad()
{
    mightyStage = new FlxTypedGroup();
    ristarStage = new FlxTypedGroup();
    vectorStage = new FlxTypedGroup();
    alexStage = new FlxTypedGroup();
    ristarStageFG = new FlxTypedGroup();

    barrel = newShader('barrel');
    barrel.setFloat('dis1', 0);
    barrel.setFloat('dis2', 0);

    mosaic = newShader('mosaic');
    mosaic.setFloatArray('uBlocksize', [0.00001, 0.00001]);

    camGame.addShader(barrel);
    camHUD.addShader(barrel);
    camGame.addShader(mosaic);
    // barrelDistortionFilter = new ShaderFilter(barrelDistortionShader);

    // mosaicShader = new MosaicEffect();
    // mosaicFilter = new ShaderFilter(mosaicShader.shader);

    // camGame.setFilters([mosaicFilter, barrelDistortionFilter]);

    // da MIGHTY STAGE
    var cock:BGSprite = new BGSprite('backgrounds/exe/godz/mighty/segasonicz_sky', 0, 0, 0.75, 0.75);
    mightyStage.add(cock);

    var penis:BGSprite = new BGSprite('backgrounds/exe/godz/mighty/segasonicz_wall', 0, 0, 0.8, 0.8);
    mightyStage.add(penis);

    var phallic:BGSprite = new BGSprite('backgrounds/exe/godz/mighty/segasonicz_machine', 0, 0, 0.9, 0.9);
    mightyStage.add(phallic);

    var dick:BGSprite = new BGSprite('backgrounds/exe/godz/mighty/segasonicz_platform', 0, 0, 1, 1);
    mightyStage.add(dick);

    // da RISTAR STAGE
    var ass:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/ristarzsky', 0, 0, 0.5, 0.5);
    ristarStage.add(ass);

    var booty:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/ristarzmountains', 0, 0, 0.6, 0.6);
    ristarStage.add(booty);

    var cheeks:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/ristarzfartrees', 0, 720, 0.75, 0.75);
    ristarStage.add(cheeks);

    var bum:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/ristarzplants', 0, 0, 0.9, 0.9);
    ristarStage.add(bum);

    var butt:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/ristarzplatform', 0, 780, 1, 1);
    ristarStage.add(butt);

    var fanny:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/frontplantleft', 0, 980, 1.05, 0.85);
    ristarStageFG.add(fanny);

    var hind:BGSprite = new BGSprite('backgrounds/exe/godz/riztar/frontplantright', 1820, 980, 1.05, 0.85);
    ristarStageFG.add(hind);

    // da motha fl*pping VECTOR STAGE
    var breasts:BGSprite = new BGSprite('backgrounds/exe/godz/vector/vectorback', -100, 0, 0.5, 0.5);
    // breasts.scale.set(0.85, 0.85); // why is it SCALED duskie //who? // YOU
    // breasts.updateHitbox();
    vectorStage.add(breasts);

    var boobs:BGSprite = new BGSprite('backgrounds/exe/godz/vector/vectortreeback', -100, -100, 0.8, 0.8);
    // boobs.scale.set(0.85, 0.85); // why is it SCALED duskie //who? // YOU
    // boobs.updateHitbox();
    vectorStage.add(boobs);

    var titties:BGSprite = new BGSprite('backgrounds/exe/godz/vector/vectorsecondtrees', 0, -100, 0.9, 0.9);
    // titties.scale.set(0.85, 0.85); // why is it SCALED duskie //who? // YOU
    // titties.updateHitbox();
    vectorStage.add(titties);

    var bosoms:BGSprite = new BGSprite('backgrounds/exe/godz/vector/vectorstage', 70, 0, 1.0, 1.0);
    vectorStage.add(bosoms);
    
    // I suck his dick with a smile for hours at a time
    var balls:BGSprite = new BGSprite('backgrounds/exe/godz/alex/castlesky', 0, 0, 0.8, 0.8);
    alexStage.add(balls);

    var nuts:BGSprite = new BGSprite('backgrounds/exe/godz/alex/castle', 0, 0, 1.0, 1.0);
    alexStage.add(nuts);

    for(shit in ristarStage.members)shit.visible=false;
    for(shit in ristarStageFG.members)shit.visible=false;
    for(shit in vectorStage.members)shit.visible=false;
    for(shit in alexStage.members)shit.visible=false;

    add(mightyStage);
    add(ristarStage);
    add(vectorStage);
    add(alexStage);

    ristarStageFG.zIndex = 999;
    add(ristarStageFG);
}

function onCreatePost()
{
    staticFade = new BGSprite('Static', 0, 0, 0, 0, ['Static'], true);
    staticFade.setGraphicSize(FlxG.width, FlxG.height);
    staticFade.screenCenter();
    staticFade.alpha = 0;
    staticFade.cameras = [camGame];
    add(staticFade);

    blackFade = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
    blackFade.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
    blackFade.alpha = 0;
    blackFade.cameras = [camGame];
    add(blackFade);
}

function onEvent(eventName, value1, value2)
{
    switch(eventName)
    {
        case 'Dark Fade':
            var a:Float = Std.parseFloat(value1);
            if(Math.isNaN(a) || a <= 0) a = 0;

            var t:Float = Std.parseFloat(value2);
            if(Math.isNaN(t) || t <= 0) t = 0.5;
            
            FlxTween.tween(blackFade, {alpha: a}, t, {ease:FlxEase.quadInOut});
        case 'Static Flash':
            staticFade.alpha = 1;
            FlxTween.tween(staticFade, {alpha: 0}, 0.35, {ease:FlxEase.quadInOut});

        case 'Cycles Stage':
            health = 1;
            for(shit in ristarStage.members)shit.visible=value1=='ristar';
            for(shit in ristarStageFG.members)shit.visible=value1=='ristar';
            for(shit in vectorStage.members)shit.visible=value1=='vectorman';
            for(shit in alexStage.members)shit.visible=value1=='alex';
            for(shit in mightyStage.members)shit.visible = value1=='mighty';
            if(StringTools.trim(value1)==''){
                boyfriend.visible=false;
                defaultZoom = 0.55;
            }else
                defaultZoom = 0.7;
        case 'Barrel Distort Options':
            switch(value1){
                case "1":
                    tweenBarrel('dis1', Std.parseFloat(value2), 0.5, FlxEase.linear);
                case "2":
                    tweenBarrel('dis2', Std.parseFloat(value2), 0.5, FlxEase.linear);
                case "1 - quadinout":
                    tweenBarrel('dis1', Std.parseFloat(value2), 0.5, FlxEase.quadInOut);
                case "2 - quadinout":
                    tweenBarrel('dis2', Std.parseFloat(value2), 0.5, FlxEase.quadInOut);
                case "1 - cubeInOut":
                    tweenBarrel('dis1', Std.parseFloat(value2), 0.5, FlxEase.cubeInOut);
                case "2 - cubeInOut":
                    tweenBarrel('dis2', Std.parseFloat(value2), 0.5, FlxEase.cubeInOut);
                case "1 - backOut":
                    tweenBarrel('dis1', Std.parseFloat(value2), 0.5, FlxEase.backOut);
                case "2 - backOut":
                    tweenBarrel('dis2', Std.parseFloat(value2), 0.5, FlxEase.backOut);
            }
        case 'Mosaic Effect Options':
            switch(value1){
                case "IN":
                    FlxTween.num(0.000001, Std.parseFloat(value2), 1, {onUpdate: (t)->{
                        mosaic.setFloatArray('uBlocksize', [t.value, t.value]);
                    }});
                case "OUT":
                    FlxTween.num(Std.parseFloat(value2), 0.000001, 1, {onUpdate: (t)->{
                        mosaic.setFloatArray('uBlocksize', [t.value, t.value]);
                    }});
            }
    }
}

function tweenBarrel(vari, val, time, ease)
{
    FlxTween.num(barrel.getFloat(vari), val, time, {ease: ease, onUpdate: (t)->{
        barrel.setFloat(vari, t.value);
    }});
}

function onMoveCamera(focus)
{
    defaultCamZoom = focus == 'dad' ? (dad.curCharacter == 'vectorman' ? 0.5 : 0.625) : 0.8;
}

var iconTween:FlxTween;
function opponentNoteHit(note)
{
    var animToPlay = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'][note.noteData];
    var iconP2 = playHUD.iconP2;

    if (dad.curCharacter == 'godzdark'){
        if (iconTween != null)
        {
            iconTween.cancel();
            iconTween = null;
        }
        switch(animToPlay){
            case 'singLEFT':
                iconP2.alpha=1;
                iconP2.changeIcon("godvector");
            case 'singRIGHT':
                iconP2.alpha=1;
                iconP2.changeIcon("riztar");
            case 'singUP':
                iconP2.alpha=1;
                iconP2.changeIcon("godkid");
            case 'singDOWN':
                iconP2.alpha = 1;
                iconP2.changeIcon("godz");
            default:
                iconP2.alpha=0;
        }
        if (animToPlay == 'singLEFT' || animToPlay == 'singRIGHT' || animToPlay == 'singUP' || animToPlay == 'singDOWN')
        {
            iconTween = FlxTween.tween(iconP2, {alpha: 0}, 0.25, {
                onComplete: function(twn:FlxTween)
                {
                    iconTween = null;
                }
            });
        }
    }
}