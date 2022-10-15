#####################################################################
#
#
# Student: Canyang Wang, Student Number: 1006931652
#
#
#
#
 # CSC258H5S Fall 2021 Assembly Final Project
 # University of Toronto, St. George
 # Bitmap Display Configuration:
 # - Unit width in pixels: 8
 # - Unit height in pixels: 8
 # - Display width in pixels: 256
 # - Display height in pixels: 256
 # - Base Address for Display: 0x10008000 ($gp)
 # Which milestone is reached in this submission?
 # Milestone 5
 # - Milestone 1/2/3/4/5 (choose the one the applies)
 # Which approved additional features have been implemented?
 # (See the assignment handout for the list of additional features)
 # 1. After final player death, display game over/retry screen. Restart the game if the “retry” option is chosen.
 # 2. Display the number of lives remaining.
 # 3. Add sound effects for movement, collisions, game end and reaching the goal area.
 # 4. Display a death/respawn animation each time the player loses a frog.
 # 5. Two-player mode (two sets of inputs controlling two frogs at the same time)
 # 6. Display the player’s score at the top of the screen.
 # Any additional information that the TA needs to know:
 # keyboard r for restart the game
 # This frog game need two players to compete, who can win this game faster will be the winner, and each player has 3 lifes
#
#####################################################################

.data
displayAddress: .word 0x10008000
GoalColor: .word 0xff0000  # The goal area of colour is red
Middle_lane_Color: .word 0x0000ff # The middle lane colour is blue
Log_area_colour: .word 0x00ff00 # The log area of colour is dark green
Car_area_colour: .word 0x915e2a # The car area of colour is gray
colour_of_log: .word 0x3b85ce # A kind of light blue
colour_of_car: .word 0xce3bb1 # A kind of dark pink
CarColor: .word 0xff0000 # red color is our car color
Frog: .word 0x000000 # The colour of frog is black
Frog2: .word 0xffffff # The colour of frog is black
Frog_position: .word 3648, 3660, 3776, 3780, 3784, 3788, 3908, 3912, 4032, 4036, 4040, 4044 # The initial place of frog
Frog_initial_position: .word 3648, 3660, 3776, 3780, 3784, 3788, 3908, 3912, 4032, 4036, 4040, 4044 # The initial place of frog
Frog_position2: .word 3632, 3644, 3760, 3764, 3768, 3772, 3892, 3896, 4016, 4020, 4024, 4028 # The initial place of frog2
Frog_initial_position2: .word 3632, 3644, 3760, 3764, 3768, 3772, 3892, 3896, 4016, 4020, 4024, 4028 # The initial place of frog2

# The position for the four logs
Position1_log: .word 1040, 1044, 1048, 1052, 1056, 1060, 1064, 1068, 1168, 1172, 1176, 1180, 1184, 1188, 1192, 1196, 1296, 1300, 1304, 1308, 1312, 1316, 1320, 1324, 1424, 1428, 1432, 1436, 1440, 1444, 1448, 1452
Position2_log: .word 1104, 1108, 1112, 1116, 1120, 1124, 1128, 1132, 1232, 1236, 1240, 1244, 1248, 1252, 1256, 1260, 1360, 1364, 1368, 1372, 1376, 1380, 1384, 1388, 1488, 1492, 1496, 1500, 1504, 1508, 1512, 1516
Position3_log: .word 1564, 1568, 1572, 1576, 1580, 1584, 1588, 1592, 1692, 1696, 1700, 1704, 1708, 1712, 1716, 1720, 1820, 1824, 1828, 1832, 1836, 1840, 1844, 1848, 1948, 1952, 1956, 1960, 1964, 1968, 1972, 1976
Position4_log: .word 1628, 1632, 1636, 1640, 1644, 1648, 1652, 1656, 1756, 1760, 1764, 1768, 1772, 1776, 1780, 1784, 1884, 1888, 1892, 1896, 1900, 1904, 1908, 1912, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040
Position1_car: .word 2592, 2596, 2600, 2604, 2608, 2612, 2616, 2620, 2720, 2724, 2728, 2732, 2736, 2740, 2744, 2748, 2848, 2852, 2856, 2860, 2864, 2868, 2872, 2876, 2976, 2980, 2984, 2988, 2992, 2996, 3000, 3004
Position2_car: .word 2656, 2660, 2664, 2668, 2672, 2676, 2680, 2684, 2784, 2788, 2792, 2796, 2800, 2804, 2808, 2812, 2912, 2916, 2920, 2924, 2928, 2932, 2936, 2940, 3040, 3044, 3048, 3052, 3056, 3060, 3064, 3068
Position3_car: .word 3088, 3092, 3096, 3100, 3104, 3108, 3112, 3116, 3216, 3220, 3224, 3228, 3232, 3236, 3240, 3244, 3344, 3348, 3352, 3356, 3360, 3364, 3368, 3372, 3472, 3476, 3480, 3484, 3488, 3492, 3496, 3500
Position4_car: .word 3152, 3156, 3160, 3164, 3168, 3172, 3176, 3180, 3280, 3284, 3288, 3292, 3296, 3300, 3304, 3308, 3408, 3412, 3416, 3420, 3424, 3428, 3432, 3436, 3536, 3540, 3544, 3548, 3552, 3556, 3560, 3564
log_and_car_Length: .word 8
water_road_region: .word 1024, 1028, 1032, 1036, 1040, 1044, 1048, 1052, 1056, 1060, 1064, 1068, 1072, 1076, 1080, 1084, 1088, 1092, 1096, 1100, 1104, 1108, 1112, 1116, 1120, 1124, 1128, 1132, 1136, 1140, 1144, 1148, 1152, 1156, 1160, 1164, 1168, 1172, 1176, 1180, 1184, 1188, 1192, 1196, 1200, 1204, 1208, 1212, 1216, 1220, 1224, 1228, 1232, 1236, 1240, 1244, 1248, 1252, 1256, 1260, 1264, 1268, 1272, 1276, 1280, 1284, 1288, 1292, 1296, 1300, 1304, 1308, 1312, 1316, 1320, 1324, 1328, 1332, 1336, 1340, 1344, 1348, 1352, 1356, 1360, 1364, 1368, 1372, 1376, 1380, 1384, 1388, 1392, 1396, 1400, 1404, 1408, 1412, 1416, 1420, 1424, 1428, 1432, 1436, 1440, 1444, 1448, 1452, 1456, 1460, 1464, 1468, 1472, 1476, 1480, 1484, 1488, 1492, 1496, 1500, 1504, 1508, 1512, 1516, 1520, 1524, 1528, 1532, 1536, 1540, 1544, 1548, 1552, 1556, 1560, 1564, 1568, 1572, 1576, 1580, 1584, 1588, 1592, 1596, 1600, 1604, 1608, 1612, 1616, 1620, 1624, 1628, 1632, 1636, 1640, 1644, 1648, 1652, 1656, 1660, 1664, 1668, 1672, 1676, 1680, 1684, 1688, 1692, 1696, 1700, 1704, 1708, 1712, 1716, 1720, 1724, 1728, 1732, 1736, 1740, 1744, 1748, 1752, 1756, 1760, 1764, 1768, 1772, 1776, 1780, 1784, 1788, 1792, 1800, 1804, 1808, 1812, 1816, 1820, 1824, 1828, 1832, 1836, 1840, 1844, 1848, 1852, 1856, 1860, 1864, 1868, 1872, 1876, 1880, 1884, 1888, 1892, 1896, 1900, 1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 2044
goal_region: .word 0, 4, 8, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188, 192, 196, 200, 204, 208, 212, 216, 220, 224, 228, 232, 236, 240, 244, 248, 252, 256, 260 ,264, 268, 272, 276, 280, 284, 288, 292, 296, 300, 304, 308, 312, 316, 320, 324, 328, 332, 336, 340, 344, 348, 352, 356, 360, 364, 368, 372, 376, 380, 384, 388, 392, 396, 400, 404, 408, 412, 416, 420, 424, 428, 432, 436, 440, 444, 448, 452, 456, 460, 464, 468, 472, 476, 480, 484, 488, 492, 496, 500, 504, 508, 512, 516, 520, 524, 528, 532, 536, 540, 544, 548, 552, 556, 560, 564, 568, 572, 576, 580, 584, 588, 592, 596, 600, 604, 608, 612, 616, 620, 624, 628, 632, 636, 640, 644, 648, 652, 656, 660, 664, 668, 672, 676, 680, 684, 688, 692, 696, 700, 704, 708, 712, 716, 720, 724, 728, 732, 736, 740, 744, 748, 752, 756, 760, 764, 768, 772, 776, 780, 784, 788, 792, 796, 800, 804, 808, 812, 816, 820, 824, 828, 832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 872, 876, 880, 884, 888, 892, 896, 900, 904, 908, 912, 916, 920, 924, 928, 932, 936, 940, 944, 948, 952, 956, 960, 964, 968, 972, 976, 980, 984, 988, 992, 996, 1000, 1004, 1008, 1012, 1016, 1020
Frog_change_colour1: .word 0xffee35
Frog_change_colour2: .word 0xff0000
Score1: .word 0
Message1: .ascii "\n Your current score for player 1 at this step is: \n"
Score2: .word 0
Message2: .ascii "\n Your current score for player 2 at this step is: \n"
count_for_win_time1: .word 0
count_for_win_time2: .word 0
life: .word 3
life2: .word 3
.text
main:
     jal Background_draw # jump and link Backgroud_draw
     jal place_frog
     j Key_board 
    



	
	
