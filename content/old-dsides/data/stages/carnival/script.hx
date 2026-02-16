function onLoad()
{
    var sky:BGSprite = new BGSprite('backgrounds/tricky/tricky_sky', 0, 0, 1, 1, true);
    add(sky);

    var floatingplatforms:BGSprite = new BGSprite('backgrounds/tricky/tricky_floating', 0, 0, 1, 1, true);
    add(floatingplatforms);

    var floor:BGSprite = new BGSprite('backgrounds/tricky/tricky_floor', 0, 50, 1, 1, true);
    add(floor);

    hotdogstand = new FlxSprite(200, 50);
    hotdogstand.loadGraphic(Paths.image("backgrounds/tricky/tricky_hotdog"));
    hotdogstand.scrollFactor.set(0.8, 0.8);
}