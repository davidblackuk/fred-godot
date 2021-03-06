# Fireman Fred, the Godot years

Im recreating an old 8 bit game that I wrote for the Spectrum, using the Godot game engine. This is just a bit of fun and I'm having a blast doing it. 

I'm also Gobsmacked at just how simple and powerful Godot is.This repo is open so if any of the effects or techniques are of use to you, you can lift 'em wholesale.

There are a number of differences from the original:

The game counts the number of lives lost, not those left. The carry over from the arcade days of limiting lives to increase coins was still strong in the 80s. No need for that today.

Icon sizing and platfoms are faithful to the original pallettes and devices but i do allow myself a one pizel black mask for sprites. Also no attribute clashes





# TODO

Should we move this into a project board on Git hub?

+ Change game resolution to match charactor width height of spectrum? (currently the hight is too short)
+ ~~Ladders~~
  + ~~Fred can pause on climbing ladders~~
  + ~~Fred can exit / fall off ladders by walking~~
  + ~~We want to be able to tint ladders~~
+ Fred death
  + Enemy collisions
  + Falling too far
  + Behaviour
    + restart level?
    +   All victims reset?
    + reset Fred
+ Rescue victims
    + Should We use the same mechanic as the original game and make fred visit the ambulance on each rescue?
        + Or victims animate out
        + or victims animate them selves to the ambulance
    + Monitor count of victim rescues
        + Increment score (Are we even going to show it unless there are other things to get points from)
    + Open the door and send off the ambulance on level complete
+ Conveyers
+ Sliding platforns
+ Lifts
+ Crumbling platforms
+ Slopes (with jump through?)
+ Ropes
+ ~~Mask fred~~
+ ~~Door tint~~
+ Export to HTML and host on overtaken by events
+ Improve graphics as levels go on 
  + ie spectrum -> cpc -> amiga pallette
+ Multi page levels
  + Camera move on level entry
  + How to handle fred position in multilevel
    + do we restart the entire thing? (Eek for jet set style)