Background_draw:
li $a0, 0 #load the start point
li $t0, 1024 # load the maximum length of the region
addi $sp, $sp, -4
sw $ra, 0($sp)
# loop to draw a background
Loop_Background: beq $a0, $t0, END # when a0 = 1024 it will end the loop and return to END
# Draw the five region on of different parts
jal draw_Goal 
jal draw_Log_area
jal draw_Middle
jal draw_Car_area
jal draw_start_area
addi $a0, $a0, 4 #Each increment by 4 can will be draw for the next word
li $t0, 1024 # The area with the biggest length among the five area which is 8
j Loop_Background
END: lw $ra 0($sp)
addi $sp, $sp, 4
jr $ra

draw_Goal:
lw $t0, displayAddress # Load the initial address
lw $t1, GoalColor # Load the colour of this region
li $t2, 0 # The initial of the goal area
la $t4, ($a0) # store the current address into t4
add $t2, $t2, $t0 # load the address of start word
add $t2, $t2, $t4 # load the address of current word
sw $t1, ($t2) # draw the current word
jr $ra 

draw_Log_area:
lw $t0, displayAddress
lw $t1, Log_area_colour
li $t2, 1024 # The initial of the Log area
la $t4, ($a0) # store the current address into t4
add $t2, $t2, $t0 # load the address of start word
add $t2, $t2, $t4 # load the address of current word
sw $t1, ($t2) # draw the current word
jr $ra
draw_Middle:
lw $t0, displayAddress
lw $t1, Middle_lane_Color
li $t2, 2048 # The initial of the middle area
la $t4, ($a0) # store the current address into t4

bge $t4, 512, Finish
add $t2, $t2, $t0 # load the address of start word
add $t2, $t2, $t4 # load the address of current word
sw $t1, ($t2) # draw the current word
Finish:
jr $ra 
draw_Car_area:
lw $t0, displayAddress
lw $t1, Car_area_colour
li $t2, 2560 # The initial of the Car area
la $t4, ($a0) # store the current address into t4
add $t2, $t2, $t0 # load the address of start word
add $t2, $t2, $t4 # load the address of current word
sw $t1, ($t2) # draw the current word
jr $ra

draw_start_area:
lw $t0, displayAddress
lw $t1, GoalColor
li $t2,  3584# The initial of the start area
la $t4, ($a0) # store the current address into t4
bge $t4, 512, Finish2
add $t2, $t2, $t0 # load the address of start word
add $t2, $t2, $t4 # load the address of current word
sw $t1, ($t2) # draw the current word
Finish2:
jr $ra 


place_frog:
# Draw the frog using the drawFrog function
	addi $sp, $sp, -4
	sw $ra, 0($sp)
 	li $a1, 0
 	li $t0, 4 
place_log:
	beq $a1, $t0, renew #when a1 = t0, all the logs are drawed
	jal DrawLog
	addi $a1, $a1, 1 # increment each time in order to draw each log
	li $t0, 4
	j place_log
renew:
	li $a2, 0
	li $t0, 4 # Load value to prepare to draw the cars
place_car: 
	beq $a2, $t0, All_Done # When a2 = t0, End the loop means all I need are drawn on the background.
	jal DrawCar
	addi $a2, $a2, 1
	li $t0, 4
	j place_car
All_Done:
	jal draw_life1
	jal draw_life2
	jal drawFrog
	jal drawFrog2
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
 	
# Function to draw the Frog:	
drawFrog:		
	lw $t0, displayAddress	
	lw $t1, Frog		# Load the colour of frog
	la $t2, Frog_position	# Load the initial place of Frog
	lw $t3, 0($t2)		# Load the left-most word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)	
	lw $t3, 4($t2)		# Load the right-most word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 8($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 12($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 16($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 20($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 24($t2)		# Load the third line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 28($t2)		# Load the third line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 32($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 36($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 40($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 44($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	jr $ra

drawFrog2:		
	lw $t0, displayAddress	
	lw $t1, Frog2		# Load the colour of frog
	la $t2, Frog_position2	# Load the initial place of Frog
	lw $t3, 0($t2)		# Load the left-most word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)	
	lw $t3, 4($t2)		# Load the right-most word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 8($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 12($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 16($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 20($t2)		# Load the second line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 24($t2)		# Load the third line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 28($t2)		# Load the third line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 32($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 36($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 40($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	lw $t3, 44($t2)		# Load the fourth line word of frog
	add $t3, $t3, $t0
	sw $t1, ($t3)
	jr $ra
#Function to draw a car
DrawCar:
la $t1, ($a2)
li $t2, 0
beq $t1, $t2, Draw_Car1
li $t2, 1
beq $t1, $t2, Draw_Car2
li $t2, 2
beq $t1, $t2, Draw_Car3
li $t2, 3
beq $t1, $t2, Draw_Car4


Draw_Car1:
lw $t0, displayAddress
la $t1, Position1_car
lw $t2, colour_of_car
li $t3, 0
j Draw_Log_main

Draw_Car2:
lw $t0, displayAddress
la $t1, Position2_car
lw $t2, colour_of_car
li $t3, 0
j Draw_Log_main

Draw_Car3:
lw $t0, displayAddress
la $t1, Position3_car
lw $t2, colour_of_car
li $t3, 0
j Draw_Log_main

Draw_Car4:
lw $t0, displayAddress
la $t1, Position4_car
lw $t2, colour_of_car
li $t3, 0
j Draw_Log_main

#Fuction to draw the Log 
# Each time draw one Log based on the given position I should draw
DrawLog:
# I give one explanation for Log 1 and otehrs are just as the same arithmetic as well as the cars
la $t1, ($a1) # Get the current place where log to draw
li $t2, 0 # Check if the current place is to draw the first log
beq $t1, $t2, Draw_Log1 
li $t2, 1
beq $t1, $t2, Draw_Log2
li $t2, 2
beq $t1, $t2, Draw_Log3
li $t2, 3
beq $t1, $t2, Draw_Log4

# I give one explanation for Log 1 and otehrs are just as the same arithmetic as well as the cars
Draw_Log1:
lw $t0, displayAddress
la $t1, Position1_log # Position to draw the log
lw $t2, colour_of_log # The colour for the log
li $t3, 0
j Draw_Log_main # jump to the draw function to draw the Log and cars can also use this, since they are just the same object to draw.

Draw_Log2:
lw $t0, displayAddress
la $t1, Position2_log
lw $t2, colour_of_log
li $t3, 0
j Draw_Log_main

Draw_Log3:
lw $t0, displayAddress
la $t1, Position3_log
lw $t2, colour_of_log
li $t3, 0
j Draw_Log_main

Draw_Log4:
lw $t0, displayAddress
la $t1, Position4_log
lw $t2, colour_of_log
li $t3, 0
j Draw_Log_main



Draw_Log_main:
beq $t3, 128, Done # Each log or car has 32 words in total, thus to check all the words are drawn for each log or car.
lw $t5, 0($t1) # load the position of log 
add $t5, $t5, $t0 # Add the position to the display address in order to draw the object
sw $t2, ($t5) # Draw the particular object based on its colour
add $t1, $t1, 4 # Go through all the words of different objects
add $t3, $t3, 4 # Increment the number t3 to make sure each word of an object is drawn already
j Draw_Log_main # Loop again until it end.
Done: jr $ra

