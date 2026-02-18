import funkin.data.Chart;
import funkin.objects.Bopper;

function onLoad()
{
    var bg:BGSprite = new BGSprite('backgrounds/week5/evilBG', -601, -641, 0.5, 0.5);
    add(bg);
    audience2 = new BGSprite('backgrounds/week5/evilupperBop', -181, 254, 0.5, 0.5, ['Upper Crowd BobEvil']);
    add(audience2);


    eggballs = new FlxSprite(-645, -307);
    eggballs.frames = Paths.getSparrowAtlas('backgrounds/week5/EggBursting');
    eggballs.scrollFactor.set(0.6, 0.6);
    eggballs.animation.addByPrefix('burst', 'EggBursting', 24, false);
    eggballs.animation.addByPrefix('idle', 'EvilEgg', 24, false);
    eggballs.animation.play('idle');
    // eggballs.visible = false;
    add(eggballs);

    audience = new Bopper(-153, -9);
    audience.scrollFactor.set(1, 1);
    audience.loadGraphic(Paths.image('backgrounds/week5/evilbottomBop'));
    audience.frames = Paths.getSparrowAtlas('backgrounds/week5/evilbottomBop');
    audience.animation.addByPrefix('idle', 'Bottom Level Boppers evil', 24, false);
    audience.animation.addByPrefix('singDOWN', 'Bottom Level Boppers down', 24, false);
    audience.animation.addByPrefix('singLEFT', 'Bottom Level Boppers left', 24, false);
    audience.animation.addByPrefix('singRIGHT', 'Bottom Level Boppers right', 24, false);
    audience.animation.addByPrefix('singUP', 'Bottom Level Boppers up', 24, false);
    audience.playAnim("idle",true);
    audience.addOffset('idle',1, 0);
    audience.addOffset('singDOWN',24,-23);
    audience.addOffset('singUP',0,-44);
    audience.addOffset('singRIGHT',-12,-1);
    audience.addOffset('singLEFT',9,-5);
    audience.danceEveryNumBeats = 2;
    add(audience);

    var floor:BGSprite = new BGSprite('backgrounds/week5/evilsnow', -581,675, 1, 1);
    add(floor);

    springy = new BGSprite('backgrounds/week5/evilsanta', -753, 19, 1, 1, ['santa idle in fear evil instance 1']);
    add(springy);
}

var crowdAnims = [];
function onCreatePost()
{
    var path = (Paths.json('feaster/data/crowd', null, true));

    crowdChart = Chart.fromPath(path);

    if(crowdChart!=null){
        for(section in crowdChart.notes){
            for(note in section.sectionNotes){
                crowdAnims.push({
                    time: note[0],
                    data: Math.floor(note[1]%4),
                    length: note[2]
                });
            }
        }
    }
}

var singAnimations:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

function onUpdate(elapsed)
{
    if(crowdAnims != null){
        for(anim in crowdAnims){
            if(anim.time <= Conductor.songPosition){
                var animToPlay:String = singAnimations[anim.data];
                audience.playAnim(animToPlay, true);
                var holdingTime = Conductor.songPosition - anim.time;
                if(anim.length == 0 || anim.length < holdingTime)
                    crowdAnims.remove(anim);

            }
        }   
    }
}

function onBeatHit()
{
    audience2.dance();
    springy.dance();
    audience.dance();
}

function onCountdownTick()
{
    audience2.dance();
    springy.dance();
    audience.dance();
}

var can = true;
function onStartCountdown()
{   
    if(can)
    {
        can = false;
        audience.alpha = 0;
        gfGroup.alpha = 0;
        eggballs.visible = true;
        dad.visible = false;
        eggballs.animation.play('burst');
        FlxG.sound.play(Paths.sound('eggburst'));

        FlxTween.tween(FlxG.camera, {zoom: 0.89}, 2.5, {
            ease: FlxEase.quadInOut,
            onComplete: function(twn:FlxTween)
            {
                FlxTween.tween(FlxG.camera, {zoom: 0.72}, 0.5, {ease: FlxEase.quadInOut});
            }
        });

        eggballs.animation.finishCallback = function(pog:String)
        {
            FlxTween.tween(gfGroup, {alpha: 1}, 0.45);
            FlxTween.tween(audience, {alpha: 1}, 0.45);
            FlxTween.tween(FlxG.camera, {zoom: 0.65}, 0.5, {ease: FlxEase.quadInOut});

            eggballs.x += 1025;
            eggballs.y += 650;
            eggballs.animation.play('idle');
            audience.visible = true;

            dad.visible = true;
            dad.playAnim('enter', true);
            dad.specialAnim = true;

            startCountdown();

            eggballs.animation.finishCallback = null;
        }

        return ScriptConstants.STOP_FUNC;
    }
}