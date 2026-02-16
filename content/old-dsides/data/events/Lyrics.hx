import flixel.text.FlxText;

function onFirstPush()
{
    lyrics = new FlxText(0, 570, 0, '', 32);
    lyrics.cameras = [camOther];
    lyrics.setFormat(Paths.font("PressStart2P.ttf"), 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics.screenCenter(FlxAxes.X);
    lyrics.updateHitbox();
    add(lyrics);
}


function onTrigger(value1, value2)
{
    if(StringTools.trim(value2)=='')value2='#FFFFFF';

    lyrics.text = value1;
    lyrics.screenCenter(FlxAxes.X);
    lyrics.color = FlxColor.fromString(value2);

}

function onGameOver()
{
    lyrics.visible = false;
}