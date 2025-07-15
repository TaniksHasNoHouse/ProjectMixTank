
PROGRAM _INIT
	gZb1_poziom;
	gZb1_zawor;
	gZb2_poziom;
	gZb2_zawor;
	
	gZb3_poziom;
	gZb3_zawor_glowny;
	gZb3_zawor_lewy;
	gZb3_zawor_prawy;
	
	gMieszadlo;
	StartButton := FALSE;
	MixButton := FALSE;
	
	AnalogValve.ValveRight := 50;
	AnalogValve.ValveLeft := 50;
END_PROGRAM

PROGRAM _CYCLIC
	IF StopButton THEN
		StartButton := FALSE;
		Control.Step := STEP_STOP;
		StopButton := FALSE;
	END_IF;
	
	IF ToggleMode THEN
		Mode := 'Manual';
	ELSE
		Mode := 'Auto';
	END_IF;
	
	IF ToggleMode THEN
	  Control.Step := STEP_MANUAL;
	END_IF;
	
	CASE Control.Step OF
		STEP_STOP:
			State := 'Stop';
			gZb1_zawor := FALSE;
			gZb2_zawor := FALSE;
			gZb3_zawor_prawy := FALSE;
			gZb3_zawor_lewy := FALSE;
			gZb3_zawor_glowny := FALSE;
			IF StartButton THEN
				Control.Step := STEP_FILL12;
			END_IF;

		STEP_FILL12:
			State := 'Napelnianie 1/2';
			StartButton := FALSE;
			gZb1_zawor := TRUE;
			gZb2_zawor := TRUE;
			IF gZb1_poziom >=8000 AND gZb2_poziom >= 8000 THEN
				Control.Step := STEP_EMPTY12;
			END_IF;

		STEP_EMPTY12:
			State := 'Oproznianie 1/2';
			gZb1_zawor := FALSE;
			gZb2_zawor := FALSE;
			Control.Step := STEP_FILL3;

		STEP_FILL3:
			State := 'Napelnianie 3';
			gZb3_zawor_prawy := AnalogValve.ValveRight;
			gZb3_zawor_lewy := AnalogValve.ValveLeft;
			IF gZb3_poziom >=8000 AND gMieszadlo = FALSE THEN
				gZb3_zawor_prawy := FALSE;
				gZb3_zawor_lewy := FALSE;
				Control.Step := STEP_EMPTY3;
			END_IF;
			IF gZb3_poziom = 10000 AND gMieszadlo = TRUE THEN
				gZb3_zawor_prawy := FALSE;
				gZb3_zawor_lewy := FALSE;
				Control.Step := STEP_MIX;
			END_IF;
			
		STEP_MIX:
			State := 'Mieszanie';
			TimerMix.PT := T#5s;
			TimerMix.IN := TRUE;
			gMieszadlo := TRUE;
			IF TimerMix.Q = TRUE THEN
				TimerMix.IN := FALSE;
				gMieszadlo := FALSE;
				Control.Step := STEP_EMPTY3;
			END_IF;

		STEP_EMPTY3:
			State := 'Oproznianie 3';
			gZb3_zawor_glowny := TRUE;
			IF gZb3_poziom = 0 THEN
				Control.Step := STEP_STOP;
			END_IF;
		
		STEP_MANUAL:
			State := 'Tryb manualny';
			gZb1_zawor := Manual.ZB1;
			gZb2_zawor := Manual.ZB2;
			gZb3_zawor_glowny := Manual.ZBMain;
			gMieszadlo := Manual.ZBMix;
			IF Manual.ZB3_right THEN
				IF gZb3_poziom >= 9500.0 THEN
					Manual.ZB3_right := FALSE;
				ELSE
					gZb3_zawor_prawy := AnalogValve.ValveRight;
				END_IF;
			ELSE
				gZb3_zawor_prawy := FALSE;
			END_IF;
			
			IF Manual.ZB3_left THEN
				IF gZb3_poziom >= 9500.0 THEN
					Manual.ZB3_left := FALSE;
				ELSE
					gZb3_zawor_lewy := AnalogValve.ValveLeft;
				END_IF;
			ELSE
				gZb3_zawor_lewy := FALSE;
			END_IF;
			
			IF gZb1_poziom >= 9500.0 THEN
				Manual.ZB1 := FALSE;
			END_IF;
			
			IF gZb2_poziom >= 9500.0 THEN
				Manual.ZB2 := FALSE;
			END_IF;
			
			IF ToggleMode = FALSE THEN
				Control.Step := STEP_STOP;
			END_IF;
		
	END_CASE;
	
	Tank.zb1 := INT_TO_USINT((gZb1_poziom * 100) / Full);
	Tank.zb2 := INT_TO_USINT((gZb2_poziom * 100) / Full);
	Tank.zb3 := INT_TO_USINT((gZb3_poziom * 100) / Full);
	
	TimerMix();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

