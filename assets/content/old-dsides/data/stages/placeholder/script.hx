function onLoad()
{
    var bg = new FlxSprite(-238, -321).loadGraphic(Paths.image('backgrounds/week0/TestWeekBG'));
    add(bg);

    var floor = new FlxSprite(-420, -377).loadGraphic(Paths.image('backgrounds/week0/TestWeekFore'));
    floor.zIndex = 999;
    floor.scrollFactor.set(0.6,1);
    add(floor);
}