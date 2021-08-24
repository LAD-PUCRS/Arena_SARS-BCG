#!/usr/bin/env python
# coding: utf-8
from subprocess import call
call(["pdb2pqr --ff=AMBER --chain mol.pdb mol.pqr"], shell=True)
call(["apbs ../apbs.in"], shell=True)