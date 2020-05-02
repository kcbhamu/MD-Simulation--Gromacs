# How to use by command lines

## How to show ligand molecule in Stick
```
show sphe, resn LIG
show stick, resn LIG
set sphere_scale, 0.3
label resin LIG, name
```
Or in this way
```
bg_color white
select lig, segid HETA
zoom lig
set sphere_scale, 0.3
show spheres, lig
label lig, name

hide cartoon
get_view


```
