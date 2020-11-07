# This is details about how to use/define groups for further/customized results analysis

*Reference: http://manual.gromacs.org/documentation/2019/reference-manual/analysis/using-groups.html

Using Groups
In chapter Algorithms, it was explained how groups of atoms can be used in mdrun (see sec. The group concept). In most analysis programs, groups of atoms must also be chosen. Most programs can generate several default index groups, but groups can always be read from an index file. Let’s consider the example of a simulation of a binary mixture of components A and B. When we want to calculate the radial distribution function (RDF) gAB(r) of A with respect to B, we have to calculate:
(1)
4πr2gAB(r) = V ∑i∈ANA∑j∈BNBP(r)
where V is the volume and P(r) is the probability of finding a B atom at distance r from an A atom.
By having the user define the atom numbers for groups A and B in a simple file, we can calculate this gAB in the most general way, without having to make any assumptions in the RDF program about the type of particles.

Groups can therefore consist of a series of atom numbers, but in some cases also of molecule numbers. It is also possible to specify a series of angles by triples of atom numbers, dihedrals by quadruples of atom numbers and bonds or vectors (in a molecule) by pairs of atom numbers. When appropriate the type of index file will be specified for the following analysis programs. To help creating such index file index.ndx), there are a couple of programs to generate them, using either your input configuration or the topology. To generate an index file consisting of a series of atom numbers (as in the example of gAB), use gmx make_ndx or gmx select. To generate an index file with angles or dihedrals, use gmx mk_angndx. Of course you can also make them by hand. The general format is presented here:

[ Oxygen ]

   1       4       7

[ Hydrogen ]

   2       3       5       6
   8       9
First, the group name is written between square brackets. The following atom numbers may be spread out over as many lines as you like. The atom numbering starts at 1.

Each tool that can use groups will offer the available alternatives for the user to choose. That choice can be made with the number of the group, or its name. In fact, the first few letters of the group name will suffice if that will distinguish the group from all others. There are ways to use Unix shell features to choose group names on the command line, rather than interactively. Consult our webpage for suggestions.

Default Groups
When no index file is supplied to analysis tools or grompp, a number of default groups are generated to choose from:

System
all atoms in the system
Protein
all protein atoms
Protein-H
protein atoms excluding hydrogens
C-alpha
Cα atoms
Backbone
protein backbone atoms; N, Cα and C
MainChain
protein main chain atoms: N, Cα, C and O, including oxygens in C-terminus
MainChain+Cb
protein main chain atoms including Cβ
MainChain+H
protein main chain atoms including backbone amide hydrogens and hydrogens on the N-terminus
SideChain
protein side chain atoms; that is all atoms except N, Cα, C, O, backbone amide hydrogens, oxygens in C-terminus and hydrogens on the N-terminus
SideChain-H
protein side chain atoms excluding all hydrogens
Prot-Masses
protein atoms excluding dummy masses (as used in virtual site constructions of NH3 groups and tryptophan side-chains), see also sec. Virtual sites; this group is only included when it differs from the Protein group
Non-Protein
all non-protein atoms
DNA
all DNA atoms
RNA
all RNA atoms
Water
water molecules (names like SOL, WAT, HOH, etc.) See residuetypes.dat for a full listing
non-Water
anything not covered by the Water group
Ion
any name matching an Ion entry in residuetypes.dat
Water_and_Ions
combination of the Water and Ions groups
molecule_name
for all residues/molecules which are not recognized as protein, DNA, or RNA; one group per residue/molecule name is generated
Other
all atoms which are neither protein, DNA, nor RNA.
Empty groups will not be generated. Most of the groups only contain protein atoms. An atom is considered a protein atom if its residue name is listed in the residuetypes.dat file and is listed as a “Protein” entry. The process for determinding DNA, RNA, etc. is analogous. If you need to modify these classifications, then you can copy the file from the library directory into your working directory and edit the local copy.

