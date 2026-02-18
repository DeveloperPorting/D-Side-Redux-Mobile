var audienceDark:BGSprite;

function onLoad() {
    var bg:BGSprite = new BGSprite('backgrounds/week1/stagebackdark', -671,-170, 0.9, 0.9);
    add(bg);

    var stageFront:BGSprite = new BGSprite('backgrounds/week1/stagefrontDark', -579, 681, 0.9, 0.9);
    add(stageFront);
    
    audienceDark = new BGSprite('backgrounds/week1/Week1Audience',  -451, 581, 0.9, 0.9, ['AudienceBobbing']);
    audienceDark.zIndex = 999;
    add(audienceDark);
}

function onBeatHit(){
    if(curBeat % 2 == 0)
        audienceDark.dance(true);
}