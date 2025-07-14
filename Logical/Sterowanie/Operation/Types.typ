
TYPE
	StepEnum : 
		(
		STEP_START,
		STEP_FILL12,
		STEP_EMPTY12,
		STEP_FILL3,
		STEP_EMPTY3,
		STEP_MIX
		);
	ControlType : 	STRUCT 
		Step : StepEnum;
	END_STRUCT;
	TankLvl : 	STRUCT 
		zb1 : USINT;
		zb2 : USINT;
		zb3 : USINT;
	END_STRUCT;
END_TYPE
