SleepTime := 2

DaysPassed(){
	Jul15_2019 = 20190715 ; July 15 2019 in yyyyMMdd
	FormatTime, CurrentDate,, yyyyMMdd
	Days := CurrentDate

	; Find the difference between Jul 15 2019
	; and today's date.

	EnvSub, Days, %Jul15_2019%, days

	Weeks := Days // 7
	; Find number of days occupied by weekends.
	WeekendDaysOccured := (Weeks - 1)  * 2

	WorkDays := Days - WeekendDaysOccured

	return WorkDays
}


MoveToCurrentDate(){
	DaysPassed := DaysPassed()
	WeeksPassed := DaysPassed // 5

	Send, {Home}

	Loop 17 {
		Sleep % SleepTime
		Send, {Right}
	}

	Iter := WeeksPassed * 32
	EnvAdd Iter, Mod(DaysPassed, 5)
	if (WeeksPassed > 4) {
		Iter -= 5
	}

	Loop %Iter% {
		Sleep % SleepTime
		Send, {Right}
	}

	Sleep % SleepTime

}

^+v:: ; Use for AM
	InputBox, input, Enter AM Time, Enter AM Time, , 360, 360
	MoveToCurrentDate()
	Send % input
	Sleep % SleepTime
	Send, {Right}
	Sleep % SleepTime
	Send, 08:30
	Send, {Left}
	return

^+c:: ; Use for PM
	InputBox, input, Enter PM Time, Enter PM Time, , 15, 15
	MoveToCurrentDate()
	Send, 12:30
	Sleep % SleepTime
	Send, {Left}
	return