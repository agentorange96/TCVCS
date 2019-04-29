 rem Text & Code Final Project
 rem Peter Miller & Jessica Prost
 rem Copyright 2019

 bank 1
 temp1 = temp1
 ;setup
 set tv ntsc
 set kernel DPC+
 set smartbranching on
 set optimization inlinerand
 set kernel_options collision(playfield,player1) 
 goto Setup bank2

 bank 2
 temp1 = temp1

Setup
 timer = (rand&7)
 drawscreen
 
 ;Define Constants
 ;const constant equals value
 const maxLevels = 3
 const noscore = 1
 
 ;Define Variables
 ;dim name equals letter
 dim level = a
 dim levelsWon = b
 dim levelComplete = c
 dim complete0 = d
 dim complete1 = e
 dim konami = k
 dim state = s
 dim timer = t
 ;pfclear
 ;clear variables

Main
 ;main code goes here
 gosub Draw bank2
 gosub TitleScreen bank2
 gosub StartGame bank2
 gosub EndScreen bank2 
 goto Main

 ;Subroutines
TitleScreen
 gosub SetBackground bank4
 gosub TitleScreenGraphics bank4
 gosub ClearPlayer bank4
 gosub ClearSprites bank4
 konami = 0;
TitleScreenLogic
 gosub KonamiCheck bank2
 if switchselect && konami <> 16 && konami <> 17 then return
 if konami = 21 then goto Easter
 gosub Draw bank2
 goto TitleScreenLogic

StartGame
 levelsWon = 0
 complete0 = 0
 complete1 = 0
NextLevel
 if levelsWon >= maxLevels then goto CompleteLevels
 gosub SetBackground bank4
 gosub ClearPlayer bank4
 gosub ClearSprites bank4
 levelComplete = 0
 level = timer
 if level =  0 then gosub L00Setup bank3
 if level =  1 then gosub L01Setup bank3
 if level =  2 then gosub L02Setup bank3
 if level =  3 then gosub L03Setup bank3
 if level =  4 then gosub L04Setup bank3
 if level =  5 then gosub L05Setup bank3
 if level =  6 then gosub L06Setup bank3
 if level =  7 then gosub L07Setup bank3
 if level =  8 then gosub L10Setup bank3
 if level =  9 then gosub L11Setup bank3
 if level = 10 then gosub L12Setup bank3
 if level = 11 then gosub L13Setup bank3
 if level = 12 then gosub L14Setup bank3
 if level = 13 then gosub L15Setup bank3
 if level = 14 then gosub L16Setup bank3
 if level = 15 then gosub L17Setup bank3
 gosub Draw bank2 ; Safety in case it takes a while to load a valid level
 goto NextLevel
CompleteLevels
 return
 
EndScreen
 gosub SetBackground bank4
 gosub EndScreenGraphics bank4
 gosub ClearPlayer bank4
 gosub ClearSprites bank4
EndScreenLogic
 if switchreset then return
 gosub Draw bank2
 goto EndScreenLogic

MovePlayer
 if collision(player0,playfield) then goto PlayerCollision
 x = player0x
 y = player0y
 if joy0up    then player0y = player0y - 1
 if joy0down  then player0y = player0y + 1
 if joy0right then player0x = player0x + 1
 if joy0left  then player0x = player0x - 1
 return
PlayerCollision
 player0x = x
 player0y = y
 return

Draw
 DF0FRACINC = 128
 DF1FRACINC = 128
 DF2FRACINC = 128
 DF3FRACINC = 128
 DF4FRACINC = 255
 DF6FRACINC = 255
 drawscreen
 gosub Counter bank2 ; Good time to advance counter
 return

Counter
 timer = timer + 1
 if timer > 4 then timer = 0
 return

