*** Settings ***
Documentation        Battery Patch pdf file data extraction. 
...                  A folder contains some Files needs to extract the data from the each file.
...                  Needs to find whether the file in the folder is a PDF Extension or not.
...                  If it is a PDF File, find the size of each file.
...                  After confirming the size of each file, iterate the files from a folder and extract the data from each folder

Library    task.py
Library    task copy.py
Library    RPA.PDF
Library    XML
Library    RPA.FileSystem
Library    RPA.Dialogs
Library    String
Library    RPA.Tables
Library    RPA.Excel.Files
Library    Collections
Library    RPA.Outlook.Application

*** Variables ***
@{heading}   version type   MAC
@{rows}      ${heading}
${countr}=    0


*** Tasks ***
Battery Patch pdf file data extraction
    TRY
                Create Workbook    C:/Users/mourya.dinesh/Documents/python bot/op.xlsx
                ${PDF}=    validate the input files
               FOR    ${files}    IN    @{PDF}
                       check tha correct path    ${files} 
                      check wheather it is a pdf or not    ${files}
                     check the lenght of pdf    ${files}
                      validate text from pdf and extract data    ${files}
                      #Read input tables data from pdf file    ${files}
                      ${result}=    extract text data from pdf and import to Excel    ${files}    
                     convert the pdf to text file    ${files}
                     Append to file    ${result}    ${files}
                END      
    
        
    EXCEPT   
        Log    "pdf file not found"
        
    END
#sending mails
    #Send Message    putta.rakesh@yash.com    sfdid    lsf    
*** Keywords ***
validate the input files
...    ${PDF}=    List Files In Directory       C:/Users/mourya.dinesh/Desktop/pdf
        Log    ${PDF}

        RETURN    ${PDF}
check tha correct path
    [Arguments]    ${files}
    ${st}=  Normalize Path    ${files}  

check wheather it is a pdf or not
    [Arguments]    ${files}
    ${var}=    Get File Extension    ${files}
    Log    ${var}
check the lenght of pdf
    [Arguments]    ${files}
         ${length}=    Get Length    ${files}
      Log    ${length}
validate text from pdf and extract data 
    [Arguments]    ${files}
         ${text}=    Get Text From Pdf    ${files}    trim=False
        Log    ${text}
        [Return]    ${text}
Read input tables data from pdf file
    [Arguments]    ${files}
    ${pdf_output}=    ReadpdfFile    ${files}
    Log    ${pdf_output}
    Log    ${files}
    [Return]     ${pdf_output}
         
extract text data from pdf and import to Excel
    [Arguments]    ${files}
    ${result}=    Pdfreader    ${files}
    ${output}=    Get File Name    ${files}
    ${output}=    Split String    ${output}    separator=SWI
    ${result1}=    Create Dictionary
                ...    version=${result}[0]
                ...    Mac_id=${result}[1]                          
    #Create Worksheet    ${output}[1] 
    Set Worksheet Value    1    1    Name 
    Set Worksheet Value    1    2    ID'S           
    Append Rows To Worksheet    ${result1}
    save Workbook    C:/Users/mourya.dinesh/Documents/python bot/op.xlsx
    RETURN    ${result}   
convert the pdf to text file
    [Arguments]    ${file_name}
    ${text}=    Create File
    ...    ${file_name}.txt
    ...    overwrite=${True}
Append to file    
    [Arguments]    ${list}    ${file_name}
    FOR    ${ele}    IN    @{list}
            RPA.FileSystem.Append To File    ${file_name}.txt    ${ele}+"\n" 
            Log    ${list}     
    END

    



    
   


