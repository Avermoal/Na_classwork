#!bin/bash

#Создаёт график зависимости постоянной решётки от числа k-точек

for IBRION: 1 2
do

  for ENCUT: seq(100 50 500)
  do

    FIRST_COLLUMN=$(cut -f 1 I${IBRION}_E${ENCUT}.txt)
    SECOND_COLLUMN=$(cut -f 2 I${IBRION}_E${ENCUT}.txt)

    echo "$FIRST_COLLUMN  $SECOND_COLLUMN" >> lc_I${IBRION}_E${ENCUT}.dat

  done

done

for IBRION: 1 2
do

  for ENCUT: seq(100 50 500)
  do

     lc_I${IBRION}_E${ENCUT}.dat

  done

done



rm -rf I*.dat
