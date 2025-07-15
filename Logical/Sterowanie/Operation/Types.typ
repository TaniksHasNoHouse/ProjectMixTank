
TYPE
	StepEnum : 
		(
		STEP_STOP,
		STEP_FILL12,
		STEP_EMPTY12,
		STEP_FILL3,
		STEP_EMPTY3,
		STEP_MIX,
		STEP_MANUAL
		);
	ControlType : 	STRUCT 
		Step : StepEnum;
	END_STRUCT;
	TankLvl : 	STRUCT 
		zb1 : USINT;
		zb2 : USINT;
		zb3 : USINT;
	END_STRUCT;
	AnalogValue : 	STRUCT 
		ValveRight : USINT;
		ValveLeft : USINT;
	END_STRUCT;
	CurrentTask : 	STRUCT 
		Start : STRING[80] := 'Start';
		Stop : STRING[80] := 'Stop';
		Filling_1_2 : STRING[80] := 'Nape³nianie 1/2';
		Emptying_1_2 : STRING[80] := 'Opró¿nianie 1/2';
		Filling_3 : STRING[80] := 'Nape³nianie 3';
		Mixing : STRING[80] := 'Mieszanie';
		Emptying_3 : STRING[80] := 'Opró¿nianie 3';
	END_STRUCT;
	ManualControl : 	STRUCT 
		ZB1 : BOOL;
		ZB2 : BOOL;
		ZBMain : BOOL;
		ZB3_right : BOOL;
		ZB3_left : BOOL;
		ZBMix : BOOL;
	END_STRUCT;
END_TYPE
