package funkin;

#if !macro
import flixel.util.FlxDestroyUtil;

import extensions.flixel.FlxCameraEx;
import extensions.flixel.FlxSoundEx;

#if mobile
import mobile.backend.StorageSystem;
#end
import funkin.backend.MusicBeatState;
import funkin.backend.MusicBeatSubstate;
import funkin.scripting.ScriptConstants;
import funkin.audio.FunkinSound;
import funkin.backend.Logger;
import funkin.utils.*;

using haxe.io.Path;
#end
