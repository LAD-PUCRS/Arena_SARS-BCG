#!/bin/bash
for proc in 48 42 40 32 24 20 18 12 8 6 4 2; do
	echo "iniciando teste paralelo com $proc processos e 517 complexos"
	mkdir teste_517complexes_parallel$proc-Pantanal
	rm -rf saves/*
	time ./run_parallel.sh $proc
	mv process* teste_517complexes_parallel$proc-Pantanal
	echo
	echo
done
echo "iniciando teste sequencial com 517 complexos"
mkdir teste_517complexes_sequential-Pantanal
rm -rf saves/*;
time ./run.sh &> teste_517complexes_sequential-Pantanal/sequential.log
echo
echo