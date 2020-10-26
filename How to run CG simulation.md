### Production.jobscript

```sh                                                                              

#!/bin/bash

# Load Gromacs on Biowulf
module load gromacs/2018.3

# Production
gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
gmx mdrun -deffnm step7_production -rdd 1.4

```

### Production_Continue.jobscript

```sh                                                                              

#!/bin/bash

#Production

# Load Gromacs on Biowulf
module load gromacs/2018.3

gmx mdrun -v -deffnm step7_1 -cpi step7_1_prev.cpt -rdd 1.4 -append


```
