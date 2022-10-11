Class SS_HUDElement_BetterSubtitles_Lyrics extends SS_HUDElement_BetterSubtitles;

struct HUDSubtitle
{
    var String Word;
    var float LyricReachTime;
    var bool ReachedTimeLyric;

    structdefaultproperties
    {
        LyricReachTime = -1;
    }
};

var Color PostTextColor, PostBorderColor;
var Array<float> Keyframes; // points to switch color
var Array<String> Words;

const DEBUG_TEXT_DUMMY_TEST = "Hello! This is a test!|0.5f,2.5f,3.5f,4.0f,6.9f";
const DEBUGGING = false;

function OnOpenHUD(HUD H, optional String command)
{
    local Array<String> s;
    local String s1;
    local Array<float> f;

    s = SplitString(DEBUGGING ? DEBUG_TEXT_DUMMY_TEST : command, "|", false);
    Text = s[0];
    s = SplitString(s[1], ",", false);
    foreach s(s1) 
    {   
        if(float(s1) <= 0.0f) continue;
        f.AddItem(float(s1));
    }
    f.Sort(SortKeyframes);
    Words = SplitString(Text, " ", false);
    Keyframes = f;

}

function bool Render(HUD H)
{
    local float x, y, s, NextWordPosX, XLenTotal, XLen, YLen, SpaceLength;
    local int i;
    local Color TColor, BColor;
    local bool SpokeWord;
	if(!Super(Hat_HUDElement).Render(H)) return false;
    
    H.Canvas.Font = (Font != None ? Font : Class'Hat_FontInfo'.static.GetDefaultFont("abcdefghijkmnlopqrstuvwxyzABCDEFGHIJKMNLOPQRSTUVWXYZ"));

    x = H.Canvas.ClipX * Position.X;
    y = H.Canvas.ClipY * Position.Y;
    s = FMin(H.Canvas.ClipY,H.Canvas.ClipX)/1080.0f * Scale;

    H.Canvas.TextSize(Text, XLenTotal, YLen, s, s);
    H.Canvas.TextSize(" ", SpaceLength, YLen, s, s);
    NextWordPosX = 0.0f;

    for(i = 0; i < Words.Length; i++)
    {
        SpokeWord = HasSpokenWord(i);
        
        if(SpokeWord)
        {
            TColor = PostTextColor;
            BColor = PostBorderColor;
        }
        else
        {
            TColor = TextColor;
            BColor = BorderColor;
        }

        H.Canvas.SetDrawColor(TColor.R, TColor.G, TColor.B, TColor.A * Opacity);
        H.Canvas.TextSize(Words[i], XLen, YLen, s, s);
        DrawBorderedText(H.Canvas, Words[i], x - XLenTotal/2 + NextWordPosX, y, s, Shadow, Alignment, ShadowAlpha, BorderWidth, BColor, VerticalSize, BorderQuality);
        NextWordPosX = NextWordPosX + XLen + SpaceLength;
    }

    return true;
}

function bool HasSpokenWord(int index)
{
    if(Keyframes.Length == 0 || index + 1 > Keyframes.Length) return false;
    return CurrentDuration >= Keyframes[index];
}


function int SortKeyframes(float A, float B)
{
	return (A > B) ? -1 : 0;
}

function Print(const string msg)
{
    local WorldInfo wi;

	wi = class'WorldInfo'.static.GetWorldInfo();
    if (wi != None)
    {
        if (wi.GetALocalPlayerController() != None)
            wi.GetALocalPlayerController().TeamMessage(None, "[DEBUG" @ Class.Name $ "]" @ msg, 'Event', 6);
        else
            wi.Game.Broadcast(wi, "[DEBUG" @ Class.Name $ "]" @ msg);
    }
}

defaultproperties
{
    Alignment = TextAlign_Left;
    LifeTime = 10.0f;
    PostTextColor = (R = 255, G = 0, B = 0, A = 255);
    PostBorderColor = (R = 255, G = 255, B = 0, A = 255);
}