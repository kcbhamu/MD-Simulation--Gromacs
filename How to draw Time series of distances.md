### Reference: 

https://ctlee.github.io/BioChemCoRe-2018/distance-analysis/

https://becksteinlab.physics.asu.edu/pages/courses/2017/PHY542/practicals/md/dynamics/distances.html


.. -*- coding: utf-8 -*-

===================
Measuring distances
===================

Measure distances interactively
===============================

  
* '2' (or :menuselection:`Mouse --> Label --> Bonds`)
* click tip of LID and tip of NMP domain
* play the trajectory: label changes dynamically
* If you want to change the color of the dashed line that connects two
  atoms, use :menuselection:`Graphics --> Colors`, under
  :guilabel:`Categories` select *Labels* and for :guilabel:`Names`
  select *Bonds* and pick a :guilabel:`Colors`.

Time series of distances
========================

* :menuselection:`Graphics --> Labels`
  - :guilabel:`Atoms`: select *Bonds*
  - select (highlight) bond in bond list widget
  - tab :guilabel:`Graph` (Show preview, click on bond)
  - :guilabel:`Graph...` to plot the distance as a function of time

* try different distances between residues (use the CA) and plot together:
  which change, which don't?
  
  - What would be good distances to report on conformational changes,
    e.g. for FRET_?  

  - Try also [Beckstein2009]_

    - I52-K145
    - A55-V169
    - A127-A194

.. _FRET: http://en.wikipedia.org/wiki/F%C3%B6rster_resonance_energy_transfer

Advanced: setting labels with Tcl commands
==========================================

VMD comes with a full-blown scripting language, namely Tcl_ with
VMD-specific extensions (which are described in the `VMD Users
Guide`_).

These commands are entered as **text commands** on the Tcl command
line. Open :menuselection:`Extensions --> Tk console`. 

The `label`_ command has the syntax for adding a new *Bonds*

.. code-block:: tcl

   label add Bonds $molID1/$atomID1 $molID2/$atomID2

where ``$molID`` refers to the molecule number (e.g., ``0``) and
``$atomID`` is the internal atom index that VMD assigns to each
atom. Getting this atom index is a bit convoluted and uses the
atomselect_ command. In the following example, we create a bond
distance between the CB atoms of residues Ile52 and Lys145:

.. code-block:: tcl

   set molID1 0
   set molID2 0
   set atomID1 [[atomselect $molID1 "protein and resid 52 and name CB"] list]
   set atomID2 [[atomselect $molID2 "protein and resid 145 and name CB"] list]

   # show the atom indices (optional)
   puts "Ile 52 CB:  $atomID1"
   puts "Lys 145 CB: $atomID2"

   # create the label
   label add Bonds $molID1/$atomID1 $molID2/$atomID2

The bond label between I52 and K145 should appear now. 

.. _Tcl: https://tcl.tk/
.. _`VMD Users Guide`:
   http://www.ks.uiuc.edu/Research/vmd/current/ug/ug.html
.. _label: http://www.ks.uiuc.edu/Research/vmd/current/ug/node133.html
.. _atomselect: http://www.ks.uiuc.edu/Research/vmd/current/ug/node122.html
