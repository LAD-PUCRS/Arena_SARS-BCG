import sys
import os



print("This is Job",sys.argv[1])
with open('./output_%s.txt' % (sys.argv[1]),'w') as file:
	file.write("Result of Job "+sys.argv[1])