KonamiCheck
 ; Multiple ORs are not allowed in if statements, so failing isn't completely strict
 if konami =  0 && SWCHA = %11101111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  1 ; up
 if konami =  1 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  2 ; -
 if konami =  2 && SWCHA | %00010000 <> %11111111                                                then konami =  0 ; FAILED
 if konami =  2 && SWCHA = %11101111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  3 ; up
 if konami =  3 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  4 ; -
 if konami =  4 && SWCHA | %00100000 <> %11111111                                                then konami =  0 ; FAILED
 if konami =  4 && SWCHA = %11011111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  5 ; down
 if konami =  5 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  6 ; -
 if konami =  6 && SWCHA | %00100000 <> %11111111                                                then konami =  0 ; FAILED
 if konami =  6 && SWCHA = %11011111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  7 ; down
 if konami =  7 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  8 ; - 
 if konami =  8 && SWCHA | %01000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami =  8 && SWCHA = %10111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami =  9 ; left
 if konami =  9 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 10 ; -
 if konami = 10 && SWCHA | %10000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 10 && SWCHA = %01111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 11 ; right
 if konami = 11 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 12 ; -
 if konami = 12 && SWCHA | %01000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 12 && SWCHA = %10111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 13 ; left
 if konami = 13 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 14 ; -
 if konami = 14 && SWCHA | %10000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 14 && SWCHA = %01111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 15 ; right
 if konami = 15 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 16 ; -
 if konami = 16 && SWCHA | %00000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 16 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset &&  switchselect  then konami = 17 ; select
 if konami = 17 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 18 ; -
 if konami = 18 && SWCHA | %00000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 18 && SWCHA = %11111111 && !joy0fire && !joy1fire &&  switchreset && !switchselect  then konami = 19 ; reset
 if konami = 19 && SWCHA = %11111111 && !joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 20 ; -
 if konami = 20 && SWCHA | %00000000 <> %11111111                                                then konami =  0 ; FAILED
 if konami = 20 && SWCHA = %11111111 &&  joy0fire && !joy1fire && !switchreset && !switchselect  then konami = 21 ; fire
 return 

Easter
 gosub EasterGraphics bank4
 konami = 0
Egg
 if switchselect then goto TitleScreen
 gosub Draw bank2
 goto Egg

 bank 3
 temp1 = temp1

 ;Level 00
L00Setup
 ;return ; Remove to activate level
 ;Setup
 if complete0 & %00000001 then return
 if switchbw then return
 gosub L00Graphics bank4
 gosub SetPlayer bank4
 gosub SetGem bank4
 player0x = 20
 player0y = 130
 player1x = 93
 player1y = 117
L00Loop
 ;Recurring Code
 gosub MovePlayer bank2
 gosub L00Color bank4
 if collision(player0,player1) then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L00Loop
 complete0 = complete0 | %00000001
 levelsWon = levelsWon + 1
 return

 ;Level 01
L01Setup
 ;return ; Remove to activate level
 ;Setup
 if complete0 & %00000010 then return
 gosub L01Graphics bank4
 gosub SetPlayer bank4
 gosub SetGem bank4
 player0x = 20
 player0y = 130
 player1x = 93
 player1y = 140
L01Loop
 ;Recurring Code
 gosub MovePlayer bank2
 if collision(player0,player1) then levelComplete = 1
 if switchreset then player0x = 20
 if switchreset then player0y = 130
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L01Loop
 complete0 = complete0 | %00000010
 levelsWon = levelsWon + 1
 return

 ;Level 02
L02Setup
 ;return ; Remove to activate level
 ;Setup
 if complete0 & %00000100 then return
 gosub L02Graphics bank4
 player0x = 20
 player0y = 130
 state = 0
L02Loop
 ;Recurring Code
 gosub MovePlayer bank2
 if state = 0 then goto L02S0
 if state = 1 then goto L02S1
 if state = 2 then goto L02S2
 if state = 3 then goto L02S3
 if state = 4 then goto L02S4
 if state = 5 then goto L02S5
 if state = 6 then goto L02Continue
L02S0
 if collision(player0,player1) then state = 1
 if collision(player0,player2) then state = 0
 if collision(player0,player3) then state = 0
 goto L02Continue
