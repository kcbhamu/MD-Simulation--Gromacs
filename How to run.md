# How to start from the systems built by CHARMM-Gui 

# Minimization:

- [ ] #!/bin/bash
- [ ] module load gromacs/2018.3
       #In Biowulf,  gromacs/2018.3 will run the energy minimization without error.
- [ ] gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_charmm2gmx.pdb -r step5_charmm2gmx.p$
- [ ] gmx mdrun -v -deffnm step6.0_minimization

- [ ] gmx grompp -f step6.1_equilibration.mdp -o step6.1_equilibration.tpr -c step6.0_minimization.gro -r step5_charmm$
- [ ] gmx mdrun -v -deffnm step6.1_equilibration

- [ ] gmx grompp -f step6.2_equilibration.mdp -o step6.2_equilibration.tpr -c step6.1_equilibration.gro -r step5_charm$
- [ ] gmx mdrun -v -deffnm step6.2_equilibration

- [ ] gmx grompp -f step6.3_equilibration.mdp -o step6.3_equilibration.tpr -c step6.2_equilibration.gro -r step5_charm$
- [ ] gmx mdrun -v -deffnm step6.3_equilibration

- [ ] gmx grompp -f step6.4_equilibration.mdp -o step6.4_equilibration.tpr -c step6.3_equilibration.gro -r step5_charm$
- [ ] gmx mdrun -v -deffnm step6.4_equilibration

- [ ] gmx grompp -f step6.5_equilibration.mdp -o step6.5_equilibration.tpr -c step6.4_equilibration.gro -r step5_charm$
- [ ] gmx mdrun -v -deffnm step6.5_equilibration

- [ ] gmx grompp -f step6.6_equilibration.mdp -o step6.6_equilibration.tpr -c step6.5_equilibration.gro -r step5_charm$
- [ ] gmx mdrun -v -deffnm step6.6_equilibration

# Production

- [ ] #!/bin/bash

- [ ] #Production

- [ ] module load gromacs/2018.3

- [ ] gmx grompp -f step7_production.mdp -o step7_1.tpr -c step6.6_equilibration.gro -n index.ndx -p topol.top
- [ ] gmx mdrun -v -deffnm step7_1

- [ ] gmx grompp -f step7_production.mdp -o step7_2.tpr -c step7_1.gro -t step7_1.cpt -n index.ndx -p topol.top
- [ ] gmx mdrun -v -deffnm step7_2

- [ ] gmx grompp -f step7_production.mdp -o step7_3.tpr -c step7_2.gro -t step7_2.cpt -n index.ndx -p topol.top
- [ ] gmx mdrun -v -deffnm step7_3

# How to continue run after unexpected interruption:

#!/bin/bash

#Production

module load gromacs/2018

gmx mdrun -v -deffnm step7_17 -cpi step7_17_prev.cpt -append


#Production.mdp

integrator              = md
dt                      = 0.002
nsteps                  = 170000000
nstlog                  = 10000
nstxout                 = 50000
nstvout                 = 50000
nstfout                 = 50000
nstcalcenergy           = 100
nstenergy               = 1000
;
cutoff-scheme           = Verlet
nstlist                 = 20
rlist                   = 1.2
coulombtype             = pme
rcoulomb                = 1.2
vdwtype                 = Cut-off
vdw-modifier            = Force-switch
rvdw_switch             = 1.0
rvdw                    = 1.2
;
tcoupl                  = Nose-Hoover
tc_grps                 = PROT   MEMB   SOL_ION
tau_t                   = 1.0    1.0    1.0
ref_t                   = 303.15 303.15 303.15
;
pcoupl                  = Parrinello-Rahman
pcoupltype              = semiisotropic
tau_p                   = 5.0
compressibility         = 4.5e-5  4.5e-5
ref_p                   = 1.0     1.0
;
constraints             = h-bonds
constraint_algorithm    = LINCS
continuation            = yes
;
nstcomm                 = 100
comm_mode               = linear
comm_grps               = PROT   MEMB   SOL_ION
;
refcoord_scaling        = com

# Run on Biowulf GPU node:

- [ ] sbatch --partition=gpu --cpus-per-task=56 --gres=gpu:k80:4 Production3.jobscript


#!/bin/bash
module load gromacs/2018.3

gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_charmm2gmx.pdb -r step5_charmm2gmx.p$
gmx mdrun -v -deffnm step6.0_minimization

gmx grompp -f step6.1_equilibration.mdp -o step6.1_equilibration.tpr -c step6.0_minimization.gro -r step5_charmm$
gmx mdrun -v -deffnm step6.1_equilibration

gmx grompp -f step6.2_equilibration.mdp -o step6.2_equilibration.tpr -c step6.1_equilibration.gro -r step5_charm$
gmx mdrun -v -deffnm step6.2_equilibration

gmx grompp -f step6.3_equilibration.mdp -o step6.3_equilibration.tpr -c step6.2_equilibration.gro -r step5_charm$
gmx mdrun -v -deffnm step6.3_equilibration

gmx grompp -f step6.4_equilibration.mdp -o step6.4_equilibration.tpr -c step6.3_equilibration.gro -r step5_charm$
gmx mdrun -v -deffnm step6.4_equilibration

gmx grompp -f step6.5_equilibration.mdp -o step6.5_equilibration.tpr -c step6.4_equilibration.gro -r step5_charm$
gmx mdrun -v -deffnm step6.5_equilibration

gmx grompp -f step6.6_equilibration.mdp -o step6.6_equilibration.tpr -c step6.5_equilibration.gro -r step5_charm$
gmx mdrun -v -deffnm step6.6_equilibration
