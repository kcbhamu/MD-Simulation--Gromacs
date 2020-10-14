### How to edit PDB file using python:

#### Working with PDB Structures in DataFrames

- http://rasbt.github.io/biopandas/tutorials/Working_with_PDB_Structures_in_DataFrames/
- https://github.com/harmslab/pdbtools



### How to replace line in pdb file with pattern: 

```sh
sed 's/ X / A /' PnuC_3NR_500ns_Frame000.pdb

```

### Identify Chains by Atom numbers for PnuC:

```sh
awk '{
if ($2 <=3822) sub(/ X /," A ");
else if ($2 > 3822 && $2 <= 7644) sub(/ X /," B ");
else if ($2 > 7644 && $2 <= 11490) sub(/ X /," C ");
}1' PnuC_3NR_500ns_Frame000test.pdb 

 ```
 
 
### Identify Chains by residue number for any proteins:

```sh
awk '{
resn=0;
if ($6 > $resn) sub(/ X /," A ");
print $6;
else sub(/ X /," B ");
resn=$6;
}1' PnuC_3NR_500ns_Frame000test.pdb 

 ```