L02S1
 if collision(player0,player1) then state = 0
 if collision(player0,player2) then state = 2
 if collision(player0,player3) then state = 0
 goto L02Continue
L02S2
 if collision(player0,player1) then state = 0
 if collision(player0,player2) then state = 0
 if collision(player0,player3) then state = 3
 goto L02Continue
L02S3
 if collision(player0,player1) then state = 4
 if collision(player0,player2) then state = 0
 if collision(player0,player3) then state = 0
 goto L02Continue
L02S4
 if collision(player0,player1) then state = 0
 if collision(player0,player2) then state = 5
 if collision(player0,player3) then state = 0
 goto L02Continue
L02S5
 if collision(player0,player1) then state = 0
 if collision(player0,player2) then state = 0
 if collision(player0,player3) then state = 6
 goto L02Continue
L02Continue
 if !collision(player0,player1) && !collision(player0,player2) && !collision(player0,player3) then state = state else player0x = 20
 if state = 6 then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L02Loop
 complete0 = complete0 | %00000100
 levelsWon = levelsWon + 1
 return

 ;Level 03
L03Setup
 ;return ; Remove to activate level
 ;Setup
 if complete0 & %00001000 then return
 gosub L03Graphics bank4
 gosub SetPlayer bank4
 player0x = 20
 player0y = 120
 state = 0
L03Loop
 ;Recurring Code
 gosub MovePlayer bank2
 if !state && collision(player0,player2)  && joy0fire then state = 2
 if !state && collision(player0,player1)  && joy0fire && player0x >= player2x && player1x >= player2x && player0y >= player2y && player1y >= player2y then state = 1
 if !state && collision(player0,player1)  && joy0fire && player0x >= player2x && player1x >= player2x && player0y <= player2y && player1y <= player2y then state = 1
 if !state && collision(player0,player1)  && joy0fire && player0x <= player2x && player1x <= player2x && player0y >= player2y && player1y >= player2y then state = 1
 if !state && collision(player0,player1)  && joy0fire && player0x <= player2x && player1x <= player2x && player0y <= player2y && player1y <= player2y then state = 1
 if !state && collision(player0,missile0) && joy0fire then state = 3
 if !state && collision(player0,missile1) && joy0fire then state = 4
 if !state && collision(player0,ball)     && joy0fire then state = 5
 if  state &&                               !joy0fire then state = 6
 if  state = 6                            && joy0fire then state = 0
 if  state = 1 then player1x =  player0x + 2
 if  state = 1 then player1y =  player0y
 if  state = 2 then player2x =  player0x + 2
 if  state = 2 then player2y =  player0y
 if  state = 3 then missile0x = player0x + 2
 if  state = 3 then missile0y = player0y
 if  state = 4 then missile1x = player0x + 2
 if  state = 4 then missile1y = player0y
 if  state = 5 then ballx     = player0x + 2
 if  state = 5 then bally     = player0y
 if  player1x > 130 && player2x > 130 && player1y > 80 && player2y > 80 && player1y < 100 && player2y < 100 then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L03Loop
 complete0 = complete0 | %00001000
 levelsWon = levelsWon + 1
 return

 ;Level 04
L04Setup
 ;return ; Remove to activate level
 ;Setup
 if complete0 & %00010000 then return
 gosub L04Graphics bank4
 gosub SetPlayer bank4
 gosub SetGem bank4
 player0x = 20
 player0y = 140
 player1x = 120
 player1y = 6
L04Loop
 ;Recurring Code
 gosub MovePlayer bank2
 gosub L04SetPF bank4
 if collision(player0,player1) then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L04Loop
 complete0 = complete0 | %00010000
 levelsWon = levelsWon + 1
 if complete0 & %00010000 then return
 return

 ;Level 05
L05Setup
 return ; Remove to activate level
 ;Setup
 if complete0 & %00100000 then return
 gosub L05Graphics bank4
