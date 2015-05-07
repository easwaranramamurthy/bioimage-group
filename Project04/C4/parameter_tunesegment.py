import os
import numpy as np
import sys

def main():
	input_file = sys.argv[1]
	for K in [500,600,700,800,900,1000]:
		for minVal in [50,100,150,200]:
			for sigma in [0.5,1,1.5,2,2.5,3]:
				output = "output_sigma_" + str(sigma) + "_K" + str(K) + "_min" + str(minVal) + ".tif"
				command = "./segment "+str(sigma) +" "+ str(K) +" " + str(minVal) + " " + input_file + " " + output
				#print command
				os.system(command)
main()

