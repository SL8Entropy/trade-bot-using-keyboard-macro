﻿;InputBox, betamnt,, please input the base amount of money you want to bet. please input a multiple of 10.


global Money := 10

global tradepercycle := 2
global tradeTime:=5000
global sessionLength:=100


;time should be 10 seconds
Class Instance
{
	__New(direction)
    	{
		this.errorCount :=0
		this.color := "blue"
		this.direction := direction
		this.firstTime:=0
	}
	getColor()
	{

		PixelGetColor, colorVar, 638, 708
		if(colorVar = "0x679F1D" or colorVar = "0x171411"or this.firstTime =0)
		{	
			found :=1
			;Msgbox this is green
			this.errorCount := 0
		}
		else if(colorVar = "0x3553F4")
		{	
			found:=1
			;Msgbox this is red
			this.errorCount := this.errorCount + 1
			
		}
		else
		{
			Msgbox error, couldnt read trade history
			ExitApp
		}
		this.firstTime:=1
	
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
loop, % tradepercycle
{
	Value := Mod(A_Index, 2)
	if(Value = 0){
		array.Push(new Instance("up"))
	}
	else{
		array.Push(new Instance("down"))
	}
}
F1::

loop
{
	alpha := A_Index
	for each, Instance in array
	{
		Instance.getColor()
		if(alpha < sessionLength or Instance.errorCount != 0)
		{

			Instance.bet()
		}
		else
		{
			array.RemoveAt(A_Index)
		}
		if(Instance.errorCount >= 7){
			Msgbox we lost 7 times in a row :(
			ExitApp
		}
		slpamnt := (tradeTime/tradepercycle)+500
		sleep % slpamnt
	}
}
return

F2::
ExitApp
return