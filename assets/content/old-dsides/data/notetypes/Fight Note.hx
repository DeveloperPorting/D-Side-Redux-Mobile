function setupNote(note){
    note.reloadNote('FIGHT');
    note.noAnimation = true;
}

var anims = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
function goodNoteHit(note)
{
    if(note.noteType == 'Fight Note')
    {
        health += 0.125;
        boyfriend.playAnim(PlayState.noteSkin.data.singAnimations[note.noteData] + '-F', true);
        boyfriend.holdTimer = 0;
    }
}

function opponentNoteHit(note)
{
    if(note.noteType == 'Fight Note')
    {
        health -= 0.1;
        dad.playAnim(PlayState.noteSkin.data.singAnimations[note.noteData] + '-F', true);
        dad.holdTimer = 0;

    }
}