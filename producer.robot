*** Settings ***

Library     RPA.Tables

Library     RPA.Database

Library     Collections

Library     RPA.Browser

Library     RPA.Robocloud.Items

Library     OperatingSystem




*** Variables ***
${fol1}=            C:/Users/mourya.dinesh/Desktop/pdf   




*** Tasks ***

main

    # Checking Column names

    Creating List




*** Keywords ***

Creating List

    ${list}=    Create List    ${fol1}   

 

    ${counter}=    Set Variable    0

    ${items}=    Create List

 

    FOR    ${i}    IN    @{list}

        ${counter}=    Evaluate    ${counter}+1

 

        ${paths}=    List Files In Directory    ${i}

 

        FOR    ${file}    IN    @{paths}

            Append To List    ${items}    ${i}/${file}

        END

    END

    FOR    ${j}    IN    @{items}

        ${Filep}=    Set Variable    ${j}

        ${dict}=    Create Dictionary    name=${Filep}

 

        Create Output Work Item    ${dict}    save=True

    END

    



    
   


