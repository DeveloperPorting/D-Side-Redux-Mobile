-- Lua stuff
finishedGameover = false;
startedPlaying = false;

function onCreate()
	-- background shit
	makeLuaSprite('tankSky', 'W7/planemanbg', -400, -100);
	setScrollFactor('tankSky', 0.2, 0.2);
                  scaleObject('tankSky', 0.8, 0.8);

	makeLuaSprite('tankBuildings', 'W7/planeman_floor', -100, -60);
	setScrollFactor('tankBuildings', 0.68, 0.68);

	makeAnimatedLuaSprite('tankWatchtower3', 'W7/b3dad',1500, 450);
	addAnimationByPrefix('tankWatchtower3', 'idle', 'b3dadinbgidle', 24,false);
	setScrollFactor('tankWatchtower3', 0.68, 0.68);

	makeLuaSprite('tankRuins', 'W7/planeman_tent', -50, -140);
	setScrollFactor('tankRuins', 0.7, 0.7);
	scaleObject('tankRuins', 1,1);

	makeAnimatedLuaSprite('tankWatchtower', 'W7/BunnyTankGirl', -210, 520);
	addAnimationByPrefix('tankWatchtower', 'idle', 'PlaneBunnyTankGirl', 24,false);
	setScrollFactor('tankWatchtower', 0.8, 0.8);

	makeAnimatedLuaSprite('tankWatchtower2', 'W7/Sniper',1500, 570);
	addAnimationByPrefix('tankWatchtower2', 'idle', 'SniperIdle', 24,false);
	setScrollFactor('tankWatchtower2', 0.7, 0.7);



	addLuaSprite('tankSky', false);
	addLuaSprite('tankBuildings', false);
               addLuaSprite('tankWatchtower3', false);
	addLuaSprite('tankRuins', false);
	addLuaSprite('tankWatchtower', false);
                  addLuaSprite('tankWatchtower2', false);
	addLuaSprite('tankGround', false);


	-- foreground shit
	makeAnimatedLuaSprite('tank0', 'W7/PlaneAud1', -60, 1100);
	addAnimationByPrefix('tank0', 'idle', 'PlaneAud1', 24, false);
	setScrollFactor('tank0', 1.7, 1.5);
	
	makeAnimatedLuaSprite('tank2', 'W7/PlaneAud2', 650, 1400);
	addAnimationByPrefix('tank2', 'idle', 'PlaneAud2', 24, false);
	setScrollFactor('tank2', 1.5, 1.5);

	if not lowQuality then
		
		makeAnimatedLuaSprite('tank3', 'W7/PlaneAud3', 1750, 1700);
		addAnimationByPrefix('tank3', 'idle', 'PlanemanAud3', 24, false);
		setScrollFactor('tank3', 2.0, 2.0);
	end
	
	makeAnimatedLuaSprite('tank5', 'W7/PlaneAud4', 2920, 1900);
	addAnimationByPrefix('tank5', 'idle', 'PlaneAud4', 24, false);
	setScrollFactor('tank5', 2.5, 2.5);
	


	addLuaSprite('tank0', true);
	if not lowQuality then
		addLuaSprite('tank1', true);
	end
	addLuaSprite('tank2', true);
	addLuaSprite('tank5', true);
	if not lowQuality then
		addLuaSprite('tank3', true);
	end

end



-- Gameplay/Song interactions
function onBeatHit()
                                  objectPlayAnimation('tankWatchtower', 'idle', true);
                                 objectPlayAnimation('tankWatchtower2', 'idle', true);
                                 objectPlayAnimation('tankWatchtower3', 'idle', true);
		objectPlayAnimation('tank0', 'idle', true);
		objectPlayAnimation('tank2', 'idle', true);
		objectPlayAnimation('tank5', 'idle', true);
                                   objectPlayAnimation('tank3', 'idle', true);

end
