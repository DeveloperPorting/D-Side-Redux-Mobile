import funkin.objects.stageobjects.BackgroundGirls;
import funkin.utils.MathUtil;

import openfl.filters.ShaderFilter;

function onLoad() {
    var bgSky:BGSprite = new BGSprite('backgrounds/week6/weebSky', -440, -300, 0.1, 0.1);
    bgSky.setGraphicSize(Std.int(bgSky.width * 2));
    add(bgSky);
    bgSky.antialiasing = false;

    var repositionShit = -200;

    var bgSchool:BGSprite = new BGSprite('backgrounds/week6/weebSchool', repositionShit, 0, 0.6, 0.90);
    add(bgSchool);
    bgSchool.antialiasing = false;

    var temple:BGSprite = new BGSprite('backgrounds/week6/weebTreesBack', 1400, 810, 0.9, 0.9);
    temple.setGraphicSize(Std.int(temple.width * 4));
    add(temple);

    bgGirls = new BackgroundGirls(-300, 400);
    bgGirls.frames = Paths.getSparrowAtlas('backgrounds/week6/bgFreaks');
    bgGirls.scrollFactor.set(0.9, 0.9);
    bgGirls.setGraphicSize(Std.int(bgGirls.width * 6));
    bgGirls.updateHitbox();
    if(PlayState.SONG.song.toLowerCase() == 'thorns'){
        bgGirls.animation.addByIndices('danceLeft', 'BG fangirls dissuaded', MathUtil.numberArray(0, 14), "", 24, false);
        bgGirls.animation.addByIndices('danceRight', 'BG fangirls dissuaded', MathUtil.numberArray(15, 30), "", 24, false);
    }
    else{
        bgGirls.animation.addByIndices('danceLeft', 'BG Girls Group', MathUtil.numberArray(0, 14), "", 24, false);
        bgGirls.animation.addByIndices('danceRight', 'BG Girls Group', MathUtil.numberArray(15, 30), "", 24, false);
    }
    bgGirls.antialiasing = false;
    bgGirls.dance();
    add(bgGirls);

    var bgStreet:BGSprite = new BGSprite('backgrounds/week6/weebStreet', repositionShit, 0, 0.95, 0.95);
    bgSky.setGraphicSize(Std.int(bgSky.width * 4));
    add(bgStreet);
    bgStreet.antialiasing = false;

    var widShit = Std.int(bgSky.width * 6);

    var bgTrees:FlxSprite = new FlxSprite(repositionShit + 80, 0);
    bgTrees.frames = Paths.getSparrowAtlas('backgrounds/week6/weebTrees');
    bgTrees.animation.addByPrefix('treeLoop', "trees", 24);
    bgTrees.animation.play('treeLoop');
    bgTrees.scrollFactor.set(0.85, 0.85);
    add(bgTrees);
    bgTrees.antialiasing = false;

    var treeLeaves:BGSprite = new BGSprite('backgrounds/week6/petals', repositionShit, -40, 0.85, 0.85, ['PETALS ALL'], true);
    treeLeaves.setGraphicSize(widShit);
    treeLeaves.updateHitbox();
    add(treeLeaves);
    treeLeaves.antialiasing = false;

    bgSky.setGraphicSize(widShit);
    bgSchool.setGraphicSize(widShit);
    bgStreet.setGraphicSize(widShit);
    bgTrees.setGraphicSize(Std.int(widShit * 0.9));

    bgSky.updateHitbox();
    bgSchool.updateHitbox();
    bgStreet.updateHitbox();
    bgTrees.updateHitbox();
}

var vcr = newShader('vrcdistortionshader');

function onCreatePost(){
    playHUD.ratingPrefix = 'pixelUI/';
    playHUD.ratingSuffix = '-pixel';

    // vcr.setFloat('iTime', 0);
    // vcr.setBool('vignetteOn', true);
    // vcr.setBool('perspectiveOn', true);
    // vcr.setBool('distortionOn', false);
    // vcr.setFloat('glitchModifier', 0.1);
    // vcr.setBool('vignetteMoving', false);
    // // vcr.setFloatArray('iResolution', [FlxG.width, FlxG.height]);
    // // vcr.iTime.value = [0];
    // // vcr.vignetteOn.value = [true];
    // // vcr.perspectiveOn.value = [true];
    // // vcr.distortionOn.value = [false];
    // // vcr.glitchModifier.value = [0.1];
    // // vcr.vignetteMoving.value = [false];
    // // vcr.iResolution.value = [FlxG.width, FlxG.height];
    // // vcr.noiseTex.input = Paths.image("noise2").bitmap;

    // camGame.filters = [new ShaderFilter(vcr)];
    // FlxG.game.setFilters([new ShaderFilter(vcr)]);
}

// function onUpdate(elapsed){
//     vcr.setFloat('iTime', Conductor.songPosition / 1000); 
// }

function onBeatHit(){
    bgGirls.dance();
}

// function onDestroy(){
//     FlxG.game.setFilters([]);
// }