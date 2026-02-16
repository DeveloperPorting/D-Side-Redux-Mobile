function onLoad()
{
    var bg:BGSprite = new BGSprite('backgrounds/week5/bgWalls', -1199, -861, 0.6, 0.6);
    add(bg);

    var bgEscalator:BGSprite = new BGSprite('backgrounds/week5/bgEscalator', -1372, -802, 0.5, 0.1);
    add(bgEscalator);
    
    upperBoppers = new BGSprite('backgrounds/week5/upperBop', -237, 214, 0.5, 0.1, ['Upper Crowd Bop']);
    add(upperBoppers);
    
    var tree:BGSprite = new BGSprite('backgrounds/week5/christmasTree', 298, -307, 0.6, 0.6);
    add(tree);

    bottomBoppers = new BGSprite('backgrounds/week5/bottomBop', -153, 19, 0.9, 0.9, ['Bottom Level Boppers']);
    add(bottomBoppers);

    var fgSnow:BGSprite = new BGSprite('backgrounds/week5/fgSnow', -650, 675, 1.0, 1.0);
    add(fgSnow);

    santa = new BGSprite('backgrounds/week5/santa',  -861, 158, 1, 1, ['santa idle in fear instance 1']);
    add(santa);

}

function onBeatHit()
{
    upperBoppers.dance(true);

    bottomBoppers.dance(true);
    santa.dance(true);
}

function onCountdownTick()
{
    upperBoppers.dance(true);

    bottomBoppers.dance(true);
    santa.dance(true);
}