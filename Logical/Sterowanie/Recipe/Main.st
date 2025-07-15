
PROGRAM _INIT
	(* Zapis przepisu do C:\Temp\ *)
	MpRecipeXml_0.Enable := TRUE;
	MpRecipeXml_0.MpLink := ADR(gRecipeXml);
	MpRecipeXml_0.DeviceName := ADR('Location');
	MpRecipeXml_0.FileName := ADR('Recipe');
	
	MpRecipeRegPar_0.Enable := TRUE;
	MpRecipeRegPar_0.MpLink := ADR(gRecipeXml);
	MpRecipeRegPar_0.PVName := ADR('Recipe:Recipe');
	
	MpRecipeUI_0.Enable := TRUE;
	MpRecipeUI_0.MpLink := ADR(gRecipeXml);
	MpRecipeUI_0.UIConnect := ADR(UIConnect);
END_PROGRAM

PROGRAM _CYCLIC
	(* Wywo³anie bloków funkcyjnych *)
	MpRecipeXml_0();
	MpRecipeRegPar_0();
	MpRecipeUI_0();
	
	IF Save THEN
		MpRecipeXml_0.Load := FALSE;
		MpRecipeXml_0.Save := TRUE;
		Save := FALSE;
	END_IF;
	
	IF Load THEN
		MpRecipeXml_0.Save := FALSE;
		MpRecipeXml_0.Load := TRUE;
		Load := FALSE;
	END_IF;
END_PROGRAM

PROGRAM _EXIT
	(* Wy³¹czenie bloków funkcyjnych *)
	MpRecipeXml_0.Enable := FALSE;
	MpRecipeXml_0();
	
	MpRecipeRegPar_0.Enable := FALSE;
	MpRecipeRegPar_0();
	
	MpRecipeUI_0.Enable := FALSE;
	MpRecipeUI_0();
END_PROGRAM

