class SS_SeqAct_SubtitleManager extends SequenceAction;

var(Time) float LifeTime; // Duration of the subtitles, will run OnExpired when reaching zero. Note: Setting this to 0 will be infinite till "Skip or Stop" are called.
var(Time) float FadeIn; // Time to reach fade in, occurs at the beginning of the life time.
var(Time) float FadeOut; // Time to fade out, occurs at the end of the life time.
var(MainSettings) String Text; // Text to render on subtitles
var(MainSettings) Vector2D Position; // BETWEEN 0 AND 1! This value is transformed to the screen current resolution of Max Height/Width! tl;dr X/Y = 0 is left/top, 0.5f is center, X/Y = 1.0f is right/bottom.
var(MainSettings) float Scale; // Size of the text.
var(MainSettings) Font Font; // Custom font? Set it here! Keeping this None will use Cursed Casual aka default game font.
var(MainSettings) TextAlign Alignment; // Adjust the text based on the anchoring point from Position, like starting left/right or center and so on.
var(MainSettings) Color TextColor; // Color of the text
var(BorderSettings) Color BorderTextColor; // Color of the border
var(BorderSettings) float BorderWidth; // Width of the border
var(BorderSettings) float BorderQuality; // The quality of the border, the less this is the more pixelated it gets, good to increase if the text is too big!
var(OtherSettings) bool Shadow; // Adds a shadow to the text
var(OtherSettings) float ShadowAlpha; // How much opacity the shadow has? 0 values is pretty much Shadow set to false.
var(OtherSettings) float VerticalSize; // Stretches the text veritcally

var SS_HUDElement_BetterSubtitles SubtitlesHUD;

final function Print(coerce string msg)
{
    local WorldInfo wi;

    wi = class'WorldInfo'.static.GetWorldInfo();
    if (wi == None) return;

    msg = "[" $ Class $ "]" @ msg;

    if(wi.GetALocalPlayerController() != None)
        wi.GetALocalPlayerController().TeamMessage(None, msg, 'Event', 6);
    else
        wi.Game.Broadcast(wi, msg);
}

event Activated()
{
	local Hat_PlayerController pc;
    local SS_HUDElement_BetterSubtitles bs;
    local Object o;

    if(Text ~= "") return;

    o = Targets[0];
    
    pc = Hat_PlayerController(GetController(Actor(o)));
    bs = SS_HUDElement_BetterSubtitles(OpenHUD(pc.MyHUD, Text));

    if(pc == None || bs == None) return;
    if(InputLinks[0].bHasImpulse)
    {
        bs.Position = Position;
        bs.Scale = Scale;
        bs.Font = Font;
        bs.Alignment = Alignment;
        bs.TextColor = TextColor;
        bs.BorderColor = BorderTextColor;
        bs.BorderWidth = BorderWidth;
        bs.BorderQuality = BorderQuality;
        bs.Shadow = Shadow;
        bs.ShadowAlpha = ShadowAlpha;
        bs.VerticalSize = VerticalSize;
        bs.FadeSpeed = FadeIn;
        bs.KismetSubtitle = self;
        if(Lifetime > 0) bs.LifeTime = FMax(LifeTime - FadeOut, 0.01f);

        SubtitlesHUD = bs;
        ForceActivateOutput(0);
    }
    else if(InputLinks[1].bHasImpulse)
    {
        PrepareToDestroy();
    }
    else if(InputLinks[2].bHasImpulse)
    {
        if(SubtitlesHUD != None)
            SubtitlesHUD.CloseHUD(pc.MyHUD, SubtitlesHUD.Class);
        ForceActivateOutput(2);
    }
}

function Hat_HUDElement OpenHUD(HUD myHUD, optional coerce string Command)
{
    local Hat_HUD h;
    h = Hat_HUD(myHUD);
    return h.OpenHUD(class'SS_HUDElement_BetterSubtitles', Command);
}

function OnExpiring()
{
    ForceActivateOutput(1);
}

function PrepareToDestroy()
{
    SubtitlesHUD.LifeTime = 0; // If it was running and cancelled, early, set this back to 0 to avoid jank garbage
    SubtitlesHUD.bFadeOut = true;
    SubtitlesHUD.bShuttingDown = true;
    SubtitlesHUD.FadeSpeed = FadeOut;
    SubtitlesHUD = None;
}

event CheckForErrors(out Array<string> ErrorMessages)
{
	if (Text ~= "") ErrorMessages.AddItem("No text was inputted, add some text!");
	if (Scale <= 0) ErrorMessages.AddItem("Scale set to 0 or less won't be able to render!");
	Super.CheckForErrors(ErrorMessages);
}

defaultproperties
{
    ObjName="Play Subtitles";
	ObjCategory="HUD";
    
    InputLinks(0)=(LinkDesc="In");
    InputLinks(1)=(LinkDesc="Skip");
    InputLinks(2)=(LinkDesc="Stop");
    OutputLinks(0)=(LinkDesc="Out");
    OutputLinks(1)=(LinkDesc="Expired");
    OutputLinks(2)=(LinkDesc="Stopped");

    bCallHandler = false;

    Font = None;
    Position = (X = 0.5f, Y = 0.8f);
    Scale = 1.0f;
    Shadow = false;
    ShadowAlpha = 0.5f;
    Alignment = TextAlign_Center;
    VerticalSize = -1;
    BorderWidth = 4;
    BorderQuality = 1;
    TextColor = (R = 255, G = 255, B = 255, A = 255);

    LifeTime = 10;
    

    bAutoActivateOutputLinks = false;
}