##### funtion to draw the life for frog1 and for frog 2 follow the same algorithm
draw_life1:
la $s5, life ## load life
lw $s6, ($s5)
beq $s6, 3, draw_full_life ### which life should show on the screen
beq $s6, 2, draw_minus1_life
beq $s6, 1, draw_minus2_life
beq $s6, 0, draw_minus3_life

draw_full_life:
lw $t0, displayAddress # Load the initial address
lw $t1, colour_of_car # Load the colour of this region
li $t2, 0 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
jr $ra

draw_minus1_life:
lw $t0, displayAddress # Load the initial address
lw $t1, colour_of_car # Load the colour of this region
lw $t3, GoalColor # Load the colour of this region
li $t2, 0 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

draw_minus2_life:
lw $t0, displayAddress # Load the initial address
lw $t1, colour_of_car # Load the colour of this region
lw $t3, GoalColor # Load the colour of this region
li $t2, 0 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

draw_minus3_life:
lw $t0, displayAddress # Load the initial address
lw $t1, GoalColor # Load the colour of this region
lw $t3, GoalColor # Load the colour of this region
li $t2, 0 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

draw_life2:
la $s5, life2
lw $s6, ($s5)
beq $s6, 3, draw_full_life_player2
beq $s6, 2, draw_minus1_life_player2
beq $s6, 1, draw_minus2_life_player2
beq $s6, 0, draw_minus3_life_player2

draw_full_life_player2:
lw $t0, displayAddress # Load the initial address
lw $t1, Log_area_colour # Load the colour of this region
li $t2, 108 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
jr $ra

draw_minus1_life_player2:
lw $t0, displayAddress # Load the initial address
lw $t1, Log_area_colour # Load the colour of this region
lw $t3, GoalColor # Load the colour of this region
li $t2, 108 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

draw_minus2_life_player2:
lw $t0, displayAddress # Load the initial address
lw $t1, Log_area_colour # Load the colour of this region
lw $t3, GoalColor # Load the colour of this region
li $t2, 108 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t1, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

draw_minus3_life_player2:
lw $t0, displayAddress # Load the initial address
lw $t3, GoalColor # Load the colour of this region
li $t2, 108 # The initial of the goal area
add $t2, $t2, $t0 # load the address of start word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
addi $t2, $t2, 8 # load the address of current word
sw $t3, ($t2) # draw the current word
jr $ra

Key_board:  # Keyboard area for moving the frog
lw $t8, 0xffff0000
beq $t8, 1, keyboard_input
j sleep

keyboard_input: # Input A,j for left moving, D,l for right moving, W,i for upward moving and D,k for downward moving
lw $t1, 0xffff0004
beq $t1, 0x61, A
beq $t1, 0x64, D
beq $t1, 0x77, W
beq $t1, 0x73, S
beq $t1, 106, J
beq $t1, 107, K
beq $t1, 108, L
beq $t1, 105, I
j sleep



A: 
	jal move_left # jump and link function move_left
	j sleep
D: 
	jal move_right # jump and link function move_right
	j sleep
W: 
	jal move_up # # jump and link function move_up
	j sleep
S: 
	jal move_down # # jump and link function move_down
	j sleep
J: 
	jal move_left2 # jump and link function move_left
	j sleep
L: 
	jal move_right2 # jump and link function move_right
	j sleep
I: 
	jal move_up2 # # jump and link function move_up
	j sleep
K: 
	jal move_down2 # # jump and link function move_down
	j sleep
move_left:

la $t0, Frog_position # load frog position
lw $t1, 0($t0) # load each word of the frog
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 0 # make an accumulator 
## all the blew moving position of a frog is using the same algorithm.
If_move_Left: # judge if the frog can move during its current position
	beq $s3, 3712, MOVE_LEFT # judge if the frog can move left
	beq $t1, $s3, Finish_move # judge if the frog move at the marginal of the screen, if reach, then finish.
	addi $s3, $s3, 128 # to accumulate
	j If_move_Left # loop again
MOVE_LEFT:
	subi $t1, $t1, 16 # Move  words left since the width of a frog is 4 words
	subi $t2, $t2, 16
	subi $t3, $t3, 16
	subi $t4, $t4, 16
	subi $t5, $t5, 16
	subi $t6, $t6, 16
	subi $t7, $t7, 16
	subi $t8, $t8, 16
	subi $t9, $t9, 16
	subi $s0, $s0, 16
	subi $s1, $s1, 16
	subi $s2, $s2, 16
	sw $t1, 0($t0) # store the word during its current position
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score1
	lw $a1, ($a0)
	subi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_move
Finish_move: jr $ra

move_right:

la $t0, Frog_position
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 124

If_move_right:	
	beq $s3, 3836, MOVE_RIGHT
	beq $t2, $s3, Finish_right
	addi $s3, $s3, 128
	j If_move_right
MOVE_RIGHT:
	addi $t1, $t1, 16
	addi $t2, $t2, 16
	addi $t3, $t3, 16
	addi $t4, $t4, 16
	addi $t5, $t5, 16
	addi $t6, $t6, 16
	addi $t7, $t7, 16
	addi $t8, $t8, 16
	addi $t9, $t9, 16
	addi $s0, $s0, 16
	addi $s1, $s1, 16
	addi $s2, $s2, 16
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score1
	lw $a1, ($a0)
	addi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_right
Finish_right: jr $ra

move_up:

la $t0, Frog_position
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 0

If_move_up:	
	beq $s3, 508, MOVE_UP
	beq $t9, $s3, Finish_up
	addi $s3, $s3, 4
	j If_move_up
MOVE_UP:
	subi $t1, $t1, 512
	subi $t2, $t2, 512
	subi $t3, $t3, 512
	subi $t4, $t4, 512
	subi $t5, $t5, 512
	subi $t6, $t6, 512
	subi $t7, $t7, 512
	subi $t8, $t8, 512
	subi $t9, $t9, 512
	subi $s0, $s0, 512
	subi $s1, $s1, 512
	subi $s2, $s2, 512
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score1
	lw $a1, ($a0)
	addi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_up


Finish_up: jr $ra


move_down:

la $t0, Frog_position
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 3584


If_move_down:	
	beq $s3, 3712, MOVE_DOWN
	beq $t2, $s3, Finish_down
	addi $s3, $s3, 4
	j If_move_down
MOVE_DOWN:
	addi $t1, $t1, 512
	addi $t2, $t2, 512
	addi $t3, $t3, 512
	addi $t4, $t4, 512
	addi $t5, $t5, 512
	addi $t6, $t6, 512
	addi $t7, $t7, 512
	addi $t8, $t8, 512
	addi $t9, $t9, 512
	addi $s0, $s0, 512
	addi $s1, $s1, 512
	addi $s2, $s2, 512
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score1
	lw $a1, ($a0)
	subi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_down
Finish_down: jr $ra


move_left2:

la $t0, Frog_position2 # load frog position
lw $t1, 0($t0) # load each word of the frog
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 0 # make an accumulator to loop through
## all the blew moving position of a frog is using the same algorithm.
If_move_Left2: # judge if the frog can move during its current position
	beq $s3, 3712, MOVE_LEFT2 # judge if the frog can move left
	beq $t1, $s3, Finish_move2 # judge if the frog move at the marginal of the screen, if reach, then finish.
	addi $s3, $s3, 128 # to accumulate
	j If_move_Left2 # loop again
MOVE_LEFT2:
	subi $t1, $t1, 16 # Move 4 words left since the width of a frog is 4 words
	subi $t2, $t2, 16
	subi $t3, $t3, 16
	subi $t4, $t4, 16
	subi $t5, $t5, 16
	subi $t6, $t6, 16
	subi $t7, $t7, 16
	subi $t8, $t8, 16
	subi $t9, $t9, 16
	subi $s0, $s0, 16
	subi $s1, $s1, 16
	subi $s2, $s2, 16
	sw $t1, 0($t0) # store the word during its current position
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score2
	lw $a1, ($a0)
	subi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_move2
Finish_move2: jr $ra

move_right2:

la $t0, Frog_position2
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 124

If_move_right2:	
	beq $s3, 3836, MOVE_RIGHT2
	beq $t2, $s3, Finish_right2
	addi $s3, $s3, 128
	j If_move_right2
MOVE_RIGHT2:
	addi $t1, $t1, 16
	addi $t2, $t2, 16
	addi $t3, $t3, 16
	addi $t4, $t4, 16
	addi $t5, $t5, 16
	addi $t6, $t6, 16
	addi $t7, $t7, 16
	addi $t8, $t8, 16
	addi $t9, $t9, 16
	addi $s0, $s0, 16
	addi $s1, $s1, 16
	addi $s2, $s2, 16
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score2
	lw $a1, ($a0)
	addi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_right2
