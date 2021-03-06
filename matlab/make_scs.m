% WARNING: OPENMP WITH MATLAB CAN CAUSE ERRORS AND CRASH, USE WITH CAUTION:
% openmp parallelizes the matrix multiply for the indirect solver (using CG):
flags.COMPILE_WITH_OPENMP = false;

flags.BLASLIB = '-lmwblas -lmwlapack';
% MATLAB_MEX_FILE env variable sets blasint to ptrdiff_t
flags.LCFLAG = '-DMATLAB_MEX_FILE -DLAPACK_LIB_FOUND -DDLONG -DCTRLC=1 -DCOPYAMATRIX';
%flags.LCFLAG = '-DMATLAB_MEX_FILE -DLAPACK_LIB_FOUND -DDLONG -DCTRLC=1 -DCOPYAMATRIX -DEXTRAVERBOSE';
flags.INCS = '';
flags.LOCS = '';

common_scs = '../src/linAlg.c ../src/cones.c ../src/cs.c ../src/util.c ../src/scs.c ../src/ctrlc.c ../linsys/common.c ../src/scs_version.c scs_mex.c';
if (~isempty (strfind (computer, '64')))
    flags.arr = '-largeArrayDims';
else
    flags.arr = '';
end

if ( isunix && ~ismac )
    flags.link = '-lm -lut -lrt';
elseif  ( ismac )
    flags.link = '-lm -lut';
else
    flags.link = '-lut';
    flags.LCFLAG = sprintf('-DBLASSUFFIX="" %s', flags.LCFLAG);
end

if (flags.COMPILE_WITH_OPENMP)
    flags.link = strcat(flags.link, ' -lgomp');
end

compile_direct(flags, common_scs);
compile_indirect(flags, common_scs);

% compile scs_version
mex -O -I../include ../src/scs_version.c scs_version_mex.c -output scs_version

%%
clear data cones
disp('Example run:');
m = 9;
n = 3;
data.A = sparse(randn(m,n));
data.b = randn(m,1);
data.c = randn(n,1);
cones.l = m;
[x,y,s,info] = scs_indirect(data,cones,[]);
[x,y,s,info] = scs_direct(data,cones,[]);
disp('SUCCESSFULLY INSTALLED SCS')
