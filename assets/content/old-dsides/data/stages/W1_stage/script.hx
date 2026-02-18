function onLoad() {
    var bg:BGSprite = new BGSprite('backgrounds/week1/stageback', -671,-170, 0.9, 0.9);
    add(bg);

    var stageFront:BGSprite = new BGSprite('backgrounds/week1/stagefront', -579, 681, 0.9, 0.9);
    add(stageFront);
}

function onStepHit()
{
    if(PlayState.SONG.song.toLowerCase() == 'bopeebo' && curStep % 32 == 28){
        boyfriend.playAnim('hey', true);
        gf.playAnim('hey', true);
    }
}