Selections
gmx select
Currently, a few analysis tools support an extended concept of (dynamic) selections. There are three main differences to traditional index groups:
The selections are specified as text instead of reading fixed atom indices from a file, using a syntax similar to VMD. The text can be entered interactively, provided on the command line, or from a file.
The selections are not restricted to atoms, but can also specify that the analysis is to be performed on, e.g., center-of-mass positions of a group of atoms. Some tools may not support selections that do not evaluate to single atoms, e.g., if they require information that is available only for single atoms, like atom names or types.
The selections can be dynamic, i.e., evaluate to different atoms for different trajectory frames. This allows analyzing only a subset of the system that satisfies some geometric criteria.
As an example of a simple selection, resname ABC and within 2 of resname DEF selects all atoms in residues named ABC that are within 2nm of any atom in a residue named DEF.

Tools that accept selections can also use traditional index files similarly to older tools: it is possible to give an ndx file to the tool, and directly select a group from the index file as a selection, either by group number or by group name. The index groups can also be used as a part of a more complicated selection.

To get started, you can run gmx select with a single structure, and use the interactive prompt to try out different selections. The tool provides, among others, output options -on and -ofpdb to write out the selected atoms to an index file and to a pdb file, respectively. This does not allow testing selections that evaluate to center-of-mass positions, but other selections can be tested and the result examined.

The detailed syntax and the individual keywords that can be used in selections can be accessed by typing help in the interactive prompt of any selection-enabled tool, as well as with gmx help selections. The help is divided into subtopics that can be accessed with, e.g., help syntax/ gmx help selections syntax. Some individual selection keywords have extended help as well, which can be accessed with, e.g., help keywords within.

The interactive prompt does not currently provide much editing capabilities. If you need them, you can run the program under rlwrap.

For tools that do not yet support the selection syntax, you can use gmx select -on to generate static index groups to pass to the tool. However, this only allows for a small subset (only the first bullet from the above list) of the flexibility that fully selection-aware tools offer.

It is also possible to write your own analysis tools to take advantage of the flexibility of these selections: see the template.cpp file in the share/gromacs/template directory of your installation for an example.


### Reference: https://pythonhosted.org/fatslim/documentation/tutorials.html
### http://www.mdtutorials.com/gmx/complex/06_equil.html


7.5. Tutorial #4: Extracting raw APL data for further processing
Goal: Map the area per lipid from a membrane with a protein
Configuration file: bilayer_prot.gro
Atoms selected as headgroups: P8 (Phosphorus atom)
Protein atoms selected: All but hydrogen atoms (Protein-H default group from gmx make_ndx)
Index file: bilayer_prot.ndx
7.5.1. Index file
In this tutorial, we need to take into account protein atoms for area per lipid calculation. As for lipid headgroups, this involves gmx make_ndx:

Launch gmx make_ndx using bilayer_prot.gro as input file:
gmx make_ndx -f bilayer_prot.gro -o bilayer_prot.ndx
You should see the default groups GROMACS creates:

 0 System              : 26703 atoms
 1 Protein             :  1520 atoms
 2 Protein-H           :  1250 atoms
 3 C-alpha             :   160 atoms
 4 Backbone            :   480 atoms
 5 MainChain           :   645 atoms
 6 MainChain+Cb        :   805 atoms
 7 MainChain+H         :   805 atoms
 8 SideChain           :   715 atoms
 9 SideChain-H         :   605 atoms
10 Prot-Masses         :  1520 atoms
11 non-Protein         : 25183 atoms
12 Other               :  5824 atoms
13 POPC                :  5824 atoms
14 Water               : 19359 atoms
15 SOL                 : 19359 atoms
16 non-Water           :  7344 atoms
Note that, as a protein is present, the number of groups is greater than previously.

First, we will handle the lipid headgroups:
r POPC & a P8
and renamed the newly created group to the default name so we do not need to specify if with --hg-group:

