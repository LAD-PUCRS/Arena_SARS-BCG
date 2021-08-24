#!/bin/bash
PDBS_PATH=../2-ModelComplexByArenaDispatcher/dispatcher/output/selected_structures
PNGS_PATH=./output
PYMOL_BIN_PATH=pymol/bin
COUNT_PNGS=0

for PDB in `find $PDBS_PATH | grep pdb | sort`; do
	COMPLEX=`echo $PDB | sed -e 's/\// /g' -e 's/\./ /g' | awk '{print $5}'`
	HLA=`echo $COMPLEX | sed -e 's/-/ /g' | awk '{print $2}'`

	if [[ ! -f "$PNGS_PATH/HLA-$HLA/$COMPLEX.png" ]]; then
		#echo "$PNGS_PATH/HLA-$HLA/$COMPLEX.png not exists"
		#echo "PDB = $PDB"
		#echo "COMPLEX = $COMPLEX"
		#echo "HLA = $HLA"

		touch $PNGS_PATH/HLA-$HLA/$COMPLEX.png
		mkdir run_$$
		cd run_$$
		cp ../$PDB mol-orig.pdb
		../$PYMOL_BIN_PATH/pymol -c ../run.pml
		mv mol.png ../$PNGS_PATH/HLA-$HLA/$COMPLEX.png
		cd  ../
		rm -rf run_$$
		COUNT_PNGS=`expr $COUNT_PNGS + 1`
	fi
	echo
done

echo "$COUNT_PNGS png file created"
