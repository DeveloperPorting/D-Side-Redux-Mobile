import openfl.filters.ShaderFilter;
import funkin.backend.Conductor;

function onLoad()
{
    var bg = new BGSprite('backgrounds/exe/tenma/tenmacity', 0, 0, 0.7, 1.0);
    add(bg);
    var thingyLeft = new BGSprite('backgrounds/exe/tenma/tenmathing1', -100, 0, 1.0, 1.0);
    add(thingyLeft);
    var barLeft = new BGSprite('backgrounds/exe/tenma/tenmathingy2', -100, 0, 0.85, 1.0);
    add(barLeft);
    var barRight = new BGSprite('backgrounds/exe/tenma/tenmathingy1', -250, 200, 0.85, 1.0);
    add(barRight);
    var thingyRight = new BGSprite('backgrounds/exe/tenma/tenmathing2', 0, 0, 1.0, 1.0);
    add(thingyRight);

    tezma1grp = new FlxTypedGroup();
    add(tezma1grp);

    tezma2grp = new FlxTypedGroup();
    add(tezma2grp);

    for (i in 0...3)
    {
        tezma1 = new BGSprite('backgrounds/exe/tenma/tezma1', (barLeft.x + 405) - (i * 150), (barLeft.y + 300) + (i * 80), 1.0, 1.0, ['tezma1'], false);
        tezma1.ID = i;
        tezma1grp.add(tezma1);
    }
    for (i in 0...2)
    {
        tezma2 = new BGSprite('backgrounds/exe/tenma/tezma2', (barRight.x + 1800) + (i * 200), (barRight.y + 245) + (i * 30), 1.0, 1.0, ['tezma2'], false);
        tezma2.ID = i;
        tezma2grp.add(tezma2);	
    }

    // endlessShader = new EndlessEffect(3.5);

    tenmaLines = new FlxBackdrop(null, FlxAxes.XY, Std.int(-50), 0).setFrames(Paths.getSparrowAtlas('backgrounds/exe/tenma/TenmaLine'));
    tenmaLines.animation.addByPrefix('idle', 'TenmaLine', 24, true);
    tenmaLines.animation.play('idle');
    tenmaLines.antialiasing = false;
    tenmaLines.color = FlxColor.fromRGB(160, 160, 160);
    tenmaLines.velocity.x = -800;
    tenmaLines.velocity.y = -800;
    tenmaLines.alpha = 0;
    add(tenmaLines);

    var cd = new BGSprite('backgrounds/exe/tenma/tenmacd', 0, 0, 1.0, 1.0);
    add(cd);
}

function onCreatePost()
{
    sil = newShader('sillhoutte');
    sil.setFloat('inf', 0);

    dad.shader = sil;
    boyfriend.shader = sil;
}

function onEvent(eventName, value1, value2)
{
    if(eventName == 'Tenma Line')
    {
        var alph:Float = value1;
        // switch (value1.toLowerCase())
        // {
        //     case 'off' | '0':
        //         alph = 0;
        //     case 'on' | '1':
        //         alph = 1;
        // }
        // trace(value1.toLowerCase());
        // trace(alph);
        
        FlxTween.num(sil.getFloat('inf'), alph, 1, {ease: FlxEase.quadInOut, onUpdate: (t)->{
            sil.setFloat('inf', t.value);
        }});
        FlxTween.tween(tenmaLines, {alpha: alph}, 1);
    }
}

function onBeatHit()
{
    for (dancing in tezma1grp.members){
        for (danceeee in tezma2grp.members){
            //if theres a better way to format that, I DONT KNOW IT!!!!!!
            //please dont kill me neb please
            if(curBeat % 2 == 0)
                {
                    if(dancing.ID == 1)
                        dancing.dance();
                    if(danceeee.ID == 1)
                        danceeee.dance();
                }
                else
                {
                    if(dancing.ID == 0 || dancing.ID == 2)
                        dancing.dance();
                    if(danceeee.ID == 0)
                        danceeee.dance();
                }
        }
    }
}