name 17 headgroups
Then, we need to select the protein atoms we need to take into account we calculating area per lipid. In this tutorial, we will use only the heavy atoms but it is a good exercice to test other possibilities (all atoms, only the backbone, etc) to see how the selection affects the area per lipid calculation. In our case, the group of atoms is already defined (group 2) so we just need to rename it (once again this is just to avoid specifying --interacting-group:
name 2 protein
Optionally, it is also possible to "clean" our index file by deleting the groups we do not need before quitting gmx make_ndx:
del 0-1
del 1-14
When done, we now have bilayer_prot.ndx that contains only the two groups needed by FATSLiM.

7.5.2. Analysis
Because, we use the default names (headgroups and protein) for the atom groups, we do not need to specify them for FATSLiM to use the correct atom selection and the following command will suffise:

fatslim apl -c bilayer_prot.gro -n bilayer_prot.ndx --export-apl-raw bilayer_prot_apl.csv
This will create a file name bilayer_prot_apl_frame_00000.csv.

Note

As previously, the frame index (starting from 0) is appended to the filename as one csv file is created per frame. Hence bilayer_prot_apl_0000.csv instead of bilayer_prot_apl.csv

For illustration, here are the first lines of the file:

resid,leaflet,X coords,Y coords,Z coords,Area per lipid
161,lower leaflet,1.737,0.835,2.436,0.788
162,lower leaflet,0.849,5.330,2.425,0.652
163,lower leaflet,0.311,4.747,2.344,0.641
164,lower leaflet,1.307,1.249,2.289,0.858
165,lower leaflet,1.399,6.094,2.365,0.676
166,lower leaflet,1.932,6.810,2.461,0.670
167,lower leaflet,1.512,0.350,2.489,0.748
168,lower leaflet,4.374,4.422,2.546,0.746
169,lower leaflet,4.333,5.112,2.494,0.796
7.5.3. Further analysis
As you can see, bilayer_prot_apl_frame_00000.csv contains all the information we need to create a map with all the area per lipid values. To actually create this map, we will use a Python script based on Matplotlib.

Writing this script is not directly related to FATSLim and is thus beyond the scope of this tutorial, this is why it will not be discussed here. Nonetheless, it is an example of post-processing that can be achieved using FATSLiM raw results.

You download the script here or just take a look at its content:

show_apl_map.py¶
 1
 2
 3
 4
 5
 6
 7
 8
 9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
#!/usr/bin/env python
# -*- coding: utf8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import griddata

CSV_FILENAME = "bilayer_prot_apl_frame_00000.csv"
GRO_FILENAME = "bilayer_prot.gro"
PNG_FILENAME = "bilayer_prot_apl_frame_00000.png"

# Get Box vectors
last_line = ""
with open(GRO_FILENAME) as fp:
    for line in fp:
        line = line.strip()

        if len(line) == 0:
            continue

        last_line = line

box_x, box_y = [float(val) for val in line.split()[:2]]

# Get values
membrane_property = "Area per lipid"
x_values = []
y_values = []
z_values = []
property_values = []
with open(CSV_FILENAME) as fp:
    for lino, line in enumerate(fp):
        if lino == 0:
            membrane_property = line.split(",")[-1].strip()

        else:
            line = line.strip()

            if len(line) == 0:
                continue

            resid, leaflet, x, y, z, value = line.split(",")

            x_values.append(float(x))
            y_values.append(float(y))
            property_values.append(float(value))

# Building data from plotting
grid_x, grid_y = np.mgrid[0:box_x:50j, 0:box_y:50j]
points = np.stack((np.array(x_values).T, np.array(y_values).T), axis=-1)
values = np.array(property_values)
grid = griddata(points, values, (grid_x, grid_y), method='cubic')

# Plot map
plt.contourf(grid_x, grid_y, grid)
cbar = plt.colorbar()

plt.title(membrane_property)
plt.xlabel("Box X (nm)")
plt.ylabel("Box Y (nm)")

plt.tight_layout()
plt.savefig(PNG_FILENAME)

and the generated figure:

../_images/bilayer_prot_apl.png
with the protein added:

../_images/bilayer_prot_apl2.png
