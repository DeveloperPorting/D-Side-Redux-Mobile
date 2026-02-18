function setupNote(note){
    // trace(note);
    note.reloadNote('Blammed');
    note.noAnimation = true;
}

function noteMiss(note){
    health -= 0.25;
}

var dodge_notes:Array<String> = ['Dodge left', 'Dodge down', 'Dodge up', 'Dodge right']; //make that last one a right once the thing is fixed
function goodNoteHit(note){
    if(note.noteType == 'Blammed Notes'){
        boyfriend.playAnim(dodge_notes[note.noteData], true);
        boyfriend.specialAnim = true;

        dad.playAnim('shoot', true);    
    }
}