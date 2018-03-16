function ret = fpi(DBP,PP,f,t)

wt = 2 * pi * f * t;

ret = DBP + 0.5 * PP + 0.36 * PP * ...
        ( sin(wt) + sin(2 * wt) / 2 + sin(3 * wt) / 4 );

end