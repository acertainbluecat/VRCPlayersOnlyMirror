# VRCPlayersOnlyMirror

Tired of having to choose between admiring the scenery in a nice map or staring at your own reflection? Now you can do both at the same time!
VRCPlayersOnlyMirror is a simple mirror prefab that shows players only without any background.
This is NOT a 2D camera cut out, it is a full 3D mirror.

  - Player reflections in mirrors without any background
  - Adjustable mirror transparency
  - Works on both PC and Quest worlds

# Downloads
  - [For SDK2 Worlds](https://github.com/acertainbluecat/VRCPlayersOnlyMirror/releases/download/v0.1/VRCPlayersOnlyMirrorSDK2.unitypackage)
  - [For SDK3 Udon Worlds](https://github.com/acertainbluecat/VRCPlayersOnlyMirror/releases/download/v0.1/VRCPlayersOnlyMirrorSDK3.unitypackage)

# Requirements
  - VRChat SDK2 or SDK3

# How to

  - Import either the SDK2 or SDK3 unitypackage depending on your project
  - Example scene is provided as well as a prefab
  - The "TransparentBackground" is required for the mirror to work properly, however if you have other mirrors in your scene that are not using VRCPlayersOnlyMirror, consider putting it on a different layer and show it on VRCPlayersOnlyMirror's layers only. Other wise it will show up in other mirrors, such as a full mirror if VRCPlayersOnlyMirror is also on. Resize as needed.
 
# SDK2

  - The camera and render texture is used to control the transparency of the mirror via a ui slider, as its not possible to animate mirror material properties on sdk2. 
  - If you have multiple mirrors and want independent transparency sliders, you will need to make separate materials, render textures and camera's for each of them

# Caveats
  
  - Most transparent materials will appear opaque in the mirror
  - Particles, additive materials etc will have black outlines

# Demo

If you'd like to see this mirror in action you can find it in one of my public maps, Winter Solace.  
https://vrchat.com/home/world/wrld_8899947f-8e19-4981-b327-a63be233706a

![demo1](https://nyanpa.su/i/MKH21bPq.jpg)
![demo2](https://nyanpa.su/i/gEzZ1bQD.jpg)

Credits appreciated but not required.

---  
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W63BGSN)