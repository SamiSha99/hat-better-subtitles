Class SS_SeqAct_SubtitleManager_Lyrics extends SS_SeqAct_SubtitleManager;

var(Lyrics) Color LyricColor; // Switch each word to this color when reached.
var(Lyrics) Color LyricColorBorder; // Like the above, but the border.
var(Lyrics) Array<float> Keyframes; // Should equal the amount of words! EACH NEXT VALUE SHOULD BE LARGER THAN THE PREVIOUS!!! DO NOT PASS 0.0f!

event Activated()
{
    local float k;

    if(Keyframes.Length != 0)
    {
        Text $= "|";
        foreach Keyframes(k) Text $= k $ ",";
    }
    Super.Activated();

    if(SS_HUDElement_BetterSubtitles_Lyrics(SubtitlesHUD) != None)
    {
        SS_HUDElement_BetterSubtitles_Lyrics(SubtitlesHUD).PostTextColor = LyricColor;
        SS_HUDElement_BetterSubtitles_Lyrics(SubtitlesHUD).PostBorderColor = LyricColorBorder;
    }
}

function Hat_HUDElement OpenHUD(HUD myHUD, optional coerce string Command)
{
    local Hat_HUD h;
    h = Hat_HUD(myHUD);
    return h.OpenHUD(class'SS_HUDElement_BetterSubtitles_Lyrics', Command);
}

event CheckForErrors(out Array<string> ErrorMessages)
{
	if (Keyframes.Length == 0) ErrorMessages.AddItem("Warning, no keyframes!");
	Super.CheckForErrors(ErrorMessages);
}

defaultproperties
{
    ObjName="Play Lyrics";
	ObjCategory="HUD";
    bCallHandler = false;

    LyricColor = (R = 255, G = 255, B = 255, A = 255);
    Alignment = TextAlign_Left;
    bAutoActivateOutputLinks = false;
}