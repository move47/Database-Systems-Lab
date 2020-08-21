import pandas as pd
import numpy as np
## Reading the log file

log_df = pd.read_csv("input_log.txt",header= None)
immediate_df = log_df.iloc[:][:]
deferred_df = log_df.iloc[:][:]

## Traversing the log to get the UNDO_list, REDO_list and Checkpoint active Transaction list.

undo = []
redo = []
checkpoint_active_transaction = []

flag = 1
for x in range(0,log_df.shape[0],1):
	s = log_df[x:][:].values[0]
	s1 = np.array2string(s)
	
	if s1[2:12]=='Checkpoint':
		flag = 0
       
        
	## Checking for Undo List

	if s1[5:10]=='start':
		undo.append(s1[2:4])
		if flag == 1:
			checkpoint_active_transaction.append(s1[2:4])
	## Cheking for Redo List	
	elif s1[5:11]=='commit':
		redo.append(s1[2:4])
		undo.remove(s1[2:4])
		# If before checkpoint it commits then remove it from active transaction list.
		if flag == 1:
			checkpoint_active_transaction.remove(s1[2:4])
			redo.remove(s1[2:4])

print("Active Transaction list--> ",checkpoint_active_transaction[:])
print("undo list--> ",undo[:])
print("Redo list-->",redo[:])

## Now we have list of undo and redo transactions we will traverse the log again to do the recoverey
## For Immediate Update we will write new entries in the record, whereas for deferred update therewon't be any writing into log.
def last_index(s):
	for x in range(len(s)-1,-1,-1):
		if s[x]==' ':
			return x+1
def second_last_index(s):
	flag = 0
	for x in range(len(s)-1,-1,-1):
		if s[x]==' ':
			flag+=1
			if flag==2:
				return x+1

	
for x in range(0,log_df.shape[0],1):
	s = log_df[x:][:].values[0]
	s1 = np.array2string(s)
	
	if s1[5:6]=='W':
		if s1[2:4] in redo:
			immediate_df = immediate_df.append([["[NLE] "+s1[7:8]+":="+s1[last_index(s1):-2]+" is Written by "+s1[2:4]]],ignore_index=True)
			deferred_df = deferred_df.append([["[NLE] "+s1[7:8]+":="+s1[last_index(s1):-2]+" is Written by "+s1[2:4]]],ignore_index=True)	

		elif s1[2:4] in undo:
			 	immediate_df = immediate_df.append([[s1[2:4]+" "+s1[7:8]+" "+s1[second_last_index(s1):last_index(s1)-1]]],ignore_index=True)


			
## Now making <T_i, abort> entry into each of the undo transaction

for tr in undo:
	immediate_df = immediate_df.append([[tr+" "+"abort"]],ignore_index=True)



## Saving both the immediate and deferred logs as external .txt file    	
immediate_df.to_csv('immediate_update.txt', header=None, index=None)
deferred_df.to_csv('deferred_update.txt', header=None, index=None)


	 


