
#!/bin/csh

# Load gromacs on Biowulf node
module load gromacs/2018.3

# step6.0
#gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_input.gro -r step5_input.gro -p topol.top
#gmx mdrun -v -deffnm step6.0_minimization

# Equilibration
:'
set cnt    = 1
set cntmax = 6

while ( ${cnt} <= ${cntmax} )
    @ pcnt = ${cnt} - 1    
    if ( ${cnt} == 1 ) then
        gmx grompp -f step6.{$cnt}_equilibration.mdp -o step6.{$cnt}_equilibration.tpr -c step6.{$pcnt}_minimization.gro -r step5_input.gro$
        gmx mdrun -v -deffnm step6.{$cnt}_equilibration
    else
        gmx grompp -f step6.{$cnt}_equilibration.mdp -o step6.{$cnt}_equilibration.tpr -c step6.{$pcnt}_equilibration.gro -r step5_input.gr$
        gmx mdrun -v -deffnm step6.{$cnt}_equilibration
    endif
    @ cnt += 1
end
'
gmx mdrun -v -deffnm step6.6_equilibration
