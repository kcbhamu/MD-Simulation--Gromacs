# Set up Membrane Bilayer system by CHARMM-GUI

- [ ] http://www.charmm-gui.org
- [ ] Input Generator
- [ ] Membrane Builder
- [ ] Bilayer Builder
- [ ] Protein/Membrane system

# Step 00 - PDB Info
- [ ] Download 4QTN from OPM database

# Step 01 - Select Model/Chain, Manipulate PDB, Generate PDB and Orient Molecule

- [ ] Select Chain A, B, and C, with residue ID 2-236. #Also add NNR if to make PnuC_3NR system.
- [ ] Use the PDB orientation.


- [ ] http://www.charmm-gui.org/?doc=input/membrane.bilayer&jobid=7604300295&project=membrane_bilayer
- [ ] http://www.charmm-gui.org/?doc=input/membrane.bilayer&jobid=7609535893&project=membrane_bilayer

# Step 02 - Determine the system size 

#Calculate Cross-Sectional Area

#System Size Determination Options:
- [ ] Heterogeneous Lipid
- [ ] 1. Box Type: Rectangular
- [ ] 2. Length of Z based on: Water thickness  (Minimum water height on top and bottom of the system)
- [ ] 3. Length of XY based on: Ratios of lipid components, POPE:POPG = 3:1 
- Further optimize by check Numbers of lipid components, and change numbers of lipids to eliminate any errors
- POPE: 143 139  Upperleaflet	Lowerleaflet 
- POPG: 48 46  Upperleaflet	Lowerleaflet 

#Results:
- Box Type	Rectangle
- Crystal Type	TETRAGONAL
- System Size	

A	120.581738	Dimension along the A (X) axis
B	120.581738	Dimension along the B (Y) axis
C	104.427824	Dimension along the C (Z) axis

-Crystal Angle	

Alpha	90.0	Angle between the axis B and C
Beta	90.0	Angle between the axis A and C
Gamma	90.0	Angle between the axis A and B

#of Lipids	

on Top	191
on Bottom	185
Z Center	
-2.77291175	 	Center of the system along the Z axis


# Step 03 - Build Components

- [ ] System Building Options:

- Replacement method	Build system using replacement method Check lipid ring (and protein surface) penetration

- [ ] Component Building Options:

- Include Ions : 0.15  M  NaCl (ion concentration) 

- Ion Placing Method: Monte-Carlo 


