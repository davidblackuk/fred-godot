# Fireman Fred, the Godot years

Im recreating an old 8 bit game that I wrote for the Spectrum, using the Godot game engine. This is just a bit of fun and I'm having a blast doing it. 

I'm also Gobsmacked at just how simple and powerful Godot is.This repo is open so if any of the effects or techniques are of use to you, you can lift 'em wholesale.

There are a number of differences from the original:

The game counts the number of lives lost, not those left. The carry over from the arcade days of limiting lives to increase coins was still strong in the 80s. No need for that today.

Icon sizing and platfoms are faithful to the original pallettes and devices but i do allow myself a one pizel black mask for sprites. Also no attribute clashes


Release 2:
  + Score in hud animates up to new value
  + Added second level (which will become level 1)


Release 1:
  + Basic game in place
  + Platforms
  + ladders
  + enemies
  + victims
  + simple sound
  + game mechanics
    + score in hud (non animated)
    + Death with animation and color change
    + level complete opens door to next room

# TODO

Should we move this into a project board on Git hub?

+ Change game resolution to match charactor width height of spectrum? (currently the hight is too short)
+ Ladders
  + fall over ladder latches to it (musnt stop getting off!)

+ Fred death
  + ~~Enemy collisions~~
  + One shot or health bar?
  + Falling too far
  + Behaviour
    + restart level?
    +   All victims reset?
    + reset Fred
    + ~~Death animation~~
    + Fade out scene?

+ collectable coins / tools
    + less points than a victim
    
+ Rescue victims
    + Should We use the same mechanic as the original game and make fred visit the ambulance on each rescue?
        + Or victims animate out
        + or victims animate them selves to the ambulance
    + Monitor count of victim rescues
        + Increment score (Are we even going to show it unless there are other things to get points from)
    + Open the door and send off the ambulance on level complete
    + Fade out victim on rescue
    + play sound on rescue
    + particle effect on rescue
+ Conveyers
+ Sliding platforns 
+ Lifts
+ Crumbling platforms
+ Slopes (with jump through?)
+ Ropes

+ Improve graphics as levels go on 
  + ie spectrum -> cpc -> amiga pallette
+ Multi page levels
  + Camera move on level entry
  + How to handle fred position in multilevel
    + do we restart the entire thing? (Eek for jet set style)
+ persist progress
+ have a menu screen

+ Auto wire up
  + need to consider large levels with thousands of ladders and enemies
  + Level.gd searches for all ladders and connects them to the player
    + Get child node Victims
    + process all child nodes tyha are ladders
    + Saves manual attachment.
    + we already count victims
  + Level.gd searches all children and registers enemies



# done

+ Fred death
  + ~~Enemy collisions~~
  + Behaviour
  + ~~Death animation~~

+ ~~Ladders~~
  + ~~Fred can pause on climbing ladders~~
  + ~~Fred can exit / fall off ladders by walking~~
  + ~~We want to be able to tint ladders~~


+ ~~Sky box!~~
+ ~~Palette~~
+ ~~Mask fred~~
+ ~~Door tint~~
+ ~~Export to HTML and host on overtaken by events~~






# new level cheat sheet
make sure level uses LevelBase.gd as it's scripts 