L05Loop
 ;Recurring Code
 if joy0right then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L05Loop
 complete0 = complete0 | %00100000
 levelsWon = levelsWon + 1
 return

 ;Level 06
L06Setup
 return ; Remove to activate level
 ;Setup
 if complete0 & %01000000 then return
 gosub L06Graphics bank4
L06Loop
 ;Recurring Code
 if joy0down then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L06Loop
 complete0 = complete0 | %01000000
 levelsWon = levelsWon + 1
 return

 ;Level 07
L07Setup
 return ; Remove to activate level
 ;Setup
 if complete0 & %10000000 then return
 gosub L07Graphics bank4
L07Loop
 ;Recurring Code
 if joy0left then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L07Loop
 complete0 = complete0 | %10000000
 levelsWon = levelsWon + 1
 return

 ;Level 10
L10Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00000001 then return
 gosub L10Graphics bank5
L10Loop
 ;Recurring Code
 gosub MovePlayer bank2
 if joy0fire then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L10Loop
 complete1 = complete1 | %00000001
 levelsWon = levelsWon + 1
 return

 ;Level 11
L11Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00000010 then return
 gosub L11Graphics bank5
L11Loop
 ;Recurring Code
 if joy0right then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L11Loop
 complete1 = complete1 | %00000010
 levelsWon = levelsWon + 1
 return

 ;Level 12
L12Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00000100 then return
 gosub L12Graphics bank5
L12Loop
 ;Recurring Code
 if joy0down then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L12Loop
 complete1 = complete1 | %00000100
 levelsWon = levelsWon + 1
 return

 ;Level 13
L13Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00001000 then return
 gosub L13Graphics bank5
L13Loop
 ;Recurring Code
 if joy0left then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L13Loop
 complete1 = complete1 | %00001000
 levelsWon = levelsWon + 1
 return

 ;Level 14
L14Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00010000 then return
 gosub L14Graphics bank5
L14Loop
 ;Recurring Code
 if joy0up then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L14Loop
 complete1 = complete1 | %00010000
 levelsWon = levelsWon + 1
 return

 ;Level 15
L15Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %00100000 then return
 gosub L15Graphics bank5
L15Loop
 ;Recurring Code
 if joy0right then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L15Loop
 complete1 = complete1 | %00100000
 levelsWon = levelsWon + 1
 return

 ;Level 16
L16Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %01000000 then return
 gosub L16Graphics bank5
L16Loop
 ;Recurring Code
 if joy0down then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L16Loop
 complete1 = complete1 | %01000000
 levelsWon = levelsWon + 1
 return

 ;Level 17
L17Setup
 return ; Remove to activate level
 ;Setup
 if complete1 & %10000000 then return
 gosub L17Graphics bank5
L17Loop
 ;Recurring Code
 if joy0left then levelComplete = 1
 gosub Draw bank2
 ;End Level
 if !levelComplete then goto L17Loop
 complete1 = complete1 | %10000000
 levelsWon = levelsWon + 1
 return

 bank 4
 temp1 = temp1
 ;Graphics stored here
SetPlayer
 player0:
 %11111111
 %11111111
 %01111110
 %11111111
 %11011011
 %11111111
 %11111111
 %11000011
 %11100111
 %11111111
 %01111110
 %11111111
 %11111111
 %11111111
end
 player0color:
 $70
 $70
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $70
 $70
 $70
end
 return
ClearPlayer
 player0:
end
 return

ClearSprites
 player1:
end
 player2:
end
 player3:
end
 player4:
end
 player5:
end
 player6:
end
 player7:
end
 player8:
end
 player9:
end
 ballheight = 0
 missile0height = 0
 missile1height = 0
 return

SetGem
 player1:
 %00000000
 %00000000
 %00010000
 %00111000
 %01111100
 %11111110
 %01111100
 %00111000
 %00010000
 %00000000
 %00000000
 %00000000
end
 player1color:
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
 $8E
end
 return

