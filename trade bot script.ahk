﻿InputBox, betamnt,, please input the base amount of money you want to bet. please input a multiple of 100.


global Money := betamnt
;time should be 10 seconds
Class Instance
{
	__New(direction)
    	{
		this.errorCount :=0
		this.color := "blue"
		this.direction := direction
	}
	getColor()
	{
		;here is the problem. unable to properly recognise if a profit or a loss has just happened

		PixelGetColor, colorVar, 638, 708
		if(colorVar = "0x679F1D")
		{	
			;Msgbox this is green
			this.errorCount := 0
		}
		else if(colorVar = "0x3553F4")
		{	
			;Msgbox this is red
			this.errorCount := this.errorCount + 1
		}
		else
		{
			Msgbox problem
			ExitApp
		}
	}	


	bet()
	{
		modifier := 2**this.errorcount
		;Msgbox % modifier
		Var := Money * modifier
		MouseClick, left, 1793, 260
		MouseClick,left,1793,260
		Send {BS}{BS}{BS}{BS}
		Send % Var
		if (this.direction = "up"){
			MouseClick, left, 1745,564
		}
		else{
			MouseClick, left,1757,670
		}
		
		if(this.direction = "up")
		{
			this.direction := "down"
		}
		else
		{
			this.direction := "up"
		}
	}

}


array := []
array.Push(new Instance("up"))

F1::

loop{
	for each, Instance in array
	{
		Instance.getColor()
		Instance.bet()
		;or whatever the equivalent for 36 seconds is
		if(Instance.errorCount >= 5){
			Msgbox we lost 5 times in a row :(
			ExitApp
		}
	}
sleep 6500
}
return

F2::
ExitApp
return