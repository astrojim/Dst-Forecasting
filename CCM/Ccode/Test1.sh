#1/bin/sh
./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 1 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI1.dat -eY PAItestingAB_eY_PAI1.dat -PAI
./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 2 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI2.dat -eY PAItestingAB_eY_PAI2.dat -PAI
./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 3 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI3.dat -eY PAItestingAB_eY_PAI3.dat -PAI
echo "AB; Ey = 1,2,3; Correlation" 
cat PAItestingAB_out_PAI1.dat PAItestingAB_out_PAI2.dat PAItestingAB_out_PAI3.dat 

./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 1 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI1a.dat -eY PAItestingAB_eY_PAI1.dat -PAI -L2
./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 2 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI2a.dat -eY PAItestingAB_eY_PAI2.dat -PAI -L2
./PAI -E 3 -t 1 -L 2000 -n 1 -Ey 3 -ty 1 -f PAItesting_A2.60_B2.60.dat -o PAItestingAB_out_PAI3a.dat -eY PAItestingAB_eY_PAI3.dat -PAI -L2
echo "AB; Ey = 1,2,3; L2" 
cat PAItestingAB_out_PAI1a.dat PAItestingAB_out_PAI2a.dat PAItestingAB_out_PAI3a.dat 