SetKeys
 player1:
 %00001000
 %00001000
 %00001000
 %00001000
 %00111000
 %01111000
 %01111000
 %00111000
end
 player2:
 %00001000
 %00001000
 %00001000
 %00001000
 %00111000
 %01001000
 %01001000
 %00111000
end
 player3:
 %00001000
 %00001000
 %00001000
 %00001000
 %00111000
 %01001000
 %01001000
 %00111010
end
 player1-3color:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 player1x = 100
 player1y = 30
 player2x = 100
 player2y = 70
 player3x = 100
 player3y = 110
 return

SetBackground
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
ClearColor
 bkcolors:
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
end
 pfcolors:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 return

TitleScreenGraphics
 gosub SetBackground bank4
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X....XXXXX.XXXXX..XXX..XXX.....X
 X......X...X.....X....X........X
 X......X...XXXX...XX...XX......X
 X....X.X...X........X....X.....X
 X.....X....XXXXX.XXX..XXX......X
 X..............................X
 X..............................X
 X.......XXX..X...X.XXXX........X
 X......X...X.XX..X.X...X.......X
 X......XXXXX.X.X.X.X...X.......X
 X......X...X.X..XX.X...X.......X
 X......X...X.X...X.XXXX........X
 X..............................X
 X..............................X
 X.XXXX..XXXX.XXXXX.XXXX.XXXXX..X
 X.X...X.X......X...X....X....X.X
 X.XXXX..XXX....X...XXX..XXXXX..X
 X.X.....X......X...X....X....X.X
 X.X.....XXXX...X...XXXX.X....X.X
 X..............................X
 X..............................X
 X.XXX..XXX..XX..XX.XX.X..X.XXX.X
 X.X..X.X..X.X..X...X..XX.X..X..X
 X.XXX..XXX..XX..X..XX.XXXX..X..X
 X.X....X..X.X....X.X..X.XX..X..X
 X.X....X..X.XX.XX..XX.X..X..X..X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X.XX.....XX.XXX.XXX..XXX...XXX.X
 X..X.....X...X...X..X...X.X....X
 X..X..X..X...XXXXX..X...X..XX..X
 X..X.X.X.X...X...X..X...X....X.X
 X...X...X...XXX.XXX..XXX..XXX..X
 X..............................X
 X.XXX..XXX..XX..X...X...X...X..X
 X.X..X.X...X..X.X...X...X...X..X
 X.XXX..XX..XXXX.X...X....X.X...X
 X.X..X.X...X..X.X...X.....X....X
 X.X..X.XXX.X..X.XXX.XXX...X....X
 X..............................X
 X.........XXXXX.X...X..........X
 X...........X...XX..X..........X
 X...........X...X.X.X..........X
 X...........X...X..XX..........X
 X.........XXXXX.X...X..........X
 X..............................X
 X..XX..X..X..XX..XXX...XXX.XXX.X
 X.X..X.X..X.X..X.X..X.X....X...X
 X.X....XXXX.XXXX.XXX..X.XX.XX..X
 X.X..X.X..X.X..X.X..X.X..X.X...X
 X..XX..X..X.X..X.X..X..XX..XXX.X
 X..............................X
 X..............XXX.............X
 X.............X...X............X
 X................X.............X
 X...............X..............X
 X..............................X
 X...............X..............X
end
 return

EndScreenGraphics
 gosub SetBackground bank4
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X.XX...XX...XX.XXXXX.XX.....XX.X
 X..X...XX...X....X...XXX....XX.X
 X..X..XXXX..X....X...XX.X...XX.X
 X..X..XXXX..X....X...XX..X..XX.X
 X..XXXX..XXXX....X...XX...X.XX.X
 X..XXX....XXX....X...XX....XXX.X
 X..XX......XX.XXXXXX.XX.....XX.X
end
 return

