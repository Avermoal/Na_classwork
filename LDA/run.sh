#!/bin/bash

#Запуск осуществлять после выполнения chmod +x run.sh
#С помощью комманды nohup ./run.sh &


#Считает постоянную решётки металла с учётом параметров сходимости и вида потенциала для пармаетра IBRION = 1, 2.
#Записывает результат расчёта при конкретных энергиях в зависимости от числа к-точек
#в файл с расширением .dat и названием вида I(IBRION)_E(ENCUT). I()_E().dat

#INCAR:
#Comment
#ENCUT =
#ISIF = 3
#IBRION =
#NSW = 100
#LVTOT = .TRUE.
#LVHAR = .TRUE.

vasp_std="mpirun -np 4 vasp6_std > log.txt"
LATTICE_CONST=0
E0=0

for IBRION in 1 2
do
	sed -i "4c\ IBRION = $IBRION" INCAR
	for ENCUT in $(seq 100 50 500)
	do
		echo "k lattice_const E0" > I${IBRION}_E${ENCUT}.dat
		sed -i "2c\ ENCUT = $ENCUT" INCAR
		for K_POINTS in $(seq 3 2 13)
		do
			sed -i "4c\ $K_POINTS $K_POINTS $K_POINTS" KPOINTS
			wait
			$vasp_std

			HLC_1=$(awk 'NR==3 {print $1}' CONTCAR)
			HLC_2=$(awk 'NR==3 {print $2}' CONTCAR)
			HLC_3=$(awk 'NR==3 {print $3}' CONTCAR)
            
			if [ $(echo ""$HLC_1" != 0.0" | bc) -eq 1 ]; then
				LATTICE_CONST=$HLC_1
			fi
			if [ $(echo ""$HLC_2" != 0.0" | bc) -eq 1 ]; then
				LATTICE_CONST=$HLC_2
			fi
			if [ $(echo ""$HLC_3" != 0.0" | bc) -eq 1 ]; then
				LATTICE_CONST=$HLC_3
			fi
			
			E0=$(tail -n 1 OSZICAR | awk '{print $5}')

			echo "$K_POINTS $LATTICE_CONST $E0" >> I${IBRION}_E${ENCUT}.dat
		done
	done
done
