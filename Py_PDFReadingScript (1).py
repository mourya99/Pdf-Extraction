#Process Name		: GSP-Battery Patch BO Management
#Script Objective	: Script will convert all pdf files to txt files with the same name in input folder
#Devloper		: C Balakrishna Reddy
#Created Date		: 31/10/2022
#Version		: 1.0
#Version History	: Initial file

from PyPDF2 import PdfFileReader
import os
import sys


def reading_data(dir_path):
    
	#Looping throught each file in the folder
    for eachfile in os.listdir(dir_path):
        outputfile = ""
        newStr = ""
        #Process only pdf files and skip any others file which comes
        if eachfile.endswith(".pdf"):
            try:
                absfile = os.path.join(dir_path, eachfile)                
                #Check if current path is a file
                if os.path.isfile(absfile):
                    
					#Creating .txt filename
                    v1 = eachfile.rsplit(".pdf",1)
                    outputfile = v1[0] + ".txt"
                    fileOpen = open(absfile, "rb")
                    
					#Reading the PDF content
                    pdf_reader = PdfFileReader(fileOpen)
                    dict1 = pdf_reader.getFields()                    
                    newStr = str(dict1).replace("/", "")
                    absoutputfile = os.path.join(dir_path, outputfile)
                    
					#Writing the PDF text to txt file with same file name as pdf file
                    with open(absoutputfile, 'w') as f:
                        f.write(str(newStr))
                        f.write('\n')                        
                    fileOpen.close()
            except Exception as exception:
                
				#Writing the exception to txt file with same file name as pdf file
                with open(absoutputfile, 'w') as f:
                    f.write(str(exception))
                    f.write('\n')
                fileOpen.close()
    print("Successfully Completed.")
if __name__ == "__main__":
    reading_data()