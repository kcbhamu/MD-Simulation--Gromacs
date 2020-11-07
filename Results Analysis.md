# Results Analysis

# 0. Check the results you get
- [ ] module load gromacs/2018.3
- [ ] gmx check -f step7_1.trr

# 1. Concatenates several input trajectory files in sorted order
- [ ] gmx trjcat -f step7_1.trr step7_2.trr step7_3.trr step7_4.trr step7_5.trr step7_6.trr step7_7.trr step7_8.trr step7_9.trr step7_10.trr step7_11.trr step7_12.trr step7_13.trr step7_14.trr step7_15.trr step7_16.trr step7_17.trr step7_18.trr -settime -o step7.trr

*For -settime, use c option

# 2. Convert trajectory files to smaller trajectory file for viewer

## 2.1 Name a new group of protein-ligand complex and create a new index file using gmx ``make_ndx`` if necessary
### Launch gmx make_ndx
- [ ] gmx make_ndx -f step6.6_equilibration.gro -o protein-ligand.ndx
### Combine group 1 and 13 to get new group 18: Protein-NNR, and then q to save/export new index file "protein-ligand.ndx"

```sh
GROMACS:      gmx make_ndx, version 2018.3
Executable:   /usr/local/apps/gromacs/2018.3/bin/gmx
Data prefix:  /usr/local/apps/gromacs/2018.3
Working dir:  /gpfs/gsfs10/users/dout2/PnuC_3NR-XY100-charmm-gui-0226106078/gromacs
Command line:
  gmx make_ndx -f step6.6_equilibration.gro -o protein-ligand.ndx


Reading structure file
Going to read 0 old index file(s)
Analysing residue names:
There are:   707    Protein residues
There are: 19664      Other residues
Analysing Protein...
Analysing residues not classified as Protein/DNA/RNA/Water and splitting into groups...

  0 System              : 96403 atoms
  1 Protein             : 11490 atoms
  2 Protein-H           :  5677 atoms
  3 C-alpha             :   707 atoms
  4 Backbone            :  2121 atoms
  5 MainChain           :  2825 atoms
  6 MainChain+Cb        :  3483 atoms
  7 MainChain+H         :  3517 atoms
  8 SideChain           :  7973 atoms
  9 SideChain-H         :  2852 atoms
 10 Prot-Masses         : 11490 atoms
 11 non-Protein         : 84913 atoms
 12 Other               : 84913 atoms
 13 NNR                 :    99 atoms
 14 POPC                : 26666 atoms
 15 SOD                 :    52 atoms
 16 CLA                 :    67 atoms
 17 TIP3                : 58029 atoms

 nr : group      '!': not  'name' nr name   'splitch' nr    Enter: list groups
 'a': atom       '&': and  'del' nr         'splitres' nr   'l': list residues
 't': atom type  '|': or   'keep' nr        'splitat' nr    'h': help
 'r': residue              'res' nr         'chain' char
 "name": group             'case': case sensitive           'q': save and quit
 'ri': residue index

> 1 | 13

Copied index group 1 'Protein'
Copied index group 13 'NNR'
Merged two groups with OR: 11490 99 -> 11589

 18 Protein_NNR         : 11589 atoms

> 
```


## 2.2 Then, load the new index file and center the protein-ligand complex

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -n protein-ligand.ndx -o PnuC_3NR_500ns.trr -pbc cluster -center -ur compact -dt 1000 

*Select group 18 "Protein_NNR" for clustering,  group 18 "Protein_NNR" for centering, and the whole system (group 0) for output.

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -n protein-ligand.ndx -o PnuC_3NR_500ns.trr -pbc cluster -center -dt 1000 

*Select group 18 "Protein_NNR" for clustering,  group 18 "Protein_NNR" for centering, and the whole system (group 0) for output.



