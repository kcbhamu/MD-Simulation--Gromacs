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
