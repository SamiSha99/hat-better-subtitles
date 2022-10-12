# Better Subtitles (AHiT Modding)
Improved subtitles made for A Hat in time modding purposes, inspired by Nyakuza Metro DLC subtitles, which uses a simple "OpenHUD" call with complicated nodes used to simulate subtitles, this one instead, simplify the whole process into one node only, with multiple inputs to allow for more unique functionality for custom subtitles.

![](https://i.imgur.com/6d02D3T.png)

# Installation:

1) Download the script files.
2) Put them into the Classes folder in your mod.
3) Go to the mod manager and click "Compile Scripts"
4) And go to the editor and start using them!

# Documentation:

## `SS_SeqAct_SubtitleManager`
Runs subtitles with the specified properties.

![](https://i.imgur.com/f8Fv3ji.png)

### Properties:
`LifeTime` - Duration of the subtitles, will run OnExpired when reaching zero. Note: Setting this to 0 will be infinite till "Skip or Stop" are called.

`FadeIn` - Time to reach fade in, occurs at the beginning of the life time.

`FadeOut` - Time to fade out, occurs at the end of the life time.

`Text` - Text to render on subtitles

`Position` - BETWEEN 0 AND 1! This value is transformed to the screen current resolution of Max Height/Width! X/Y = 0 is left/top, 0.5f is center, X/Y = 1.0f is right/bottom.

`Scale` - Size of the text.

`Font` - Custom font? Set it here! Keeping this None will use Cursed Casual aka default game font.

`Alignment` - Adjust the text based on the anchoring point from Position, like starting left/right or center and so on.

`TextColor` - Color of the text

`BorderTextColor` - Color of the border

`BorderWidth` - Width of the border

`BorderQuality` - The quality of the border, the less this is the more pixelated it gets, good to increase if the text is too big (at the cost of performance)!

`Shadow` - Adds a shadow to the text

`ShadowAlpha` - How much opacity the shadow has? 0 values is pretty much Shadow set to false.

`VerticalSize` - Stretches the text veritcally

## `SS_SeqAct_SubtitleManager_Lyrics`
Child of `SS_SeqAct_SubtitleManager`, plays subtitles in an animated "speak" format in which each word gets highlighted as said character is speaking that word currently, using keyframes specified in the kesmit node.

![](https://i.imgur.com/hJVsoH8.png)

### Properties

`LyricColor` - Switch each word to this color when reached.

`LyricColorBorder` - Like the above, but the border.

`Keyframes` - Array, Should equal the amount of words in `Text`! Each keyframe should be larger than the other.

## `SS_SeqAct_ShutdownSubtitles`

Instead of calling Stop/Skip on all kismet nodes of the subtitles, this node can be called once and should shutdown all kismet nodes in the process.
