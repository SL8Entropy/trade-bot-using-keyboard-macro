InputBox, betamnt,input base bet, please input the base amount of money you want to bet. ideally 1 percent of the value you have.
InputBox, timeamnt,input session length, please input the amount of time you want the trading bot to run for in seconds. please input a multiple of 5

global Money := betamnt

global tradepercycle := 2
global tradeTime:=5000
global sessionLength:=timeamnt/5
;Msgbox % sessionLength

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
		found:=0
		xChange := 638
		while(found = 0)
		{	

			PixelGetColor, colorVar, xChange, 708

		

			if(colorVar = "0x3553F4" and this.firstTime = 1)
			{	
				found:=1
				;Msgbox this is red
				this.errorCount := this.errorCount + 1
			}
			else
			{	
				found :=1
				;Msgbox this is green
				this.errorCount := 0
			}

			this.firstTime:=1
			xChange := xChange - 1
			;Msgbox % xChange
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
		if(Instance.errorCount >= 9){
			Msgbox we lost 9 times in a row :(
			Msgbox boy, you were really unlucky.
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