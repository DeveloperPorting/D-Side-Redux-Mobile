import flixel.text.FlxText;
// import funkin.RatingInfo;
import funkin.Mods;
import funkin.states.StoryMenuState;
import funkin.states.FreeplayState;
import funkin.utils.MathUtil;
import funkin.backend.Difficulty;
import funkin.scripting.PluginsManager;
import funkin.api.DiscordClient;

var kadeEngineWatermark:FlxText;
var scoreText:FlxText;
var originalX:Float;
var diff = ['easy', 'normal', 'hard'];

var exceptions = [
	'green eggs',
	'ham',
	'feaster',
	'sensei',
	'roses',
	'thorns',
	'pricked',
	'too-slow',
	'endless',
	'cycles',
	'god feast',
	'improbable outset',
	'foolhardy',
	'ugh'
];

function onLoad()
{
	automatedDiscord = false;
	if(ClientPrefs.downScroll)
		ClientPrefs.comboOffset = [-407, 214, -280, 281];
	else 
		ClientPrefs.comboOffset = [-407, -294, -280, -234];
}

function onCreatePost() {
	defaultRPC();
	if (Mods.currentModDirectory != 'old-dsides')
		return;

	songEndCallback = songEnd;

	if (!oldOrNew()) {
		modManager.setValue("transformX", -50);

		for (m in [playHUD.timeBar, playHUD.timeTxt, playHUD.scoreTxt])
			m.visible = false;

		playHUD.healthBar.setColors(FlxColor.fromRGB(255, 0, 0), FlxColor.fromRGB(0, 255, 0));

		kadeEngineWatermark = new FlxText(4, playHUD.healthBar.y
			+ 60, 0,
			PlayState.SONG.song
			+ " - "
			+ Difficulty.getCurrentDifficultyString().toLowerCase()
			+ " | NMV WHATEVER", 16);
		kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		kadeEngineWatermark.cameras = [camHUD];
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);

		if (ClientPrefs.downScroll)
			kadeEngineWatermark.y = FlxG.height * 0.9 + 45;

		scoreText = new FlxText(FlxG.width / 2 - 235, playHUD.healthBar.y + 50, 0, "", 20);
		scoreText.screenCenter(FlxAxes.X);
		originalX = scoreText.x;
		scoreText.scrollFactor.set();
		scoreText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreText.cameras = [camHUD];
		add(scoreText);

		opponentStrums.playAnims = false;

		for (m in [boyfriendGroup, dadGroup]) {
			for (f in m.members) {
				f.camDisplacement = 0;
				f.ghostsEnabled = false;
			}
		}

		for (i in 0...4)
			script_SUSTAINENDOffsets[i].y += 50;
	} else {
		playHUD.timeBar.setColors(dad.healthColour, FlxColor.BLACK);
	}
}

function songEnd() {
	ClientPrefs.load();

	Mods.currentModDirectory = 'new-dsides';
	Mods.updateModList('new-dsides');
	Mods.loadTopMod();

	endSong();
}

function onEvent(eventName, value1, value2) {
	if (Mods.currentModDirectory != 'old-dsides')
		return;

	if (!oldOrNew()) {
		if (eventName == 'Change Character')
			playHUD.healthBar.setColors(FlxColor.fromRGB(255, 0, 0), FlxColor.fromRGB(0, 255, 0));
	}
}

function onUpdate(elapsed) {
	if (Mods.currentModDirectory != 'old-dsides')
		return;

	if (!oldOrNew() && scoreText != null) {
		scoreText.text = calcR(songScore, songMisses);
		scoreText.screenCenter(FlxAxes.X);
	}
}

function onSpawnNotePost(note) {
	if (!oldOrNew())
		note.noteSplashDisabled = true;
}

function weirdLetterRating(misses, bads, shits, goods) {
	var ranking:String = '';

	// copy & pasted RIGHT from kade engine. do not kill me for this bro

	if (misses == 0 && bads == 0 && shits == 0 && goods == 0) // Marvelous (SICK) Full Combo
		ranking = "(MFC)";
	else if (misses == 0 && bads == 0 && shits == 0 && goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
		ranking = "(GFC)";
	else if (misses == 0) // Regular FC
		ranking = "(FC)";
	else if (misses < 10) // Single Digit Combo Breaks
		ranking = "(SDCB)";
	else
		ranking = "(Clear)";

	ranking += ' ';

	if (songScore == 0)
		ranking = '';

	return ranking;
}

function otherLetterRating(acc) {
	// this code is also terrible. what is with kade engine
	var rating = 'N/A';

	if (acc >= 99.9935)
		rating = 'AAAAA'
	else if (acc >= 99.97)
		rating = 'AAAA';
	else if (acc >= 99.7)
		rating = 'AAA';
	else if (acc >= 93)
		rating = 'AA';
	else if (acc >= 85)
		rating = 'A';
	else if (acc >= 70)
		rating = 'B';
	else if (acc >= 60)
		rating = 'C';
	else if (acc < 60 && acc > 0)
		rating = 'D';
	else if (acc == 0)
		rating = 'N/A';

	return rating;
}

var rating = 'N/A';

function calcR(score, misses) {
	var acc = MathUtil.floorDecimal(ratingPercent * 100, 2);
	var rating = otherLetterRating(acc);

	return "Score: " + score + " | Combo Breaks: " + misses + " | Accuracy: " + acc + " %" + " | " + weirdLetterRating(songMisses, bads, shits, goods) + rating;
}

function oldOrNew() {
	for (i in exceptions) {
		if (PlayState.SONG.song.toLowerCase() == i)
			return true;
	}

	return false;
}

function onGameOverCancel() {
	Mods.currentModDirectory = 'new-dsides';
	Mods.updateModList('new-dsides');
	Mods.loadTopMod();

	FlxG.sound.music.stop();
	PlayState.deathCounter = 0;
	PlayState.seenCutscene = false;

	FlxG.switchState(() -> PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());

	FunkinSound.playMusic(Paths.music('freakyMenu'));
}

function onGameOver(){
	deathRPC();
}

function defaultRPC()
{
	DiscordClient.changePresence(PlayState.SONG.song + ' [' + Difficulty.getCurrentDifficultyString().toUpperCase() + ']', 'OG D-Sides', null, true, songLength, 'og_cover');	
}

function deathRPC()
{
	DiscordClient.changePresence('GAME OVER', '[ ' + PlayState.SONG.song + ' (' + Difficulty.getCurrentDifficultyString().toUpperCase() + ') ]', null, true, songLength, 'og_cover');	
}

function onPause()
{
	DiscordClient.changePresence('PAUSED', PlayState.SONG.song, null, true, songLength, 'og_cover');
}

function onResume()
{
	defaultRPC();
}

function onDestroy()
{
	Conductor.bpm = 102;
	DiscordClient.changePresence('In the menus', 'Just finished playing ' + PlayState.SONG.song + ' (OG)!', null, true, 0, 'game');
}