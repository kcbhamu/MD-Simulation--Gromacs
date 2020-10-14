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
 
 
```sh
resn=0;
awk '{
resn=$6;
print resn;
}' PnuC_3NR_500ns_Frame000test.pdb 
echo $resn;
 ```

### Using script

```sh
#!/bin/bash
filename=$1;
n=0;
while read line; do
awk '{
if ($6 > $n) sub(/ X /," A ");
} $line
done < $filename
```

- How to run

```sh
bash ChangeChainID.sh PnuC_3NR_500ns_Frame000test.pdb
```

```sh
#!/bin/bash

while IFS='=' read -r col1 col2
do 
    echo "$col1"
    echo "$col2"
done < PnuC_3NR_500ns_Frame000test.pdb
``` 
