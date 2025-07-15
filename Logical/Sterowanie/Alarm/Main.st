
PROGRAM _INIT
	(* MpLink przekazujemy przez referencjê ADR *)
	MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable := TRUE);
END_PROGRAM

PROGRAM _CYCLIC
	(* Mo¿na wywo³aæ funkcjê bez parametrów *)
	IF gZb1_poziom > 8000.0 THEN
		MpAlarmXSet(gAlarmXCore, 'LvLTank1IsTooHigh');
	END_IF;
	(* Nie podajemy MpLink do Set przez referencjê *)
	
	IF gZb1_poziom < 8000.0 THEN
		MpAlarmXReset(gAlarmXCore, 'LvLTank1IsTooHigh');
	END_IF;
	
	IF gZb2_poziom > 8000.0 THEN
		MpAlarmXSet(gAlarmXCore, 'LvLTank2IsTooHigh');
	END_IF;
	
	IF gZb2_poziom < 8000.0 THEN
		MpAlarmXReset(gAlarmXCore, 'LvLTank2IsTooHigh');
	END_IF;
	//Pressure 1
	IF PressureTank1 > 4.0 THEN
		MpAlarmXSet(gAlarmXCore, 'PressureTank1TooHigh');
	END_IF;
	
	IF PressureTank1 < 4.0 THEN
		MpAlarmXReset(gAlarmXCore, 'PressureTank1TooHigh');
	END_IF;
	
	IF PressureTank1 > 2.0 THEN
		MpAlarmXReset(gAlarmXCore, 'PressureTank1TooLow');
	END_IF;
	
	IF PressureTank1 < 2.0 THEN
		MpAlarmXSet(gAlarmXCore, 'PressureTank1TooLow');
	END_IF;
	
	//Pressure 2
	IF PressureTank2 > 4.0 THEN
		MpAlarmXSet(gAlarmXCore, 'PressureTank2TooHigh');
	END_IF;
	
	IF PressureTank2 < 4.0 THEN
		MpAlarmXReset(gAlarmXCore, 'PressureTank2TooHigh');
	END_IF;
	
	IF PressureTank2 > 2.0 THEN
		MpAlarmXReset(gAlarmXCore, 'PressureTank2TooLow');
	END_IF;
	
	IF PressureTank2 < 2.0 THEN
		MpAlarmXSet(gAlarmXCore, 'PressureTank2TooLow');
	END_IF;
	
	MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable := TRUE);
END_PROGRAM

PROGRAM _EXIT
	(* W sekcji exit trzeba wywo³aæ/wy³aczyæ blok funkcyjny (Enable := FALSE) *)
	MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable := FALSE);
END_PROGRAM