Finish_right2: jr $ra

move_up2:

la $t0, Frog_position2
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 0

If_move_up2:	
	beq $s3, 508, MOVE_UP2
	beq $t9, $s3, Finish_up2
	addi $s3, $s3, 4
	j If_move_up2
MOVE_UP2:
	subi $t1, $t1, 512
	subi $t2, $t2, 512
	subi $t3, $t3, 512
	subi $t4, $t4, 512
	subi $t5, $t5, 512
	subi $t6, $t6, 512
	subi $t7, $t7, 512
	subi $t8, $t8, 512
	subi $t9, $t9, 512
	subi $s0, $s0, 512
	subi $s1, $s1, 512
	subi $s2, $s2, 512
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score2
	lw $a1, ($a0)
	addi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_up2
Finish_up2: jr $ra


move_down2:

la $t0, Frog_position2
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0)
lw $t6, 20($t0)
lw $t7, 24($t0)
lw $t8, 28($t0)
lw $t9, 32($t0)
lw $s0, 36($t0)
lw $s1, 40($t0)
lw $s2, 44($t0)
li $s3, 3584


If_move_down2:	
	beq $s3, 3712, MOVE_DOWN2
	beq $t2, $s3, Finish_down2
	addi $s3, $s3, 4
	j If_move_down2
MOVE_DOWN2:
	addi $t1, $t1, 512
	addi $t2, $t2, 512
	addi $t3, $t3, 512
	addi $t4, $t4, 512
	addi $t5, $t5, 512
	addi $t6, $t6, 512
	addi $t7, $t7, 512
	addi $t8, $t8, 512
	addi $t9, $t9, 512
	addi $s0, $s0, 512
	addi $s1, $s1, 512
	addi $s2, $s2, 512
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t3, 8($t0)
	sw $t4, 12($t0)
	sw $t5, 16($t0)
	sw $t6, 20($t0)
	sw $t7, 24($t0)
	sw $t8, 28($t0)
	sw $t9, 32($t0)
	sw $s0, 36($t0)
	sw $s1, 40($t0)
	sw $s2, 44($t0)
	la $a0, Score2
	lw $a1, ($a0)
	subi $a1, $a1, 200
	sw $a1, ($a0)
	j add_sound
	j Finish_down2
Finish_down2: jr $ra


## The main function that judge which log or car to move
shift_cars_and_logs:
	la $t0, ($a0)
	li $t1, 1	
	beq $t1, $t0, log1
	addi $t1, $t1, 1
	beq $t1, $t0, log2
	addi $t1, $t1, 1
	beq $t1, $t0, log3
	addi $t1, $t1, 1
	beq $t1, $t0, log4
	addi $t1, $t1, 1
	beq $t1, $t0, car1
	addi $t1, $t1, 1
	beq $t1, $t0, car2
	addi $t1, $t1, 1
	beq $t1, $t0, car3
	addi $t1, $t1, 1
	beq $t1, $t0, car4
	
## All the cases below follow the same algorithm of log1, just write one explanation

log1: 	 
	la $t0, Position1_log 	# load address of the position of log 1
	lw $t1, log_and_car_Length	# load the width of a car or a log which is 8
	j log1_shift # jumo to the function

log1_shift: 
	mul $t1, $t1, 16  # Multiply by 16 in order to go through all the words of a log or a car	
	li $t2, 0	# accumulator to limit all the words of a car or log has done the move
		# Accumulator to shift all bits of the log
log1_control:	beq $t2, $t1, finish_log_loop1	# When all the words of a car or log are move finish the loop
	add $t3,$t0,$t2	# add the current word 
	lw $t3, ($t3)	# load the current word 
	subi $t4, $t3, 4	# shift left 4 bits 
	add $t3,$t0,$t2		# point to the correct address again
	sw $t4, ($t3)		# store the new value
	addi $t2, $t2, 4 # increment the accumulator to go through the next word
	beq $t4, 1020, shift_up_128 # if the first line of log hits the marginal, then shift up 128 bits
	beq $t4, 1148, shift_up_128 # if the second line of log hits the marginal, then shift up 128 bits
	beq $t4, 1276, shift_up_128 # if the third line of log hits the marginal, then shift up 128 bits
	beq $t4, 1404, shift_up_128 # if the fourth line of log hits the marginal, then shift up 128 bits
	j log1_control # Loop over
shift_up_128:
	addi $t4, $t4, 128	# shift up 128 bits
	sw $t4, ($t3)		# Store the new value
	
	j log1_control # jump back to the loop

finish_log_loop1: jr $ra


log2: 	 
	la $t0, Position2_log 	
	lw $t1, log_and_car_Length	
	j log2_shift

log2_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
		
log2_control:	beq $t2, $t1, finish_log_loop2	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	subi $t4, $t3, 4	
	add $t3,$t0,$t2		
	sw $t4, ($t3)		
	addi $t2, $t2, 4 
	beq $t4, 1020, shift_up_128_2
	beq $t4, 1148, shift_up_128_2
	beq $t4, 1276, shift_up_128_2
	beq $t4, 1404, shift_up_128_2
	j log2_control 
shift_up_128_2:
	addi $t4, $t4, 128	
	sw $t4, ($t3)		
	
	j log2_control

finish_log_loop2: jr $ra


log3: 	 
	la $t0, Position3_log 	
	lw $t1, log_and_car_Length	
	j log3_shift

log3_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
		
log3_control:	beq $t2, $t1, finish_log_loop3	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	addi $t4, $t3, 4	# Add 4 bits to shift right
	add $t3,$t0,$t2		
	sw $t4, ($t3)		
	addi $t2, $t2, 4 
	beq $t4, 1664, shift_up_128_3
	beq $t4, 1792, shift_up_128_3
	beq $t4, 1920, shift_up_128_3
	beq $t4, 2048, shift_up_128_3
	j log3_control 
shift_up_128_3:
	subi $t4, $t4, 128	
	sw $t4, ($t3)		
	
	j log3_control

finish_log_loop3: jr $ra



log4: 	 
	la $t0, Position4_log 	
	lw $t1, log_and_car_Length	
	j log4_shift

log4_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
log4_control:	beq $t2, $t1, finish_log_loop4	
	add $t3,$t0,$t2
	lw $t3, ($t3)	
	addi $t4, $t3, 4
	add $t3,$t0,$t2		
	sw $t4, ($t3)		
	addi $t2, $t2, 4 
	beq $t4, 1664, shift_up_128_4
	beq $t4, 1792, shift_up_128_4
	beq $t4, 1920, shift_up_128_4
	beq $t4, 2048, shift_up_128_4
	j log4_control 
shift_up_128_4:
	subi $t4, $t4, 128	
	sw $t4, ($t3)		
	
	j log4_control

finish_log_loop4: jr $ra


car1: 	 
	la $t0, Position1_car 	
	lw $t1, log_and_car_Length	
	j car1_shift

car1_shift:
	mul $t1, $t1, 16
	li $t2, 0
car1_control:	beq $t2, $t1, finish_car_loop1	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	subi $t4, $t3, 4	
	add $t3,$t0,$t2		
	sw $t4, ($t3)		
	addi $t2, $t2, 4 
	beq $t4, 2556, shift_up_128_5
	beq $t4, 2684, shift_up_128_5
	beq $t4, 2812, shift_up_128_5
	beq $t4, 2940, shift_up_128_5
	j car1_control 
shift_up_128_5:
	addi $t4, $t4, 128	
	sw $t4, ($t3)		
	
	j car1_control

finish_car_loop1: jr $ra

car2: 	 
	la $t0, Position2_car 	
	lw $t1, log_and_car_Length	
	j car2_shift
	
car2_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
car2_control:	beq $t2, $t1, finish_car_loop2	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	subi $t4, $t3, 4	
	add $t3,$t0,$t2		
	sw $t4, ($t3)		
	addi $t2, $t2, 4
	beq $t4, 2556, shift_up_128_6
	beq $t4, 2684, shift_up_128_6
	beq $t4, 2812, shift_up_128_6
	beq $t4, 2940, shift_up_128_6
	j car2_control 
shift_up_128_6:
	addi $t4, $t4, 128	
	sw $t4, ($t3)
	
	j car2_control

