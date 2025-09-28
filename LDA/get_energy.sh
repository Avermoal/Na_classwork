#!bin/bash

#Создаёт график зависимости энергии от числа k-точек

for IBRION in 1 2; do

  for ENCUT in $(seq 100 50 500); do

    FT_C=$(awk '{ print $1, $3}' I${IBRION}_E${ENCUT}.dat)

    echo "$FT_C">> e_I${IBRION}_E${ENCUT}.dat

    sed -i '1d' e_I${IBRION}_E${ENCUT}.dat

  done

done

echo "set terminal pdf
set output 'energy.pdf'
set xlabel 'K-points'
set ylabel 'Energy, mJ'
set key right bottom
set key font 'Arial, 7'
plot 'e_I1_E100.dat' w lp title 'IBRION = 1, ENCUT = 100', 'e_I1_E150.dat' w lp title 'IBRION = 1, ENCUT = 150', 'e_I1_E200.dat' w lp title 'IBRION = 1, ENCUT = 200', 'e_I1_E250.dat' w lp title 'IBRION = 1, ENCUT = 250', 'e_I1_E300.dat' w lp title 'IBRION = 1, ENCUT = 300', 'e_I1_E350.dat' w lp title 'IBRION = 1, ENCUT = 350', 'e_I1_E400.dat' w lp title 'IBRION = 1, ENCUT = 400', 'e_I1_E450.dat' w lp title 'IBRION = 1, ENCUT = 450', 'e_I1_E500.dat' w lp title 'IBRION = 1, ENCUT = 500', 'e_I2_E100.dat' w lp title 'IBRION = 2, ENCUT = 100', 'e_I2_E150.dat' w lp title 'IBRION = 2, ENCUT = 150', 'e_I2_E200.dat' w lp title 'IBRION = 2, ENCUT = 200', 'e_I2_E250.dat' w lp title 'IBRION = 2, ENCUT = 250', 'e_I2_E300.dat' w lp title 'IBRION = 2, ENCUT = 300', 'e_I2_E350.dat' w lp title 'IBRION = 2, ENCUT = 350', 'e_I2_E400.dat' w lp title 'IBRION = 2, ENCUT = 400', 'e_I2_E450.dat' w lp title 'IBRION = 2, ENCUT = 450', 'e_I2_E500.dat' w lp title 'IBRION = 2, ENCUT = 500' " | gnuplot

rm -rf e_*.dat
