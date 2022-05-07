
#BeginMacro(px)
( 
if((even(cellpos(1))),(0,0,5),(0,1,5))
)
#EndMacro

#BeginMacro(py)
( 
if((odd(cellpos(1))),(0,0,4),(0,1,4))
)
#EndMacro

%p=(1-qx)*qy* Ni
#BeginMacro(p_move_x)
( 
((-1)+(0,0,3))*(0,0,4)*(0,0,-1)
)
#EndMacro

%p=(1-qy)*qx* Ni
#BeginMacro(p_move_y)
( 
((-1)+(0,0,3))*(0,0,2)*(0,0,-2)
)
#EndMacro

#BeginMacro(min_num)
( 
10000
)
#EndMacro