finish_car_loop2: jr $ra


car3: 	 
	la $t0, Position3_car 	
	lw $t1, log_and_car_Length	
	j car3_shift
	
car3_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
car3_control:	beq $t2, $t1, finish_car_loop3	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	addi $t4, $t3, 4	
	add $t3,$t0,$t2	
	sw $t4, ($t3)		
	addi $t2, $t2, 4
	beq $t4, 3200, shift_up_128_7
	beq $t4, 3328, shift_up_128_7
	beq $t4, 3456, shift_up_128_7
	beq $t4, 3584, shift_up_128_7
	j car3_control
shift_up_128_7:
	subi $t4, $t4, 128	
	sw $t4, ($t3)		
	
	j car3_control

finish_car_loop3: jr $ra


car4: 	 
	la $t0, Position4_car 	
	lw $t1, log_and_car_Length	
	j car4_shift
	
car4_shift: 
	mul $t1, $t1, 16
	li $t2, 0	
car4_control:	beq $t2, $t1, finish_car_loop4	
	add $t3,$t0,$t2	
	lw $t3, ($t3)	
	addi $t4, $t3, 4	
	add $t3,$t0,$t2	
	sw $t4, ($t3)		
	addi $t2, $t2, 4 
	beq $t4, 3200, shift_up_128_8
	beq $t4, 3328, shift_up_128_8
	beq $t4, 3456, shift_up_128_8
	beq $t4, 3584, shift_up_128_8
	j car4_control 
shift_up_128_8:
	subi $t4, $t4, 128	
	sw $t4, ($t3)	
	
	j car4_control

finish_car_loop4: jr $ra

Shift_objects:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $a0, 1 # make an argument to judge which log or car to do the shift
	li $t0, 9 # all the logs and cars are shifted when a0 reaches t0
loop_for_shift:	beq $a0, $t0, shift_end	# all the logs and cars are shifted when a0 reaches t0
	jal shift_cars_and_logs
	addi $a0, $a0, 1 # Shift the next log or car	
	li $t0, 9
	j loop_for_shift	
shift_end:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


## Algorithmn for collision
Load_all_data:

la $t0, Position1_car
la $t1, Position2_car
la $t2, Position3_car
la $t3, Position4_car
la $t4, Frog_position
lw $t5, 0($t4)
lw $t6, 4($t4)
lw $t9, log_and_car_Length
j made_accumulator

made_accumulator:
		li $t7, 0
		mul $t9, $t9, 16


loop_for_check_collision: ### detect if frog will face a collision
			beq $t9, $t7, finish_collision
			add $s0, $t0, $t7
			lw $s0, ($s0)
			add $s1, $t1, $t7
			lw $s1, ($s1)
			add $s2, $t2, $t7
			lw $s2, ($s2)
			add $s3, $t3, $t7
			lw $s3, ($s3)
			addi $t7, $t7, 4
			beq $s0, $t5, change_colour1
			beq $s0, $t6, change_colour1
			beq $s1, $t5, change_colour1
			beq $s1, $t6, change_colour1
			beq $s2, $t5, change_colour1
			beq $s2, $t6, change_colour1
			beq $s3, $t5, change_colour1
			beq $s3, $t6, change_colour1
			j loop_for_check_collision
			
			
#### Change frog's colour after its makes a collision which means it dies			
change_colour1: 
lw $s4, Frog_change_colour1
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 132
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 8
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
j collision_happen

#### Draw the frog at the initial position to restart the frog for playing
collision_happen:
		la $a1, Frog_initial_position
		lw $t8, 0($a1)
                sw $t8, 0($t4)
                lw $t8, 4($a1)
                sw $t8, 4($t4)	
                lw $t8, 8($a1)
                sw $t8, 8($t4)	
                lw $t8, 12($a1)
                sw $t8, 12($t4)
                lw $t8, 16($a1)
                sw $t8, 16($t4)
                lw $t8, 20($a1)
                sw $t8, 20($t4)
                lw $t8, 24($a1)
                sw $t8, 24($t4)
                lw $t8, 28($a1)
                sw $t8, 28($t4)
                lw $t8, 32($a1)
                sw $t8, 32($t4)
                lw $t8, 36($a1)
                sw $t8, 36($t4)
                lw $t8, 40($a1)
                sw $t8, 40($t4)
                lw $t8, 44($a1)
                sw $t8, 44($t4)
                la $s5, life   #### minus life at each time die
                lw $s6, ($s5)
        	subi $s6, $s6, 1
        	sw $s6, ($s5)
                j Show_current_score1
### Show the current score of the frog after it dies                
Show_current_score1:
	li $v0, 4
	la $a0, Message1
	syscall
	li $v0, 1
	lw $a1, Score1
	move $a0, $a1
	syscall

        j add_sound1
        j  finish_collision
#### Finish checking collision
 finish_collision:
 		jr $ra
                
		
## Algorithmn for place on log
Load_all_data2:

la $t0, Position1_log
la $t1, Position2_log
la $t2, Position3_log
la $t3, Position4_log
la $t4, Frog_position
lw $t5, 0($t4)
la $s7, water_road_region

made_accumulator2:
  li $s6, 0
  
  
#### check if the frog is moving at the water area
check_in_water_area:
beq $s6, 1024, finish_land_water
add $s4, $s7, $s6
lw $s4,($s4)
beq $t5, $s4, loop_for_check_land_water
add $s6, $s6, 4
j check_in_water_area


#### Check if the frog is on the log
loop_for_check_land_water:
   lw $t7, 0($t0)
   beq $t5, $t7,  on_log_shift1
   lw $t7, 4($t0)
   beq $t5, $t7, on_log_shift1
   lw $t7, 8($t0)
   beq $t5, $t7,  on_log_shift1
   lw $t7, 12($t0)
   beq $t5, $t7,  on_log_shift1
   lw $t7, 16($t0)
   beq $t5, $t7, on_log_shift1
   lw $s0, 0($t1)
   beq $t5, $s0, on_log_shift2
   lw $s0, 4($t1)
   beq $t5, $s0, on_log_shift2
   lw $s0, 8($t1)
   beq $t5, $s0, on_log_shift2
   lw $s0, 12($t1)
   beq $t5, $s0, on_log_shift2
   lw $s0, 16($t1)
   beq $t5, $s0, on_log_shift2
   lw $s1, 0($t2)
   beq $t5, $s1, on_log_shift3
   lw $s1, 4($t2)
   beq $t5, $s1, on_log_shift3
   lw $s1, 8($t2)
   beq $t5, $s1, on_log_shift3
   lw $s1, 12($t2)
   beq $t5, $s1, on_log_shift3
   lw $s1, 16($t2)
   beq $t5, $s1, on_log_shift3
   lw $s2, 0($t3)
   beq $t5, $s2, on_log_shift4
   lw $s2, 4($t3)
   beq $t5, $s2, on_log_shift4
   lw $s2, 8($t3)
   beq $t5, $s2, on_log_shift4
   lw $s2, 12($t3)
   beq $t5, $s2, on_log_shift4
   lw $s2, 16($t3)
   beq $t5, $s2, on_log_shift4
   j change_colour2
   
### All the on log function means to let the frog move with the log  
on_log_shift1:
	subi $t7, $t7, 4
	sw $t7, 0($t4)
	addi $t7, $t7, 12
	sw $t7, 4($t4)
	addi $t7, $t7, 116
	sw $t7, 8($t4)
	addi $t7, $t7, 4
	sw $t7, 12($t4)
	addi $t7, $t7, 4
	sw $t7, 16($t4)
	addi $t7, $t7, 4
	sw $t7, 20($t4)
	addi $t7, $t7, 120
	sw $t7, 24($t4)
	addi $t7, $t7, 4
	sw $t7, 28($t4)
	addi $t7, $t7, 120
	sw $t7, 32($t4)
	addi $t7, $t7, 4
	sw $t7, 36($t4)
	addi $t7, $t7, 4
	sw $t7, 40($t4)
	addi $t7, $t7, 4
	sw $t7, 44($t4)
	beq $t7, 1416, change_colour2
	jr $ra
	
	
   