## Otherwise, we can also center the protein directly

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -o PnuC_3NR_500ns.trr -pbc cluster -dt 1000 -center

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -o PnuC_3NR_500ns.trr -pbc cluster -dt 1000 -center -ur compact

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -o PnuC_3NR_500ns.trr -pbc whole -dt 1000 -center

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -o PnuC_3NR_500ns.trr -pbc mol -dt 1000 -center -ur compact

- [ ] gmx trjconv -f step7_1.trr -s step7_1.tpr -o PnuC_3NR_500ns.trr -pbc nojump -dt 1000 -center

*Choose “Protein” for cluster, "Protein" to center, and “whole system” for output 

#How to load vmd on my Linux and view the trajectory file

- [ ] cd /home/dout2/Application/vmd_bin
- [ ] ./vmd

Convert .trr to .pdb file for Pymol view
- [ ] gmx trjconv -f step7.trr -s step6.0_minimization.tpr -o PnuC_0NR_1us.pdb -pbc nojump -dt 1000

*Choose “Protein” for output

# 3. Quality Assurance
    Whether the protein is stable and close to the experimental structure.
3.1 Convergence of Energy Terms
Extraction of some thermodynamic parameters from the energy file: temperature, pressure, potential energy, kinetic energy, unite cell volume, density, and the box dimensions, etc.
Energy analysis:
- [ ] gmx eneconv -f step7_1.edr step7_2.edr step7_3.edr step7_4.edr step7_5.edr step7_6.edr step7_7.edr step7_8.edr step7_9.edr step7_10.edr step7_11.edr step7_12.edr step7_13.edr step7_14.edr step7_15.edr step7_16.edr  -o PnuC_0NR_1us.edr -settime
- [ ] gmx energy -f PnuC_0NR_1us.edr -o temperature.xvg
- [ ] xmgrace temperature.xvg
Pressure:
- [ ] gmx energy -f PnuC_0NR_1us.edr -o pressure.xvg *choose pressure in the list
- [ ] xmgrace pressure.xvg
Energy:
- [ ] gmx energy -f PnuC_0NR_1us.edr -o energy.xvg *choose 16 “total energy” in the list
- [ ] xmgrace  energy.xvg
Volume:
- [ ] gmx energy -f PnuC_0NR_1us.edr -o volume.xvg
- [ ] xmgrace volume.xvg
Density:
- [ ] gmx energy -f PnuC_0NR_1us.edr -o density.xvg
- [ ] xmgrace density.xvg
Box:
- [ ] gmx energy -f PnuC_0NR_1us.edr -o box.xvg
- [ ] xmgrace box.xvg


3.2 Minimum distances between periodic images
gmx mindist -f step7.trr -s step6.0_minimization.tpr -od minimal-periodic-distance.xvg -pi

3.3 RMSF: Root mean square flections
- [ ] gmx rmsf -f step7.trr -s step6.0_minimization.tpr -o rmsf-per-residue.xvg -ox average.pdb -res
 *select 
- [ ] xmgrace rmsf-per-residue.xvg

3.4 RMSD: Convergence of RMSD
- [ ] gmx rms -f step7.trr -s step6.0_minimization.tpr -o rmsd-all-atom-vs-start.xvg
 *select protein-H
- [ ] gmx rms -f step7.trr -s step6.0_minimization.tpr -o rmsd-all-backbone-vs-start.xvg
 *select only backbone atoms
- [ ] echo 1 | gmx trjconv -f step7.trr -s step6.0_minimization.tpr -o peptide.trr
 *Check the convergence towards the average structure.
- [ ] gmx rms -f step7.trr -s average.pdb -o rmsd-all-atom-vs-average.xvg
- [ ] gmx rms -f step7.trr -s average.pdb -o rmsd-backbone-vs-average.xvg
- [ ] xmgrace xx.xvg
## Convert .xvg file to .png, for show and publication?

- [ ] xmgrace -nxy rmsd-all-backbone-vs-start.xvg -hdevice PNG -hardcopy -printfile rmsd-all-backbone-vs-start.png

