import funkin.objects.stageobjects.BackgroundGirls;
import funkin.utils.MathUtil;

function onLoad() {
    var bg:BGSprite = new BGSprite('backgrounds/week6/animatedEvilSchool', 400, 200, 1.0, 1.0, ['background 2'], true);
    bg.scale.set(5.75, 5.75);
    bg.antialiasing = false;
    add(bg);
}
function onCreatePost(){
    playHUD.ratingPrefix = 'pixelUI/';
    playHUD.ratingSuffix = '-pixel';
}

// function onBeatHit(){
//     bgGirls.dance();
// }