on_log_shift2:
	subi $s0, $s0, 4
	sw $s0, 0($t4)
	addi $s0, $s0, 12
	sw $s0, 4($t4)
	addi $s0, $s0, 116
	sw $s0, 8($t4)
	addi $s0, $s0, 4
	sw $s0, 12($t4)
	addi $s0, $s0, 4
	sw $s0, 16($t4)
	addi $s0, $s0, 4
	sw $s0, 20($t4)
	addi $s0, $s0, 120
	sw $s0, 24($t4)
	addi $s0, $s0, 4
	sw $s0, 28($t4)
	addi $s0, $s0, 120
	sw $s0, 32($t4)
	addi $s0, $s0, 4
	sw $s0, 36($t4)
	addi $s0, $s0, 4
	sw $s0, 40($t4)
	addi $s0, $s0, 4
	sw $s0, 44($t4)
	beq $s0, 1416, change_colour2
	jr $ra
	
	
   
on_log_shift3:
	addi $s1, $s1, 4
	sw $s1, 0($t4)
	addi $s1, $s1, 12
	sw $s1, 4($t4)
	addi $s1, $s1, 116
	sw $s1, 8($t4)
	addi $s1, $s1, 4
	sw $s1, 12($t4)
	addi $s1, $s1, 4
	sw $s1, 16($t4)
	addi $s1, $s1, 4
	sw $s1, 20($t4)
	addi $s1, $s1, 120
	sw $s1, 24($t4)
	addi $s1, $s1, 4
	sw $s1, 28($t4)
	addi $s1, $s1, 120
	sw $s1, 32($t4)
	addi $s1, $s1, 4
	sw $s1, 36($t4)
	addi $s1, $s1, 4
	sw $s1, 40($t4)
	addi $s1, $s1, 4
	sw $s1, 44($t4)
	beq $s1, 2048, change_colour2
	jr $ra
   
on_log_shift4:
	addi $s2, $s2, 4
	sw $s2, 0($t4)
	addi $s2, $s2, 12
	sw $s2, 4($t4)
	addi $s2, $s2, 116
	sw $s2, 8($t4)
	addi $s2, $s2, 4
	sw $s2, 12($t4)
	addi $s2, $s2, 4
	sw $s2, 16($t4)
	addi $s2, $s2, 4
	sw $s2, 20($t4)
	addi $s2, $s2, 120
	sw $s2, 24($t4)
	addi $s2, $s2, 4
	sw $s2, 28($t4)
	addi $s2, $s2, 120
	sw $s2, 32($t4)
	addi $s2, $s2, 4
	sw $s2, 36($t4)
	addi $s2, $s2, 4
	sw $s2, 40($t4)
	addi $s2, $s2, 4
	sw $s2, 44($t4)
	beq $s2, 2048, change_colour2
	jr $ra



change_colour2:
lw $s4, Frog_change_colour1
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 8
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
j land_water_happen
   
   

#### Redraw the frog at the original place if frog dies  
land_water_happen:
  		la $a2, Frog_initial_position
  		lw $t8, 0($a2)
                sw $t8, 0($t4)
                lw $t8, 4($a2)
                sw $t8, 4($t4) 
                lw $t8, 8($a2)
                sw $t8, 8($t4) 
                lw $t8, 12($a2)
                sw $t8, 12($t4)
                lw $t8, 16($a2)
                sw $t8, 16($t4)
                lw $t8, 20($a2)
                sw $t8, 20($t4)
                lw $t8, 24($a2)
                sw $t8, 24($t4)
                lw $t8, 28($a2)
                sw $t8, 28($t4)
                lw $t8, 32($a2)
                sw $t8, 32($t4)
                lw $t8, 36($a2)
                sw $t8, 36($t4)
                lw $t8, 40($a2)
                sw $t8, 40($t4)
                lw $t8, 44($a2)
                sw $t8, 44($t4)
                la $s5, life    #### minus life at each time die
                lw $s6, ($s5)
        	subi $s6, $s6, 1
        	sw $s6, ($s5)
                j Show_current_score2

### show the score of the frog moving at the current state.
Show_current_score2:
	li $v0, 4
	la $a0, Message1
	syscall
	li $v0, 1
	lw $a1, Score1
	move $a0, $a1
	syscall
        j add_sound1
        j finish_land_water
 finish_land_water:
   jr $ra

## Algorithmn for reach the goal
Load_all_data3:
la $t4, Frog_position
lw $t5, 0($t4)
la $t1, goal_region
lw $t3, Frog
j made_accumulator3

made_accumulator3:
  li $s6, 0

### loop to check if the frog is in the goal area
check_in_goal_area:
beq $s6, 1024,  finish_goal_region
add $t2, $t1, $s6
lw $t2,($t2)
beq $t5, $t2, change_colour3
add $s6, $s6, 4
j check_in_goal_area



#### if the frog is moving at the goal are the frog will change colour represent once win. 
change_colour3:
lw $s4, Frog_change_colour1
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
subi $t5, $t5, 8
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
j Winner1

#### function to accumulate each time win
Winner1:
la $t6, count_for_win_time1
lw $t9, count_for_win_time1
addi $t9, $t9, 1
sw $t9, ($t6)

j initialize_original



### After winning, redraw the frog at the original place.
initialize_original:
  		la $a2, Frog_initial_position
  		lw $t8, 0($a2)
                sw $t8, 0($t4)
                lw $t8, 4($a2)
                sw $t8, 4($t4) 
                lw $t8, 8($a2)
                sw $t8, 8($t4) 
                lw $t8, 12($a2)
                sw $t8, 12($t4)
                lw $t8, 16($a2)
                sw $t8, 16($t4)
                lw $t8, 20($a2)
                sw $t8, 20($t4)
                lw $t8, 24($a2)
                sw $t8, 24($t4)
                lw $t8, 28($a2)
                sw $t8, 28($t4)
                lw $t8, 32($a2)
                sw $t8, 32($t4)
                lw $t8, 36($a2)
                sw $t8, 36($t4)
                lw $t8, 40($a2)
                sw $t8, 40($t4)
                lw $t8, 44($a2)
                sw $t8, 44($t4)
                j Show_current_score3

               
### Show the score of the frog after winning this game                                            
Show_current_score3:
	li $v0, 4
	la $a0, Message1
	syscall
	li $v0, 1
	lw $a1, Score1
	move $a0, $a1
	syscall

        j add_sound2
	j  finish_goal_region
		
 finish_goal_region:
 jr $ra
 
 ########################################## player 2 follow the same algorithm as player1 #######################################
 ## Algorithmn for collision
player2:

la $t0, Position1_car
la $t1, Position2_car
la $t2, Position3_car
la $t3, Position4_car
la $t4, Frog_position2
lw $t5, 0($t4)
lw $t6, 4($t4)
lw $t9, log_and_car_Length
j made_accumulator_player2

made_accumulator_player2:
		li $t7, 0
		mul $t9, $t9, 16


loop_for_check_collision_player2:
			beq $t9, $t7, finish_collision_player2
			add $s0, $t0, $t7
			lw $s0, ($s0)
			add $s1, $t1, $t7
			lw $s1, ($s1)
			add $s2, $t2, $t7
			lw $s2, ($s2)
			add $s3, $t3, $t7
			lw $s3, ($s3)
			addi $t7, $t7, 4
			beq $s0, $t5, change_colour1_player2
			beq $s0, $t6, change_colour1_player2
			beq $s1, $t5, change_colour1_player2
			beq $s1, $t6, change_colour1_player2
			beq $s2, $t5, change_colour1_player2
			beq $s2, $t6, change_colour1_player2
			beq $s3, $t5, change_colour1_player2
			beq $s3, $t6, change_colour1_player2
			j loop_for_check_collision_player2
			
			
change_colour1_player2:
lw $s4, Frog_change_colour2
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 124
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 132
sw $s4, ($t5)
subi $t5, $t5, 12
sw $s4, ($t5)
j collision_happen_player2


collision_happen_player2:
		la $a1, Frog_initial_position2
		lw $t8, 0($a1)
                sw $t8, 0($t4)
                lw $t8, 4($a1)
                sw $t8, 4($t4)	
                lw $t8, 8($a1)
                sw $t8, 8($t4)	
                lw $t8, 12($a1)
                sw $t8, 12($t4)
                lw $t8, 16($a1)
                sw $t8, 16($t4)
                lw $t8, 20($a1)
                sw $t8, 20($t4)
                lw $t8, 24($a1)
                sw $t8, 24($t4)
                lw $t8, 28($a1)
                sw $t8, 28($t4)
                lw $t8, 32($a1)
                sw $t8, 32($t4)
                lw $t8, 36($a1)
                sw $t8, 36($t4)
                lw $t8, 40($a1)
                sw $t8, 40($t4)
                lw $t8, 44($a1)
                sw $t8, 44($t4)
                la $s5, life2
                lw $s6, ($s5)
        	subi $s6, $s6, 1
        	sw $s6, ($s5)
                j Show_current_score1_player2
                
                
