#!/usr/bin/env python3

#### Options/Params and Help menu ####
import argparse

params_list = argparse.ArgumentParser(description="A simple python script template",
                                      usage='script.py --file input.txt')
params_list.add_argument("-f", "--file", action="store",
                        type=str, required=True,
                        help="A input file")
params_list.add_argument("-t", "--threads", action="store",
                        type=int, default=1,
                        help="Number of threads")
params_list.add_argument("-v", "--verbose", action="store_true", 
                        help="In verbose mode")
params = params_list.parse_args()

#### Script required packages ####
import os
import sys

#### Main scrip starts here ####
print("The input file is -",params.file)
print("Number of threads -", params.threads)
