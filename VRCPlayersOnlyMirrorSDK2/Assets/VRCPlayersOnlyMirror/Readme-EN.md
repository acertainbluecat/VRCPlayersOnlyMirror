# VRCPlayersOnlyMirror v0.1.5

Tired of having to choose between admiring the scenery in a nice map or staring at your own reflection? Now you can do both at the same time!
VRCPlayersOnlyMirror is a simple mirror prefab that shows players only without any background.
This is NOT a 2D camera cut out, it is a full 3D mirror.

  - Player reflections in mirrors without any background
  - Adjustable mirror transparency
  - Simple distance fade
  - Works on both PC and Quest worlds
  - Performance cost more or less the same as a LQ mirror

# Requirements
  - VRChat SDK2 or SDK3
  - **!!! SDK3 VRCSDK3-WORLD-2022.08.29.20.48_Public or newer for v0.1.4+ !!!**

# How to

  - Import either the SDK2 or SDK3 unitypackage depending on your project
  - Example scene is provided as well as a prefab
  
# Shader Types

  - **PlayersOnlyMirror** - Regular version with transparency and distance fade
  - **PlayersOnlyMirrorCutout** - Variant with just cutout, no transparency or distance fade.

# Shader Settings

  - **Base (RBG)** - Overlays a texture onto the reflection, same behavior as the default mirror shader
  - **Hide Background** - Hides the background, requires the TransparentBackground shader acting as a fake background for the mirror for this to work
  - **Ignore Effects** - Attempts to Ignore effects like particles, lens flare. Will still show up if they are in front of your character however. 
  - **Transparency** - Adjust transparency of the mirror
  - **Transparency Mask** - Texture mask that adjusts the transparency of the mirror, goes from white for fully opauque, to fully transparent with black. Mainly used to adjust the transparency of the entire mirror in real time for SDK2 as you can't animate mirror material properties on SDK2. See Next section for more details.
  - **Distance Fade** - Distance before the mirror starts fading to zero alpha. Disabled at 0.
  - **Distance Fade Length** - The length of distance traveled needed to fade to zero alpha.
  - **Smooth Edge** - Make edge smoother and avoid transparent object will be rendered opaque.
  - **Alpha Tweak Level** - Adjust smooth edge power.

# SDK2

  - The "TransparentBackground" is required for the mirror to work properly, however if you have other mirrors in your scene that are not using VRCPlayersOnlyMirror, consider putting it on a different layer and show it on VRCPlayersOnlyMirror's layers only. Other wise it will show up in other mirrors, such as a full mirror if VRCPlayersOnlyMirror is also on. Resize as needed.
  - The camera and render texture is used to control the transparency of the mirror via a ui slider, as its not possible to animate mirror material properties on sdk2. 
  - If you have multiple mirrors and want independent transparency sliders, you will need to make separate materials, render textures and camera's for each of them

# Caveats
  
  - If you turn on Smooth Edge,
    - Depending on shader used, transparent materials on avatars may cause certain parts of your avatar to be transparent incorrectly. (UTS has this problem)
  - If you turn off Smooth Edge,
    - Most transparent materials will appear opaque in the mirror
    - Particles, additive materials etc will have black outlines
  - Transparent materials behind or in front of the mirror may overwrite or be overwritten by the mirror, adjusting the render queue can help, or as a last resort using stencils.

# Updates

#### 12th Sep 2022
  - Added Smooth Edge Toggle (Thanks to xiphia)

#### 31st Aug 2022

  - As of VRCSDK3-WORLD-2022.08.29.20.48_Public, "TransparentBackground" mask is no longer needed, as VRCMirror allows setting of custom camera clear flags
  - For SDK3 only

#### 16th May 2021

  - Switched from Toggle to ToggleUI in shaders to reduce shader keywords used

#### 6th Feb 2021

  - Added Cutout variant. This version shouldn't have issues with transparent objects behind/infront of the mirror and should be used if you don't need transparency.
  - Added Ignore Effects toggle. Tries to ignore particle effects, lens flare and certain transparent effects which are read as zero alpha from mirror reflection render texture. 