Show_current_score1_player2:
	li $v0, 4
	la $a0, Message2
	syscall
	li $v0, 1
	lw $a1, Score2
	move $a0, $a1
	syscall            
           
        j add_sound1
        j  finish_collision_player2

 finish_collision_player2:
 		jr $ra
                
		
## Algorithmn for place on log
Load_all_data2_player2:

la $t0, Position1_log
la $t1, Position2_log
la $t2, Position3_log
la $t3, Position4_log
la $t4, Frog_position2
lw $t5, 0($t4)
la $s7, water_road_region

made_accumulator2_player2:
  li $s6, 0
check_in_water_area_player2:
beq $s6, 1024, finish_land_water_player2
add $s4, $s7, $s6
lw $s4,($s4)
beq $t5, $s4, loop_for_check_land_water_player2
add $s6, $s6, 4
j check_in_water_area_player2



loop_for_check_land_water_player2:
   lw $t7, 0($t0)
   beq $t5, $t7,  on_log_shift1_player2
   lw $t7, 4($t0)
   beq $t5, $t7, on_log_shift1_player2
   lw $t7, 8($t0)
   beq $t5, $t7,  on_log_shift1_player2
   lw $t7, 12($t0)
   beq $t5, $t7,  on_log_shift1_player2
   lw $t7, 16($t0)
   beq $t5, $t7, on_log_shift1_player2
   lw $s0, 0($t1)
   beq $t5, $s0, on_log_shift2_player2
   lw $s0, 4($t1)
   beq $t5, $s0, on_log_shift2_player2
   lw $s0, 8($t1)
   beq $t5, $s0, on_log_shift2_player2
   lw $s0, 12($t1)
   beq $t5, $s0, on_log_shift2_player2
   lw $s0, 16($t1)
   beq $t5, $s0, on_log_shift2_player2
   lw $s1, 0($t2)
   beq $t5, $s1, on_log_shift3_player2
   lw $s1, 4($t2)
   beq $t5, $s1, on_log_shift3_player2
   lw $s1, 8($t2)
   beq $t5, $s1, on_log_shift3_player2
   lw $s1, 12($t2)
   beq $t5, $s1, on_log_shift3_player2
   lw $s1, 16($t2)
   beq $t5, $s1, on_log_shift3_player2
   lw $s2, 0($t3)
   beq $t5, $s2, on_log_shift4_player2
   lw $s2, 4($t3)
   beq $t5, $s2, on_log_shift4_player2
   lw $s2, 8($t3)
   beq $t5, $s2, on_log_shift4_player2
   lw $s2, 12($t3)
   beq $t5, $s2, on_log_shift4_player2
   lw $s2, 16($t3)
   beq $t5, $s2, on_log_shift4_player2
   j change_colour2_player2
   
   
on_log_shift1_player2:
	subi $t7, $t7, 4
	sw $t7, 0($t4)
	addi $t7, $t7, 12
	sw $t7, 4($t4)
	addi $t7, $t7, 116
	sw $t7, 8($t4)
	addi $t7, $t7, 4
	sw $t7, 12($t4)
	addi $t7, $t7, 4
	sw $t7, 16($t4)
	addi $t7, $t7, 4
	sw $t7, 20($t4)
	addi $t7, $t7, 120
	sw $t7, 24($t4)
	addi $t7, $t7, 4
	sw $t7, 28($t4)
	addi $t7, $t7, 120
	sw $t7, 32($t4)
	addi $t7, $t7, 4
	sw $t7, 36($t4)
	addi $t7, $t7, 4
	sw $t7, 40($t4)
	addi $t7, $t7, 4
	sw $t7, 44($t4)
	beq $t7, 1416, change_colour2_player2
	jr $ra
	
	
   
on_log_shift2_player2:
	subi $s0, $s0, 4
	sw $s0, 0($t4)
	addi $s0, $s0, 12
	sw $s0, 4($t4)
	addi $s0, $s0, 116
	sw $s0, 8($t4)
	addi $s0, $s0, 4
	sw $s0, 12($t4)
	addi $s0, $s0, 4
	sw $s0, 16($t4)
	addi $s0, $s0, 4
	sw $s0, 20($t4)
	addi $s0, $s0, 120
	sw $s0, 24($t4)
	addi $s0, $s0, 4
	sw $s0, 28($t4)
	addi $s0, $s0, 120
	sw $s0, 32($t4)
	addi $s0, $s0, 4
	sw $s0, 36($t4)
	addi $s0, $s0, 4
	sw $s0, 40($t4)
	addi $s0, $s0, 4
	sw $s0, 44($t4)
	beq $s0, 1416, change_colour2_player2
	jr $ra
	
	
   
on_log_shift3_player2:
	addi $s1, $s1, 4
	sw $s1, 0($t4)
	addi $s1, $s1, 12
	sw $s1, 4($t4)
	addi $s1, $s1, 116
	sw $s1, 8($t4)
	addi $s1, $s1, 4
	sw $s1, 12($t4)
	addi $s1, $s1, 4
	sw $s1, 16($t4)
	addi $s1, $s1, 4
	sw $s1, 20($t4)
	addi $s1, $s1, 120
	sw $s1, 24($t4)
	addi $s1, $s1, 4
	sw $s1, 28($t4)
	addi $s1, $s1, 120
	sw $s1, 32($t4)
	addi $s1, $s1, 4
	sw $s1, 36($t4)
	addi $s1, $s1, 4
	sw $s1, 40($t4)
	addi $s1, $s1, 4
	sw $s1, 44($t4)
	beq $s1, 2048, change_colour2_player2
	jr $ra
   
on_log_shift4_player2:
	addi $s2, $s2, 4
	sw $s2, 0($t4)
	addi $s2, $s2, 12
	sw $s2, 4($t4)
	addi $s2, $s2, 116
	sw $s2, 8($t4)
	addi $s2, $s2, 4
	sw $s2, 12($t4)
	addi $s2, $s2, 4
	sw $s2, 16($t4)
	addi $s2, $s2, 4
	sw $s2, 20($t4)
	addi $s2, $s2, 120
	sw $s2, 24($t4)
	addi $s2, $s2, 4
	sw $s2, 28($t4)
	addi $s2, $s2, 120
	sw $s2, 32($t4)
	addi $s2, $s2, 4
	sw $s2, 36($t4)
	addi $s2, $s2, 4
	sw $s2, 40($t4)
	addi $s2, $s2, 4
	sw $s2, 44($t4)
	beq $s2, 2048, change_colour2_player2
	jr $ra


change_colour2_player2:
lw $s4, Frog_change_colour2
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 124
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 132
sw $s4, ($t5)
subi $t5, $t5, 12
sw $s4, ($t5)
j land_water_happen_player2
   
   

   
land_water_happen_player2:
  		la $a2, Frog_initial_position2
  		lw $t8, 0($a2)
                sw $t8, 0($t4)
                lw $t8, 4($a2)
                sw $t8, 4($t4) 
                lw $t8, 8($a2)
                sw $t8, 8($t4) 
                lw $t8, 12($a2)
                sw $t8, 12($t4)
                lw $t8, 16($a2)
                sw $t8, 16($t4)
                lw $t8, 20($a2)
                sw $t8, 20($t4)
                lw $t8, 24($a2)
                sw $t8, 24($t4)
                lw $t8, 28($a2)
                sw $t8, 28($t4)
                lw $t8, 32($a2)
                sw $t8, 32($t4)
                lw $t8, 36($a2)
                sw $t8, 36($t4)
                lw $t8, 40($a2)
                sw $t8, 40($t4)
                lw $t8, 44($a2)
                sw $t8, 44($t4)
                la $s5, life2
                lw $s6, ($s5)
        	subi $s6, $s6, 1
        	sw $s6, ($s5)
                j Show_current_score2_player2
                
                
                
Show_current_score2_player2:
	li $v0, 4
	la $a0, Message2
	syscall
	li $v0, 1
	lw $a1, Score2
	move $a0, $a1
	syscall            
            
            
        j add_sound1
        j finish_land_water_player2
 finish_land_water_player2:
   jr $ra

## Algorithmn for reach the goal
Load_all_data3_player2:
la $t4, Frog_position2
lw $t5, 0($t4)
la $t1, goal_region
j made_accumulator3_player2

