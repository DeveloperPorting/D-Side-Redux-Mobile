/**
 * [Completion.hx]
 * Used to handle song-completion's contributions to your overall update completion.
 */

import funkin.scripting.PluginsManager;

var song;
var needsCompletion:Bool = false;

// used for setting specific song's percentages, since some songs have different values
var percentMap = new StringMap();
for(i in ['tutorial', 'bopeebo', 'fresh', 'dad-battle', 'spookeez', 'south', 'ghastly', 'monster', 'pico', 'philly-nice', 'blammed', 'darnell', 'improbable-outset', 'boom-bash', 'foolhardy', 'dusk', 'accelerant', 'and', 'dguy', 'lore', 'performance', 'try-harder', 'endless', 'milk'])
    percentMap.set(i, 3);
percentMap.set('execution', 3.999);
percentMap.set('soretro', 0.001);

var exclusions = [
    'bobos-chicken'
];

/**
 * [onLoad()]
 * Runs on loading of the script.
 * 
 * In this script:
 * Used for checking if the current song has been completed or not
 * Also fixes the custom save-data if it happens to be null.
*/
function onLoad()
{
	PluginsManager.callPluginFunc('Utils', 'saveFix', []);

    song = Paths.sanitize(PlayState.SONG.song);
    needsCompletion = (FlxG.save.data.completedSongs.indexOf(song) == -1);

}

/**
 * [onEndSong()]
 * Runs when a playable song is completed.
 
 * In this script:
 * Checks if your song hasn't been completed yet, it adds it to the list of completed songs & adds completion percentage.
*/
function onEndSong()
{
    if(needsCompletion){
        var perc = percentMap.get(song);
        if(perc == null) perc = 3;
        var exc = false;

        for(i in exclusions)
            exc = i == song;
        
        // Weird bug where if the song doesnt exist, it will append the word "null" to the completionPercent variable
        if(!exc){
            if(StringTools.contains(FlxG.save.data.completionPercent, 'null')){
                FlxG.save.data.completionPercent = StringTools.replace(FlxG.save.data.completionPercent, 'null', '');
                FlxG.save.data.completionPercent = Std.parseFloat(FlxG.save.data.completionPercent);
            }
            FlxG.save.data.completionPercent += perc;            
        }

        FlxG.save.data.completedSongs.push(song);

        FlxG.save.flush();
    }

    return ScriptConstants.CONTINUE_FUNC;
}