# python_scripts/move_robot.py
import gpiozero
import sys
import time


robot = gpiozero.Robot(left=(17,18), right=(27,22))


for line in sys.stdin:
    
    # expecting line in for of "num,num\n"
    line = line.strip()
    # EOF
    if line == "": break
    
    # strings to ints, and sum
    # values = line.split(",")
    # nums = map(int, values)
    # result = sum(nums)
    
    result = "Bad command"

    if line[0] == "L":
        robot.left()
        time.sleep(0.25)
        robot.stop()
        result = "Left"

    if line[0] == "R":
        robot.right()
        time.sleep(0.25)
	robot.stop()
        result = "Right"

    if line[0] == "F":
        robot.forward()
        time.sleep(0.25)
	robot.stop()
        result = "Forward"

    if line[0] == "B":
        robot.backward()
        time.sleep(0.25)
	robot.stop()
        result = "Backward"

# 	if (buttons & cwiid.BTN_RIGHT):
# 		robot.right()
# 	if (buttons & cwiid.BTN_UP):
# 		robot.forward()
# 	if (buttons & cwiid.BTN_DOWN):
# 		robot.backward()
# 	if (buttons & cwiid.BTN_B):
# 		robot.stop()
#
# time.sleep(0.25)

    # send the result via stdout
    # sys.stdout.write(str(result) + "\n")
    sys.stdout.write(result + "\n")
    sys.stdout.flush()


