Class SS_SeqAct_ShutdownSubtitles extends SequenceAction;

event Activated()
{
	local Hat_PlayerController pc;
    local SS_HUDElement_BetterSubtitles bs;
    local Object o;

    o = Targets[0];
    
    pc = Hat_PlayerController(GetController(Actor(o)));
    bs = SS_HUDElement_BetterSubtitles(GetHUD(pc.MyHUD));

    if(pc == None || bs == None) return;
    if(InputLinks[0].bHasImpulse)
    {
        bs.KismetSubtitle = None;
        bs.CloseHUD(pc.MyHUD, bs.Class);
        ForceActivateOutput(0);
    }
}

function Hat_HUDElement GetHUD(HUD myHUD)
{
    local Hat_HUD h;
    h = Hat_HUD(myHUD);
    return h.GetHUD(class'SS_HUDElement_BetterSubtitles', true);
}

defaultproperties
{
    ObjName="Shutdown All Subtitles";
	ObjCategory="HUD";
    
    InputLinks(0)=(LinkDesc="In");
    OutputLinks(0)=(LinkDesc="Out");

    bCallHandler = false;
    bAutoActivateOutputLinks = false;
}