EasterGraphics
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X...........................XXXX
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 X...........................X..X
 XXXXXXX.....................X..X
 X..X..X.....................X..X
 X..X..X............XX.......X..X
 X..X..X...........X..X......X..X
 X..X..X..........X....X.....X..X
 X..X..X.........XX....XX....X..X
 X..X..X........X..X..X..X...X..X
 X..X..X.......X....XX....X..X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..X......X.....XX.....X.X..X
 X..X..XXXX...X.....XX.....X.X..X
 X..XXXX..XX..X.....XX.....X.X..X
 X..XXX...XX..X.....XX.....X.X..X
 XXX........XXX.....XX.....X.X..X
 XXX........XXX.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.X..........X.....XX.....X.X..X
 X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.XX...........................X
 X.XX...........................X
 X.XX.........XXXXXX............X
 X.XX.......XXX....XXX..........X
 X.XX.....XXX........XXX........X
 X.XX...XX..............XX......X
 X.XX..XX................XX.....X
 X.XX.XX..................XX....X
 X.XXXXXXXXXXXXXXXXXXXXXXXXXX...X
 X.XX........................X..X
 X.XX........................X..X
 X.XX.........................X.X
 X.XX.........................X.X
 XXXX..........................XX
end
 return


L00Graphics
 ;Custom playfield
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX.....................X
 X..............................X
 X.....XXXX....XXXX.............X
 X.............XXXX.............X
 X..............................X
 X.....XXXX.....................X
 X.............XXXX.............X
 X.....XXXX.....................X
 X.............XXXX.............X
 X.....XXXX....XXXX.............X
 X..............................X
 X..............................X
 X.............XXXX....XXXX.....X
 X.....................XXXX.....X
 X.............XXXX....XXXX.....X
 X..............................X
 X.............XXXX....XXXX.....X
 X..............................X
 X.............XXXX....XXXX.....X
 X.....................XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX.............X
 X..............................X
 X.....................XXXX.....X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX....XXXX.............X
 X.............XXXX....XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX....XXXX.............X
 X.....XXXX............XXXX.....X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX....XXXX.....X
 X..............................X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX....XXXX.............X
 X.............XXXX....XXXX.....X
 X.....................XXXX.....X
 X..............................X
 X.....XXXX.....................X
 X.....XXXX............XXXX.....X
 X.....................XXXX.....X
 X.....XXXX.....................X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X..............................X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX.....................X
 X.....................XXXX.....X
 X.....XXXX............XXXX.....X
 X.................XXXX.........X
 X.....XXXX....XXXX....XXXX.....X
 X..............................X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX....XXXX....XXXX.....X
 X..............................X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX....XXXX....XXXX.....X
 X.....................XXXX.....X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX....XXXX.....X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X..............................X
 X.....XXXX....XXXX.............X
 X.....XXXX.....................X
 X..............................X
 X.....XXXX....XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.....XXXX....XXXX.............X
end
 gosub DrawX1 bank5
L00Color
 gosub ClearColor bank4
 if switchbw then return
 bkcolors:
 $1E
 $BC
 $9C
 $3C
 $EA
 $6A
 $2C
 $DE
 $BC
 $5E
 $EE
 $2C
 $2A
 $EA
 $2C
 $5C
 $CE
 $BC
 $AA
 $AE
 $AC
 $6A
 $CC
 $6E
 $4E
 $DE
 $6C
 $DC
 $9E
 $FC
 $AC
 $EE
 $3A
 $4E
 $3E
 $BA
 $DE
 $FC
 $9A
 $8C
 $3C
 $9A
 $AA
 $5C
 $5C
 $6A
 $EC
 $AE
 $CE
 $8A
 $6E
 $3A
 $FE
 $4E
 $1C
 $7C
 $2C
 $AE
 $4C
 $4A
 $3A
 $7A
 $EC
 $EE
 $9A
 $EC
 $EC
 $AA
 $EC
 $2E
 $6A
 $4A
 $4E
 $CC
 $9C
 $FC
 $AE
 $9C
 $FC
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
end
  pfcolors:
 $AE
 $BA
 $2A
 $EC
 $7C
 $CC
 $AA
 $7C
 $6C
 $6E
 $6E
 $8E
 $FC
 $EA
 $EA
 $7A
 $DA
 $3A
 $BA
 $5E
 $8E
 $1C
 $9C
 $DA
 $5A
 $FE
 $CA
 $6A
 $8E
 $AE
 $AE
 $DC
 $3C
 $3E
 $2C
 $9C
 $DC
 $4E
 $3C
 $AA
 $3A
 $3A
 $FA
 $FA
 $FA
 $8E
 $EA
 $AE
 $FA
 $3E
 $1A
 $8E
 $FA
 $9E
 $EE
 $EE
 $2C
 $3E
 $EA
 $EC
 $6A
 $EE
 $7E
 $FA
 $4C
 $DE
 $6A
 $2C
 $DA
 $CC
 $1E
 $EC
 $DA
 $CE
 $DA
 $4C
 $6C
 $FC
 $FC 
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 return

