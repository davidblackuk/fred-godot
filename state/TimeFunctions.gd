class_name TimeFunctions

#
# return the time in millisecs in the for of h:mm:ss,
#
func msec_to_hours_minutes_seconds(msecs):
	var totalSecs = (msecs / 1000)
	var minutes = (totalSecs / 60) % 60
	var hours = totalSecs / (60*60)
	var format = "%d:%02d:%02d"
	return format % [hours, minutes, totalSecs % 60]

#
# return a time in minutes and seconds m:ss where minutes can be > 60
#
func msec_to_minutes_seconds(msecs):
	var totalSecs = (msecs / 1000)
	var minutes = (totalSecs / 60) 
	var format = "%d:%02d"
	return format % [minutes, totalSecs % 60]
