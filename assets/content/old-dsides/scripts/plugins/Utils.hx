import funkin.states.TitleState;
import funkin.Mods;

function onLoad()
{
    if(Mods.currentModDirectory == 'old-dsides'){
        reset();
        FlxG.switchState(()->{new TitleState();});
    }
}

function reset()
{
    Mods.currentModDirectory = 'new-dsides';
    Mods.updateModList('new-dsides');
    Mods.loadTopMod();
}