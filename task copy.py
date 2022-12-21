from PyPDF2 import PdfFileReader
try:

    from robot.libraries.BuiltIn import BuiltIn

    from robot.libraries.BuiltIn import _Misc

    import robot.api.logger as logger

    from robot.api.deco import keyword

    ROBOT = False

except Exception:

    ROBOT = False


def ReadpdfFile(n):
    fileOpen = open(n, "rb")
    reader = PdfFileReader(fileOpen)
    dict1 = reader.getFields() 
    newStr = str(dict1).replace("/", "")
    #print(newStr)
    return newStr
    
 

