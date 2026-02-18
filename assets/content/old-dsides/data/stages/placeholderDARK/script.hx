function onLoad()
{
    var bg = new FlxSprite(-238, -321).loadGraphic(Paths.image('backgrounds/week0/TestWeekBGDARK'));
    add(bg);

    var floor = new FlxSprite(-420, -377).loadGraphic(Paths.image('backgrounds/week0/TestWeekForeDARK'));
    floor.zIndex = 999;
    floor.scrollFactor.set(0.6,1);
    add(floor);
}

function onCreatePost()
{
    if(PlayState.SONG.song.toLowerCase() == 'test')
    {       
        dad.canDance = false;
        dad.playAnim('silhouette');
    }
}

function onEvent(eventName)
{
    if(eventName == 'Play Animation')
        dad.canDance = true;
}