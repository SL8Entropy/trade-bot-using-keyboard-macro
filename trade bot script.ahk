global Money := 1000
global Percent := 10
;time should be 2 minutes for the order.

Class Instance{
	__New(direction)
    	{
		this.errorCount :=1
		this.color := "blue"
		this.direction := direction
	}
	getColor()
	{
		Msgbox get color activated
		PixelGetColor, colorVar, 530, 578, rgb
		MsgBox % colorVar
		;if red>blue, the this.colour = red. else this.colour = green.
		if(colorVar = 1BA261)
		{
			this.color := "green"
		}
		else
		{
			this.color := "red"
		}
		if (this.color = "green" or this.color = "blue")
		{
			this.errorCount := 1
		}
		if(this.color = "red")
		{
			this.errorCount := this.errorCount + 1
		}		
	}	


	bet()
	{
		Var := Money * Percent * this.errorCount / 100
		Msgbox % Var
		Msgbox bet placed
		;go to price part of screen and enter errorCount*money*percent/100
		;if this.direction = up, go to screen and choose up then change this.directyion to "down"
		;if this.direction = down, go to screen and choose down then change this.direction to "up"
	}

    
}


array := []
array.Push(new Instance("up"))
array.Push(new Instance("down"))

F1::

Msgbox % array.MaxIndex()
loop{
	for each, Instance in array
		{
		Msgbox % Instance.direction
		Instance.getColor()
		Instance.bet()
		;or whatever the equivalent for 36 seconds is
		sleep 3000
		}
}
return

F2::
ExitApp
return