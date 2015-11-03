%%
TexpRec = 0.231;
NtE     = 11;
Texp    = TexpRec:TexpRec: NtE * TexpRec;



dt         = 0.0053;

t_end     = 1;
t_end     = round(t_end/dt)*dt
t_start   = 0.51;
t_start   = round(t_start/dt)*dt

tmRec     =  round(  ( t_end - t_start )  / (NtE - 1) / dt ) * dt;

ss_epsilon = 1;
NumPlots   = 1;
[TimeObj] = TimeObjMakerRD(dt,t_end,tmRec,ss_epsilon,NumPlots);

Tmod = 0:TimeObj.t_rec:t_end;

Texp
Tmod(TimeObj.N_rec-NtE+1:end)


%%
%%
TexpRec = 0.231;
NtE     = 14;
Texp    = TexpRec:TexpRec: NtE * TexpRec;

% NtEx      = 100;

t_end     = 1;
t_start   = 0.1;

NtEx      = floor (t_start * NtE / (t_end - t_start) );
floor ((t_end - t_start) / t_start  )
N_recTemp = NtE + NtEx;
tmRec     = floor( t_end / ( dt * ( N_recTemp - 1) ) ) * dt;
t_end     = floor( t_end/tmRec ) * tmRec
N_rec     = t_end/tmRec + 1;
t_start   = ( N_rec - NtE ) * tmRec
[TimeObj] = TimeObjMakerRD(dt,t_end,tmRec,ss_epsilon,NumPlots);
Tmod      = 0:TimeObj.t_rec:t_end;

Texp
Tmod(TimeObj.N_rec-NtE+1:end)