L01Graphics
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.....XXXX....XXXX....XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXXXXXXXXXXXXXXXXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXX............XXXX.....X
 X.....XXXXXXXXXXXX....XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 X.....................XXXX.....X
 XXXXXXXXXX....XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXX....XXXX.....X
 X.............XXXXXXXXXXXX.....X
 X.............XXXX.............X
 X.............XXXX.............X
 X.............XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
 X.....XXXX....XXXX.............X
end
 gosub DrawX2 bank5
 pfcolors:
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $00
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 return

L02Graphics
 gosub SetBackground bank4
 gosub SetKeys bank4
 gosub SetPlayer bank4
 gosub DrawX3 bank5
 return

L03Graphics
 gosub SetBackground bank4
 gosub DrawX4 bank5
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X........XXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
end
 player1:
 %00111100
 %01000010
 %10000001
 %10000001
 %10000001
 %10000001
 %01000010
 %00111100
end
 player1color:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 player2:
 %11111111
 %10000001
 %10000001
 %10000001
 %10000001
 %10000001
 %10000001
 %11111111
end
 player2color:
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
 $0E
end
 missile1x = 130
 missile0y = 60
 missile0height = 8
 missile0x = 130
 missile1y = 25
 missile1height = 8
 ballheight = 8
 COLUM0 = $0E
 COLUM1 = $0E
 NUSIZ0 = $30
 NUSIZ1 = $30
 NUSIZ2 = $30
 player1x = 129
 player1y = 6
 player2x = 129
 player2y = 78
 ballx = 134
 bally = 43
 return

L04Graphics
 gosub SetBackground bank4
 gosub DrawX5 bank5
L04SetPF
 if !switchleftb && !switchrightb then goto L04PF00
 if !switchleftb &&  switchrightb then goto L04PF01
 if  switchleftb && !switchrightb then goto L04PF10
 if  switchleftb &&  switchrightb then goto L04PF11
L04PF00
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
end
 return
L04PF01
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........XXXXXXXXXXXXXX........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 X........X............X........X
 XXXXXXXXXX............XXXXXXXXXX
end
 return
L04PF10
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return
L04PF11 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 X........X.....................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 X.....................X........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return

L05Graphics
 gosub SetBackground bank4
 gosub DrawX6 bank5
 return

L06Graphics
 gosub SetBackground bank4
 gosub DrawX7 bank5
 return

L07Graphics
 gosub SetBackground bank4
 gosub DrawX8 bank5
 return

L10Graphics
 gosub SetBackground bank4
 gosub DrawX9 bank5
 return

L11Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX0 bank5
 return

L12Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX1 bank5
 return

L13Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX2 bank5
 return

L14Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX3 bank5
 return

L15Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX4 bank5
 return

L16Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX5 bank5
 return

L17Graphics
 gosub SetBackground bank4
 gosub Draw1X bank5
 gosub DrawX6 bank5
 return

 bank 5
 temp1 = temp1

