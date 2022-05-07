#include (vocanic_particle1.inc)
[top]
components : vocanic_particle

[vocanic_particle]
type : cell
dim : (12,20,7)
delay : transport
defaultDelayTime : 1
border : wrapped
initialValue : 0
initialCellsValue : init3.val


neighbors : vocanic_particle(-1,1,-3) vocanic_particle(0,1,-3) vocanic_particle(1,1,-3)
neighbors : vocanic_particle(-1,0,-3) vocanic_particle(0,0,-3) vocanic_particle(1,0,-3)
neighbors : vocanic_particle(-1,-1,-3) vocanic_particle(0,-1,-3) vocanic_particle(1,-1,-3)
neighbors : vocanic_particle(-1,1,-2) vocanic_particle(0,1,-2) vocanic_particle(1,1,-2)
neighbors : vocanic_particle(-1,0,-2) vocanic_particle(0,0,-2) vocanic_particle(1,0,-2)
neighbors : vocanic_particle(-1,-1,-2) vocanic_particle(0,-1,-2) vocanic_particle(1,-1,-2)
neighbors : vocanic_particle(-1,1,-1) vocanic_particle(0,1,-1) vocanic_particle(1,1,-1)
neighbors : vocanic_particle(-1,0,-1) vocanic_particle(0,0,-1) vocanic_particle(1,0,-1)
neighbors : vocanic_particle(-1,-1,-1) vocanic_particle(0,-1,-1) vocanic_particle(1,-1,-1)
neighbors : vocanic_particle(-1,1,0) vocanic_particle(0,1,0) vocanic_particle(1,1,0)
neighbors : vocanic_particle(-1,0,0) vocanic_particle(0,0,0) vocanic_particle(1,0,0)
neighbors : vocanic_particle(-1,-1,0) vocanic_particle(0,-1,0) vocanic_particle(1,-1,0)
neighbors : vocanic_particle(-1,1,1) vocanic_particle(0,1,1) vocanic_particle(1,1,1)
neighbors : vocanic_particle(-1,0,1) vocanic_particle(0,0,1) vocanic_particle(1,0,1)
neighbors : vocanic_particle(-1,-1,1) vocanic_particle(0,-1,1) vocanic_particle(1,-1,1)
neighbors : vocanic_particle(-1,1,2) vocanic_particle(0,1,2) vocanic_particle(1,1,2)
neighbors : vocanic_particle(-1,0,2) vocanic_particle(0,0,2) vocanic_particle(1,0,2)
neighbors : vocanic_particle(-1,-1,2) vocanic_particle(0,-1,2) vocanic_particle(1,-1,2)
neighbors : vocanic_particle(-1,1,3) vocanic_particle(0,1,3) vocanic_particle(1,1,3)
neighbors : vocanic_particle(-1,0,3) vocanic_particle(0,0,3) vocanic_particle(1,0,3)
neighbors : vocanic_particle(-1,-1,3) vocanic_particle(0,-1,3) vocanic_particle(1,-1,3)
neighbors : vocanic_particle(-1,1,4) vocanic_particle(0,1,4) vocanic_particle(1,1,4)
neighbors : vocanic_particle(-1,0,4) vocanic_particle(0,0,4) vocanic_particle(1,0,4)
neighbors : vocanic_particle(-1,-1,4) vocanic_particle(0,-1,4) vocanic_particle(1,-1,4)
neighbors : vocanic_particle(-1,1,5) vocanic_particle(0,1,5) vocanic_particle(1,1,5)
neighbors : vocanic_particle(-1,0,5) vocanic_particle(0,0,5) vocanic_particle(1,0,5)
neighbors : vocanic_particle(-1,-1,5) vocanic_particle(0,-1,5) vocanic_particle(1,-1,5)


localTransition : DefaultTransition

%zone : pxy			{ (0,0,6)..(10,19,6) }
zone : qxy			{ (0,0,4)..(10,19,5) }
zone : move_x		{ (0,0,1)..(10,19,1) }
zone : move_y		{ (0,0,2)..(10,19,2) }
zone : move_xy		{ (0,0,3)..(10,19,3) }
zone : Ni			{ (0,0,0)..(10,19,0) }
zone : ground		{ (11,0,0)..(11,19,0) }

[pxy]
rule : { (0,0,0) } 1 {t}

[qxy]
rule : {	uniform(0,100)/100.0	}	1	{t}

[move_x]
% if probability qx < px and px>0, particles move to (0,1) direction
% if probability qx < px and px<0, particles move to (0,-1) direction

