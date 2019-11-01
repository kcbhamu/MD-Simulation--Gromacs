#Results Analysis

0. Check the results you get

gmx check -f step7_1.trr

1. Concatenates several input trajectory files in sorted order
- [ ] gmx trjcat -f step7_1.trr step7_2.trr step7_3.trr step7_4.trr step7_5.trr step7_6.trr step7_7.trr step7_8.trr step7_9.trr step7_10.trr step7_11.trr step7_12.trr step7_13.trr step7_14.trr step7_15.trr step7_16.trr -settime -o step7.trr
*For -settime, use c option

2. Convert trajectory files to smaller trajectory file for viewer
- [ ] gmx trjconv -f step7.trr -s step6.0_minimization.tpr -o PnuC_0NR_1us.trr -pbc cluster -dt 1000
Choose “Protein” for cluster and “whole system” for output 

Convert .trr to .pdb file for Pymol view
- [ ] gmx trjconv -f step7.trr -s step6.0_minimization.tpr -o PnuC_0NR_1us.pdb -pbc nojump -dt 1000
*Choose “Protein” for output

3. Quality Assurance
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

4. Structural Analysis: Properties derived from configurations
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

5. Analysis of Dynamics and Time-Averaged properties 
5.1 RMSD again
- [ ] gmx rms -s step6.0_minimization.tpr -f step7.trr -f2 step7.trr -m rmsd-matrix.xpm -dt 10
- [ ] gmx xpm2ps -f rmsd-matrix.xpm -o rmsd-matrix.eps
- [ ] display rmsd-matrix.eps

5.2 How to generate a color coded RMSF using PyMol?
Action->Presets->B-Factor Putty

#Assign color by B-factor
B-factor coloring can be done with the spectrum command. Example:

spectrum b, blue_white_red, minimum=20, maximum=50
as cartoon
cartoon putty

#Generate .pdb file by Gromacs

gmx rmsf -f step7.trr -s step6.0_minimization.tpr -oq PnuC_0NR_1us_Bfactor.pdb

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
gmx covar -f step7.trr -s step6.0_minimization.tpr -o eigenval.xvg –v eigenvect.trr –xpma covara.xpm

#Use xpm2ps to make a pretty plot of the atomic covariance matrix.
gmx xpm2ps -f covara.xpm -o covara.eps -do covara.m2p

#Use ghostview (or Photoshop) to view the plot (gv covara.eps).
gv covara.eps

#To view the most dominant mode (1), use the following command ...
gmx anaeig -v eigenvect.trr -f step7.trr -s step6.0_minimization.tpr -first 1 -last 1 -nframes 100 -extr fws-ev1.pdb

5.4 Energy landscape















