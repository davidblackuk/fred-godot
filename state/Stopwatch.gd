#
# Very simple stopwatch class with approximate millisecond prescision
# depending on OS support
#
class_name StopWatch

var start_msec
var pause_msec
var paused = false
var last_formatted_value = "0:00:00"

#
# Reset the stopwatch to zero and start it running
#
func reset():
	paused = false
	start_msec = OS.get_ticks_msec()
	pause_msec = 0
	last_formatted_value = "0:00:00"

#
# Pause the stopwatch
#
func pause():
	pause_msec = OS.get_ticks_msec()
	paused = true

#
# continue / unpause the soptwatch
#
func continue():
	if (paused && start_msec):
		start_msec += (OS.get_ticks_msec() - pause_msec)
	paused = false
	pause_msec = 0

func ellapsed_msec():
	var ticks = OS.get_ticks_msec()
	var pms = (ticks - pause_msec if paused  else 0)
	var res = (ticks - pms) - start_msec 
	return res
#
# return the current value of the stopwatch in the for of h:mm:ss,
# if as_string() is called before reset, we return a default value of 0:00:00
#
func as_string():
	if (start_msec):
		var totalSecs = (ellapsed_msec() / 1000)
		var minutes = (totalSecs / 60) % 60
		var hours = totalSecs / (60*60)
		var format = "%d:%02d:%02d"
		last_formatted_value = format % [hours, minutes, totalSecs % 60]
	return last_formatted_value
