from PyPDF2 import PdfFileReader

import os

import shutil

def  pdfreader(folder_name):
   fileOpen = open(folder_name, "rb")
   reader = PdfFileReader(fileOpen)
   dict1 = reader.getFields()
   newStr = str(dict1).replace("/", "")
   #print(newStr)
   dict1 = {k.lower(): v for k, v in dict1.items()}
   Result1 = dict1['version type'].get('/V')
   names_list= ["Version Type:"]
   print(Result1)
   newStr = str(Result1).replace("/", "")
   mac_address_list= [newStr]
   b = 1
   for j in dict1.items():
     if ('mac-' + str(b)) in dict1.keys():
        if dict1['mac-' + str(b)].get('/V'):
            names_list.append(dict1['mac-' + str(b)].get('/T') + ":")
            mac_address = (dict1['mac-' + str(b)].get('/V'))
            mac_address_list.append(mac_address)
            
     b += 1
   return(names_list,mac_address_list)

if __name__ == "__main__":
    result= pdfreader()
    
 