made_accumulator3_player2:
  li $s6, 0


check_in_goal_area_player2:
beq $s6, 1024,  finish_goal_region_player2
add $t2, $t1, $s6
lw $t2,($t2)
beq $t5, $t2, change_colour3_player2
add $s6, $s6, 4
j check_in_goal_area_player2

change_colour3_player2:
lw $s4, Frog_change_colour2
lw $s5, displayAddress
add $t5, $t5, $s5
sw $s4, ($t5)
addi $t5, $t5, 12
sw $s4, ($t5)
addi $t5, $t5, 124
sw $s4, ($t5)
subi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 128
sw $s4, ($t5)
addi $t5, $t5, 4
sw $s4, ($t5)
addi $t5, $t5, 132
sw $s4, ($t5)
subi $t5, $t5, 12
sw $s4, ($t5)
j Winner2

Winner2:
la $t6, count_for_win_time2
lw $t9, count_for_win_time2
addi $t9, $t9, 1
sw $t9, ($t6)

j initialize_original_player2




initialize_original_player2:
  		la $a2, Frog_initial_position2
  		lw $t8, 0($a2)
                sw $t8, 0($t4)
                lw $t8, 4($a2)
                sw $t8, 4($t4) 
                lw $t8, 8($a2)
                sw $t8, 8($t4) 
                lw $t8, 12($a2)
                sw $t8, 12($t4)
                lw $t8, 16($a2)
                sw $t8, 16($t4)
                lw $t8, 20($a2)
                sw $t8, 20($t4)
                lw $t8, 24($a2)
                sw $t8, 24($t4)
                lw $t8, 28($a2)
                sw $t8, 28($t4)
                lw $t8, 32($a2)
                sw $t8, 32($t4)
                lw $t8, 36($a2)
                sw $t8, 36($t4)
                lw $t8, 40($a2)
                sw $t8, 40($t4)
                lw $t8, 44($a2)
                sw $t8, 44($t4)
                j Show_current_score3_player2
                
Show_current_score3_player2:
	li $v0, 4
	la $a0, Message2
	syscall
	li $v0, 1
	lw $a1, Score2
	move $a0, $a1
	syscall 
	
	
        j add_sound2
	j  finish_goal_region_player2
		
 finish_goal_region_player2:
 jr $ra


##### State what you did for your game, whether you win or game over
Place_game_situation:
    	lw $t0, displayAddress # $t0 stores the base address for display
    	li $t9, 0
    	lw $s3, Frog
    	lw $s2, Frog2
    	color_background_white:
        bgt $t9, 4092, add_game_over
        sw $s2, 0($t0)
        addi $t0, $t0, 4
        addi $t9, $t9, 4
        j color_background_white
# draw each letter of GAME OVER one line by one line       
add_game_over: 
	lw $t1, displayAddress      
    	addi $s4, $t1, 2080
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 52
	sw $s3, 0($s4)
	addi $s4, $s4, 20
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 64
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 56
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 68
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 184
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 56
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 20
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 52
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 52
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	addi $s4, $s4, 20
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 60
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 20
	sw $s3, 0($s4)
	addi $s4, $s4, 16
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 4
	sw $s3, 0($s4)
	addi $s4, $s4, 8
	sw $s3, 0($s4)
	addi $s4, $s4, 12
	sw $s3, 0($s4)
	
	
	li $v0, 31
	la $a0, 30
	la $a1, 2000
	la $a2, 40
	la $a3, 100
	syscall	
	
    	j reset
### When you win this game you wiil see the screen to show you whether restart or not


#### This follow the same algorithmn as the previous one
    Place_game_situation2:
    	lw $t0, displayAddress # $t0 stores the base address for display
    	li $t9, 0
    	lw $t5, GoalColor
    	lw $t6, Frog2
    	lw $t7, Middle_lane_Color
    	color_background_white2:
        bgt $t9, 4092, add_restart
        sw $t6, 0($t0)
        addi $t0, $t0, 4
        addi $t9, $t9, 4
        j color_background_white2
    add_restart:  #### Draw restart Letter by Letter for Yes and No
	lw $t2, displayAddress      
    	addi $t8, $t2, 1040
	sw $t5, 0($t8)
	addi $t8, $t8, 16
	sw $t5, 0($t8)
	addi $t8, $t8, 124
	sw $t5, 0($t8)
	subi $t8, $t8, 8
	sw $t5, 0($t8)
	addi $t8, $t8, 132
	sw $t5, 0($t8)
	addi $t8, $t8, 128
	sw $t5, 0($t8)
	addi $t8, $t8, 128
	sw $t5, 0($t8)
	addi $t8, $t8, 128
	sw $t5, 0($t8)
	addi $t8, $t8, 12
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	subi $t8, $t8, 140
	sw $t5, 0($t8)
	subi $t8, $t8, 128
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	subi $t8, $t8, 136
	sw $t5, 0($t8)
	subi $t8, $t8, 128
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 524
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	subi $t8, $t8, 128
	sw $t5, 0($t8)
	subi $t8, $t8, 132
	sw $t5, 0($t8)
	subi $t8, $t8, 132
	sw $t5, 0($t8)
	subi $t8, $t8, 132
	sw $t5, 0($t8)
	subi $t8, $t8, 128
	sw $t5, 0($t8)
	subi $t8, $t8, 124
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 4
	sw $t5, 0($t8)
	addi $t8, $t8, 1172
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 124
	sw $t7, 0($t8)
	subi $t8, $t8, 4
	sw $t7, 0($t8)
	subi $t8, $t8, 132
	sw $t7, 0($t8)
	subi $t8, $t8, 128
	sw $t7, 0($t8)
	subi $t8, $t8, 128
	sw $t7, 0($t8)
	subi $t8, $t8, 128
	sw $t7, 0($t8)
	subi $t8, $t8, 124
	sw $t7, 0($t8)
	addi $t8, $t8, 4
	sw $t7, 0($t8)
	subi $t8, $t8, 36
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	subi $t8, $t8, 132
	sw $t7, 0($t8)
	subi $t8, $t8, 132
	sw $t7, 0($t8)
	subi $t8, $t8, 132
	sw $t7, 0($t8)
	subi $t8, $t8, 132
	sw $t7, 0($t8)
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	sw $t7, 0($t8)
	addi $t8, $t8, 128
	
	
	#Add different sound
	li $v0, 31
	la $a0, 50
	la $a1, 2000
	la $a2, 4
	la $a3, 100
	syscall	
	
    	j reset
    #### Reset button r   
    reset:
    	lw $t8, 0xffff0000
	beq $t8, 1, reset_button_r
        j reset 

        reset_button_r:
        lw $t0, 0xffff0004
        beq $t0, 114, renew_life_win
        j reset
	#### Renew the life and win accumulator
        renew_life_win:
            la $t1, life
            la $t9, life2
            li $t2, 3
            li $t8, 3
            sw $t2, ($t1)
            sw $t8, ($t9)

            la $t3, count_for_win_time1
            la $t4, count_for_win_time2
            li $t5, 0
            li $t6, 0
            sw $t5, ($t3)
            sw $t6, ($t4)
            j sleep

### main loop function
sleep:
jal Background_draw # jump and link Backgroud_draw
jal Shift_objects # jump and link Shift_objects
jal place_frog     # jump and link place_frog
jal Load_all_data
jal Load_all_data2
jal Load_all_data3
jal player2
jal Load_all_data2_player2
jal Load_all_data3_player2
la $t1, life
la $t2, life2
lw $s1, count_for_win_time1
lw $s2, count_for_win_time2
lw $t3, ($t1)
lw $t4, ($t2)
ble $t3, 0, Place_game_situation
beq $s1, 3, Place_game_situation2
ble $t4, 0, Place_game_situation
beq $s2, 3, Place_game_situation2


li $v0, 32
la $a0, 300 # sleep action
syscall
j Key_board

#### Different sound for different action

add_sound: ### move sound
li $v0, 31
la $a0, 70
la $a1, 1000
la $a2, 7
la $a3, 60
syscall
j sleep



add_sound1: ### collision sound
li $v0, 31
la $a0, 50
la $a1, 1000
la $a2, 16
la $a3, 60
syscall
j sleep


add_sound2:  ### goal sound
li $v0, 31
la $a0, 30
la $a1, 1000
la $a2, 24
la $a3, 100
syscall
j sleep
	

	
			
Exit:
 	li $v0, 10 # Exit the program
 	syscall
