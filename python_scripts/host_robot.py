# python_scripts/host_robot.py
import sys
import time


# robot = gpiozero.Robot(left=(17,18), right=(27,22))


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
    line = line.split(",")
    cmd = line[0]
    mag = int(line[1]) * .1

    if cmd  == "L":
        result = "Left" + ":" + str(mag)

    if cmd == "R":
        result = "Right" + ":" + str(mag)

    if cmd == "F":
        result = "Forward" + ":" + str(mag)

    if cmd == "B":
        result = "Backward" + ":" + str(mag)

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


