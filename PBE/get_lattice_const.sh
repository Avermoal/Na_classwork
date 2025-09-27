#!bin/bash

#Создаёт график зависимости постоянной решётки от числа k-точек

for IBRION in 1 2; do

  for ENCUT in $(seq 100 50 500); do

    FIRST_SECOND_COLLUMN=$(cut -f 1 I${IBRION}_E${ENCUT}.dat)

    echo "$FIRST_SECOND_COLLUMN" >>lc_I${IBRION}_E${ENCUT}.dat

    sed -i '/-0.0000000000000001/d' lc_I${IBRION}_E${ENCUT}.dat
    sed -i '/0.0000000000000001/d' lc_I${IBRION}_E${ENCUT}.dat

    sed -i '1d' lc_I${IBRION}_E${ENCUT}.dat

  done

done

echo "set terminal pdf
set output 'lattice_consts.pdf'
set encoding iso_8859_1
set xlabel 'K-points'
set ylabel 'Lattice constant, {\305}'
set key right bottom
set key font 'Arial, 7'
plot 'lc_I1_E100.dat' w lp title 'IBRION = 1, ENCUT = 100', 'lc_I1_E150.dat' w lp title 'IBRION = 1, ENCUT = 150', 'lc_I1_E200.dat' w lp title 'IBRION = 1, ENCUT = 200', 'lc_I1_E250.dat' w lp title 'IBRION = 1, ENCUT = 250', 'lc_I1_E300.dat' w lp title 'IBRION = 1, ENCUT = 300', 'lc_I1_E350.dat' w lp title 'IBRION = 1, ENCUT = 350', 'lc_I1_E400.dat' w lp title 'IBRION = 1, ENCUT = 400', 'lc_I1_E450.dat' w lp title 'IBRION = 1, ENCUT = 450', 'lc_I1_E500.dat' w lp title 'IBRION = 1, ENCUT = 500', 'lc_I2_E100.dat' w lp title 'IBRION = 2, ENCUT = 100', 'lc_I2_E150.dat' w lp title 'IBRION = 2, ENCUT = 150', 'lc_I2_E200.dat' w lp title 'IBRION = 2, ENCUT = 200', 'lc_I2_E250.dat' w lp title 'IBRION = 2, ENCUT = 250', 'lc_I2_E300.dat' w lp title 'IBRION = 2, ENCUT = 300', 'lc_I2_E350.dat' w lp title 'IBRION = 2, ENCUT = 350', 'lc_I2_E400.dat' w lp title 'IBRION = 2, ENCUT = 400', 'lc_I2_E450.dat' w lp title 'IBRION = 2, ENCUT = 450', 'lc_I2_E500.dat' w lp title 'IBRION = 2, ENCUT = 500' " | gnuplot

rm -rf lc*.dat