rule : {	#Macro(p_move_x) * (-1)	} 	0	{	((0,0,-1)>=#Macro(min_num))	and		(#Macro(px)>0) 	and 	((0,0,3)< #Macro(px))		}
rule : {	#Macro(p_move_x)		} 	0	{	((0,0,-1)>=#Macro(min_num))	and		(#Macro(px)<0) 	and 	(((0,0,3)+ #Macro(px))<0)	}

rule : { 0 } 	0 	{t}

[move_y]
% if probability qy < py and py>0, particles move to (1,0) direction
% if probability qy < py and py<0, particles move to (-1,0) direction

rule : {	#Macro(p_move_y) * (-1)	} 	0	{	((0,0,-2)>=#Macro(min_num))	and		(#Macro(py)>0) 	and 	((0,0,3) <  #Macro(py))	    }
rule : {	#Macro(p_move_y)		} 	0	{	((0,0,-2)>=#Macro(min_num))	and		(#Macro(py)<0) 	and 	(((0,0,3)+ #Macro(py))<0)	}
rule : {	(0,0,-2)				} 	0	{	((0,0,-2)<#Macro(min_num))	and		((0,0,-2)>0)	}
rule : {0} 0 {t}

[move_xy]

%  particles move to (1,1) or (-1,1) or (1,-1) or (-1,-1) direction
rule : { 	 (	if	(((0,0,-1)>=0),1,-1)	)  *  (	if	(((0,0,-2)>=0),1,-1)	) * (0,0,1)  * (0,0,2)  * (0,0,-3)	}
		 0 { 	(((0,0,-1)!=0)	or	((0,0,-2)!=0)) and  ((0,0,-3)>=#Macro(min_num))	}

rule : {0} 0 {t}

[Ni]
				
rule : {(0,0,0)} 1 { 	(cellpos(0)=0) 	and 	((0,-1,0)=0) 	and 	((0,1,0)=0) 	and 	((1,-1,0)=0) 	and 
						((1,0,0)=0) 	and 	((1,1,0)=0) 	}	
						
rule : {(0,0,0)} 1 { 	((1,0,0)<0)   	and 	((-1,-1,0)=0) 	and 	((-1,0,0)=0) 	and 
						((-1,1,0)=0) 	and 	((0,-1,0)=0) 	and 	((0,1,0)=0)   	}
																	
rule : {(0,0,0)} 1 { 	((-1,-1,0)=0) 	and 	((-1,0,0)=0) 	and 	((-1,1,0)=0) 	and 
						((0,-1,0)=0) 	and 	((0,1,0)=0) 	and 	((1,-1,0)=0) 	and 
						((1,0,0)=0) 	and 	((1,1,0)=0) 	}
						
rule : {0} 1 {(0,0,0)<0}					


rule : {	(0,0,0)		-	 if(((0,0,1)<0),-1,1) 	 *		(0,0,1)
						-	 if(((0,0,2)<0),-1,1) 	 * 		(0,0,2)
						-	 if(((0,0,3)<0),-1,1) 	 *		(0,0,3)				
						+	 if(((0,-1,1)>0),1,0) 	 *		(0,-1,1)	
						
						- 	 if(((1,0,2)<0),1,0)  	*		(1,0,2)
						-	 if(((0,1,1)<0),1,0) 	 *		(0,1,1)	
						-	 if((((1,-1,3)<0) 	and  ((1,-1,2)<0)),1,0) 	 *	(1,-1,3)	
						+	 if((((1,1,3)>0) 	and  ((1,1,1)<0) and ((1,1,2)<0)),1,0) 	 *	(1,1,3) 
		} 	1	{	cellpos(0)=0	}		
		

rule : {	(0,0,0)		-	 if(((0,0,1)<0),-1,1) 	 *		(0,0,1)
						-	 if(((0,0,2)<0),-1,1) 	 * 		(0,0,2)
						-	 if(((0,0,3)<0),-1,1) 	 *		(0,0,3)
						
						+	 if(((0,-1,1)>0),1,0) 	 *		(0,-1,1)	
						+	 if(((-1,0,2)>0),1,0) 	 *		(-1,0,2)
						-	 if(((0,1,1)<0),1,0) 	 *		(0,1,1)	
						+	 if((((-1,-1,3)>0) 	and  ((-1,-1,1)>=0) ),1,0) 	 *	(-1,-1,3)	
						-	 if((((-1,1,3)<0) 	and  ((-1,1,1)<0)  ),1,0) 	 *	(-1,1,3)
		} 	1	{	(1,0,0)<0	}
		
		

rule : {	(0,0,0)		-	 if(((0,0,1)<0),-1,1) 	 *		(0,0,1)
						-	 if(((0,0,2)<0),-1,1) 	 * 		(0,0,2)
						-	 if(((0,0,3)<0),-1,1) 	 *		(0,0,3)
						
						+	 if(((0,-1,1)>0),1,0) 	 *		(0,-1,1)	
						+	 if(((-1,0,2)>0),1,0) 	 *		(-1,0,2)
						- 	 if(((1,0,2)<0),1,0)  	*		(1,0,2)
						-	 if(((0,1,1)<0),1,0) 	 *		(0,1,1)	
											
						+	 if((((-1,-1,3)>0) 	and  ((-1,-1,1)>=0) ),1,0) 	 *	(-1,-1,3)	
						-	 if((((-1,1,3)<0) 	and  ((-1,1,1)<0)  ),1,0) 	 *	(-1,1,3)
						-	 if((((1,-1,3)<0) 	and  ((1,-1,2)<0)),1,0) 	 *	(1,-1,3)	
						+	 if((((1,1,3)>0) 	and  ((1,1,1)<0) and ((1,1,2)<0)),1,0) 	 *	(1,1,3) 
		} 	1	{	t	}

[ground]
rule : {-1} 	1	{	(0,0,0)>=0	}
rule : {(0,0,0)} 1 {((-1,-1,0)=0) and ((-1,0,0)=0) and ((-1,1,0)=0) and ((0,0,0)=-1)}
rule : {(0,0,0) -	 if((((-1,-1,3)>0) 	and  ((-1,-1,1)>=0) ),1,0) 	 *	(-1,-1,3)	
				+	 if((((-1,1,3)<0) 	and  ((-1,1,1)<0)  ),1,0) 	 *	(-1,1,3)
				-	 if(((-1,0,2)>0),1,0) 	 *		(-1,0,2)
		} 1 {t}

[DefaultTransition]
rule : {(0,0,0)} 1 {t}