# Better Subtitles (AHiT Modding)
Improved subtitles made for A Hat in time modding purposes.

Simply add these files into the Classes folder, compile scripts and you were be able to use the kismet nodes to run these subtitles.

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
`Keyframes` - Array, Should equal the amount of words in `Text! Each keyframe should be larger than the other.