3.5 Convergence of Radius of Gyration
- [ ] gmx gyration -f step7.trr -s step6.0_minimization.tpr -p -o radius-of-gyration.xvg
- [ ] xmgrace radius-of-gyration.xvg

# 4. Structural Analysis: Properties derived from configurations
4.1 Hydrogen bonds
- [ ] gmx hbond -f step7.trr -s step6.0_minimization.tpr -num hydrogen-bonds-intra-protein.xvg
- [ ] gmx hbond -f step7.trr -s step6.0_minimization.tpr -num hydrogen-bonds-protein-other.xvg

4.2 Salt Bridge

4.3 Secondary Structure
How to load DSSP:
- [ ] module load DSSP
- [ ] whereis dssp
- [ ] export DSSP=/usr/local/apps/DSSP/2.2.1/bin/dssp
- [ ] gmx do_dssp -f step7.trr -s step6.0_minimization.tpr -ver 2 -o secondary-structure.xpm -sc secondary-structure.xvg -dt 10
- [ ] gmx xpm2ps -f secondary-structure.xpm -o secondary-structure.eps
- [ ] display secondary-structure.eps
4.4 Ramachandran Plots
- [ ] gmx rama -f step7.trr -s step6.0_minimization.tpr -o ramachandran.xvg 
- [ ] xmgrace ramachandran.xvg 

# 5. Analysis of Dynamics and Time-Averaged properties 
5.1 RMSD again
- [ ] gmx rms -s step6.0_minimization.tpr -f step7.trr -f2 step7.trr -m rmsd-matrix.xpm -dt 10
- [ ] gmx xpm2ps -f rmsd-matrix.xpm -o rmsd-matrix.eps
- [ ] display rmsd-matrix.eps

5.2 How to generate a color coded RMSF using PyMol?
- [ ] Action->Presets->B-Factor Putty

#Assign color by B-factor
- [ ] B-factor coloring can be done with the spectrum command. Example:

spectrum b, blue_white_red, minimum=20, maximum=50
as cartoon
cartoon putty

#Generate .pdb file by Gromacs

- [ ] mx rmsf -f step7.trr -s step6.0_minimization.tpr -oq PnuC_0NR_1us_Bfactor.pdb

#Biowulf sbatch jobscript


#!/bin/bash

#rmsf2Bfactor.jobscript

#This script is to submit a sbatch job on Biowulf to calculate and generate a .pdb file with Bfactor inserted.

module load gromacs/2018.3

#Calculate using whole protein
echo 1 | gmx rmsf -f step7.trr -s step6.0_minimization.tpr -oq PnuC_0NR_1us_Bfactor.pdb

#Calculate using backbone
echo 4 | gmx rmsf -f step7.trr -s step6.0_minimization.tpr -oq PnuC_0NR_1us_Bfactor.pdb

5.3 Principal Components Analysis (PCA)

#Reference: 
#https://www3.mpibpc.mpg.de/groups/de_groot/compbio1/p4/index.html
#http://scc.acad.bg/ncsa/downloads/programs/GROMACS/GROMACS%204.5%20Tutorial.pdf
#http://thegrantlab.org/bio3d/tutorials/principal-component-analysis

#calculates and diagonalizes the (mass-weighted) covariance matrix
#Select group “4” (Protein backbone) both for fit and analysis.
- [ ] gmx covar -f step7.trr -s step6.0_minimization.tpr -o eigenval.xvg –v eigenvect.trr –xpma covara.xpm

#Use xpm2ps to make a pretty plot of the atomic covariance matrix.
- [ ] gmx xpm2ps -f covara.xpm -o covara.eps -do covara.m2p

#Use ghostview (or Photoshop) to view the plot (gv covara.eps).
- [ ] gv covara.eps

#To view the most dominant mode (1), use the following command ...
- [ ] gmx anaeig -v eigenvect.trr -f step7.trr -s step6.0_minimization.tpr -first 1 -last 1 -nframes 100 -extr fws-ev1.pdb

5.4 Energy landscape