;Draw0X
; pfpixel  9 81 off
; pfpixel  9 82 off
; pfpixel  9 83 off
; pfpixel  9 84 off
; pfpixel  9 85 off
; pfpixel 10 80 off
; pfpixel 10 86 off
; pfpixel 11 80 off
; pfpixel 11 86 off
; pfpixel 12 80 off
; pfpixel 12 86 off
; pfpixel 13 81 off
; pfpixel 13 82 off
; pfpixel 13 83 off
; pfpixel 13 84 off
; pfpixel 13 85 off
; return
Draw1X
 pfpixel  9 86 off
 pfpixel 10 81 off
 pfpixel 10 86 off
 pfpixel 11 80 off
 pfpixel 11 81 off
 pfpixel 11 82 off
 pfpixel 11 83 off
 pfpixel 11 84 off
 pfpixel 11 85 off
 pfpixel 11 86 off
 pfpixel 12 86 off
 pfpixel 13 86 off
 return
DrawX0
 pfpixel 16 85 off
 pfpixel 16 84 off
 pfpixel 16 83 off
 pfpixel 16 82 off
 pfpixel 16 81 off
 pfpixel 17 86 off
 pfpixel 17 80 off
 pfpixel 18 86 off
 pfpixel 18 80 off
 pfpixel 19 86 off
 pfpixel 19 80 off
 pfpixel 20 85 off
 pfpixel 20 84 off
 pfpixel 20 83 off
 pfpixel 20 82 off
 pfpixel 20 81 off
 return
DrawX1
 pfpixel 16 86 off
 pfpixel 17 81 off
 pfpixel 17 86 off
 pfpixel 18 80 off
 pfpixel 18 81 off
 pfpixel 18 82 off
 pfpixel 18 83 off
 pfpixel 18 84 off
 pfpixel 18 85 off
 pfpixel 18 86 off
 pfpixel 19 86 off
 pfpixel 20 86 off
 return
DrawX2
 pfpixel 16 81 off
 pfpixel 16 86 off
 pfpixel 17 80 off
 pfpixel 17 85 off
 pfpixel 17 86 off
 pfpixel 18 80 off
 pfpixel 18 84 off
 pfpixel 18 86 off
 pfpixel 19 80 off
 pfpixel 19 83 off
 pfpixel 19 86 off
 pfpixel 20 81 off
 pfpixel 20 82 off
 pfpixel 20 86 off
 return
DrawX3
 pfpixel 16 85 off
 pfpixel 16 81 off
 pfpixel 17 86 off
 pfpixel 17 80 off
 pfpixel 18 86 off
 pfpixel 18 83 off
 pfpixel 18 80 off
 pfpixel 19 86 off
 pfpixel 19 83 off
 pfpixel 19 80 off
 pfpixel 20 85 off
 pfpixel 20 84 off
 pfpixel 20 82 off
 pfpixel 20 81 off
 return
DrawX4
 pfpixel 16 83 off
 pfpixel 17 82 off
 pfpixel 17 83 off
 pfpixel 18 81 off
 pfpixel 18 83 off
 pfpixel 19 80 off
 pfpixel 19 83 off
 pfpixel 20 80 off
 pfpixel 20 81 off
 pfpixel 20 82 off
 pfpixel 20 83 off
 pfpixel 20 84 off
 pfpixel 20 85 off
 pfpixel 20 86 off
 return
DrawX5
 pfpixel 16 80 off
 pfpixel 16 81 off
 pfpixel 16 82 off
 pfpixel 16 83 off
 pfpixel 16 85 off
 pfpixel 17 80 off
 pfpixel 17 83 off
 pfpixel 17 86 off
 pfpixel 18 80 off
 pfpixel 18 83 off
 pfpixel 18 86 off
 pfpixel 19 80 off
 pfpixel 19 83 off
 pfpixel 19 86 off
 pfpixel 20 80 off
 pfpixel 20 84 off
 pfpixel 20 85 off
 return
DrawX6
 return
DrawX7
 return
DrawX8
 return
DrawX9
 return

 bank 6
 temp1 = temp1