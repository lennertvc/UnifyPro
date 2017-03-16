#tag Class
Protected Class PreProcessor
	#tag Method, Flags = &h0
		Function collectProjects() As Dictionary()
		  // (sniffer van Lennert)
		  Dim rootFolder As FolderItem
		  dim aFilePath() as string
		  Dim aMyDictionary() As Dictionary
		  rootFolder = SelectFolder
		  
		  If rootFolder<> Nil Then
		    dim oPathFinder as new LVCPathFinder
		    dim oProgramFinder as new JVPathFind
		    dim aResult() as FolderItem
		    dim aBackupFile() as FolderItem
		    
		    oPathFinder.basefolder = rootFolder
		    aResult=oPathFinder.findFile("huidig")
		    
		    for index10 as integer = 0 to aResult.Ubound
		      oProgramFinder.baseFolder=aResult(index10)
		      aBackupfile=oProgramFinder.findFile("stu")
		      for index11 as integer=0 to aBackupFile.Ubound
		        aBackupFile(index11).copyfileto  versionFolder
		        aFilePath.append(aBackupFile(index11).NativePath)
		        
		        dim myDictionary as new Dictionary
		        myDictionary.value("file_path")=aBackupFile(index11).NativePath
		        myDictionary.value("file_name")=aBackupFile(index11).Name
		        
		        Dim re As New RegEx
		        dim match as RegExMatch
		        dim matchString as string
		        re.SearchPattern = "([a-z]+)? ?-?([a-z]+)? ?-?([a-z]+)? ?-?([a-z]+)? ?-?([a-z]+) - [0-9]{4}"
		        match = re.Search(aFilepath(aFilepath.Ubound))
		        matchString=match.SubExpressionString(0)
		        Dim value As String = matchString
		        
		        myDictionary.value("file_KP")=value.Right(4)
		        myDictionary.value("file_RWZI")=value.Replace(value.Right(7),"")
		        myDictionary.value("file_folderitem")=aBackupFile(index11)
		        aMyDictionary.append(myDictionary)
		      next
		    next
		  End If
		  
		  return aMyDictionary()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  
		  dim deleter as new DeleteFolderContent
		  
		  dim sourceFolderParent as folderitem =  SpecialFolder.ApplicationData.child("UnifyPro")
		  if  sourceFolderParent = nil or not sourceFolderParent.Exists then
		    sourceFolderParent.CreateAsFolder
		  end if
		  
		  sourceFolder =  SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects")
		  call deleter.DeleteEntireFolder(sourcefolder)
		  if  sourceFolder = nil or not sourceFolder.Exists then
		    sourceFolder.CreateAsFolder
		  end if
		  
		  exportedSectionsFolder =  SpecialFolder.ApplicationData.child("UnifyPro").Child("UnitySectionsExport")
		  call deleter.DeleteEntireFolder(exportedSectionsFolder)
		  if  exportedSectionsFolder = nil or not exportedSectionsFolder.Exists then
		    exportedSectionsFolder.CreateAsFolder
		  end if
		  
		  versionFolder =  SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityVersion")
		  call deleter.DeleteEntireFolder(versionFolder)
		  if  versionFolder = nil or not versionFolder.Exists then
		    versionFolder.CreateAsFolder
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convertCode(arrayOriginalCode() as string) As Dictionary()
		  dim hulp,hulpstring,backuphulp as string
		  dim SR_Beluchting as Boolean
		  dim arrayCleanedUpCode() as string 
		  Dim aMyDictionary() As Dictionary
		  
		  
		  for i as integer = 0 to arrayOriginalCode.ubound
		    
		    hulp=arrayOriginalCode(i)
		    Dim re As New RegEx
		    dim hulpkarakter as new RegExMatch
		    
		    re.SearchPattern = "\t"
		    re.ReplacementPattern = " "
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "WHILE\("
		    re.ReplacementPattern = "WHILE ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\)AND"
		    re.ReplacementPattern = ") AND"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\)DO"
		    re.ReplacementPattern = ") DO"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\)OR"
		    re.ReplacementPattern = ") OR"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\)NOT"
		    re.ReplacementPattern = ") NOT"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\)THEN"
		    re.ReplacementPattern = ") THEN"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "IF\("
		    re.ReplacementPattern = "IF ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "ELSIF\("
		    re.ReplacementPattern = "ELSIF ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "RE\("
		    re.ReplacementPattern = "RE ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "FE\("
		    re.ReplacementPattern = "FE ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "SET\("
		    re.ReplacementPattern = "SET ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "RESET\("
		    re.ReplacementPattern = "RESET ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "DEC_INT\("
		    re.ReplacementPattern = "DEC_INT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INC_INT\("
		    re.ReplacementPattern = "INC_INT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "ROL_ARINT\("
		    re.ReplacementPattern = "ROL_ARINT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "ROR_ARINT\("
		    re.ReplacementPattern = "ROR_ARINT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "SUM_ARINT\("
		    re.ReplacementPattern = "SUM_ARINT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "AND\("
		    re.ReplacementPattern = "AND ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "NOT\("
		    re.ReplacementPattern = "NOT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "OR\("
		    re.ReplacementPattern = "OR ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "REAL_TO_INT\("
		    re.ReplacementPattern = "REAL_TO_INT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INT_TO_REAL\("
		    re.ReplacementPattern = "INT_TO_REAL ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "DINT_TO_INT\("
		    re.ReplacementPattern = "DINT_TO_INT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INT_TO_DINT\("
		    re.ReplacementPattern = "INT_TO_DINT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INOUT\("
		    re.ReplacementPattern = "INOUT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "MOVE_INT_AREBOOL\("
		    re.ReplacementPattern = "MOVE_INT_AREBOOL ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "MOVE_INT_ARINT\("
		    re.ReplacementPattern = "MOVE_INT_ARINT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "_"
		    re.ReplacementPattern = ""
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ":=\s+"
		    re.ReplacementPattern = ":="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s+:="
		    re.ReplacementPattern = ":="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "(\s)+;"
		    re.ReplacementPattern = ";"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ";+"
		    re.ReplacementPattern = ";"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(\s+"
		    re.ReplacementPattern = "("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s+\)"
		    re.ReplacementPattern = ")"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    //re.SearchPattern = "\(\*[^\(\*]+\*\)"
		    //re.ReplacementPattern = " "
		    //re.Options.ReplaceAllMatches = True
		    //hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(\*.[^\*\(]+\*\)"
		    re.ReplacementPattern = " "
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "[\n\r]+"
		    re.ReplacementPattern = " "
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    backuphulp=hulp
		    re.SearchPattern = "Ba[a-z]+"
		    hulpkarakter=re.search(hulp)
		    SR_beluchting=hulpkarakter <> nil
		    
		    
		    if not SR_beluchting then
		      re.SearchPattern = "\<\?xml.*\</identProgram\>"
		      re.ReplacementPattern = ""
		      re.Options.ReplaceAllMatches = True
		      hulp=re.Replace(hulp)
		    else
		      re.SearchPattern = "\</program\>(\s)+\<program\>.*"
		      re.ReplacementPattern = ""
		      re.Options.ReplaceAllMatches = true
		      hulp=re.Replace(hulp)
		      
		      re.SearchPattern = "\<\?xml.*\</identProgram\>"
		      re.ReplacementPattern = ""
		      re.Options.ReplaceAllMatches = true
		      hulp=re.Replace(hulp)
		      
		      re.SearchPattern = "Ba[a-z]+" 
		      hulpkarakter=re.search(hulp)
		      if hulpkarakter <> nil then
		        hulp=backuphulp
		        re.SearchPattern = "IF NOT Bavropvt.+\<program\>"
		        re.ReplacementPattern = ""
		        re.Options.ReplaceAllMatches = true
		        hulp=re.Replace(hulp)
		        
		        re.SearchPattern = "\<\?xml.*\</identProgram\>"
		        re.ReplacementPattern = ""
		        re.Options.ReplaceAllMatches = true
		        hulp=re.Replace(hulp)
		      end if
		      
		    end if
		    
		    re.SearchPattern = "\(\*"
		    re.ReplacementPattern = "µ"
		    re.Options.greedy = False
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\*\)"
		    re.ReplacementPattern = "ç"
		    re.Options.greedy = False
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "µ.[^µç]+ç"
		    re.ReplacementPattern = " "
		    re.Options.greedy = False
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "µ.[^µç]+ç"
		    re.ReplacementPattern = " "
		    re.Options.greedy = False
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "µ.[^µç]+ç"
		    re.ReplacementPattern = " "
		    re.Options.greedy = False
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s{2,}"
		    re.Options.greedy = True
		    re.ReplacementPattern = " "
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ";\s"
		    re.ReplacementPattern = ";"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "&lt;"
		    re.ReplacementPattern = "<"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "&gt;"
		    re.ReplacementPattern = ">"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ";"
		    re.ReplacementPattern = ";\n"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\<.[^\(\)\;]+\>"
		    re.ReplacementPattern = ""
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s<"
		    re.ReplacementPattern = "<"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "<\s"
		    re.ReplacementPattern = "<"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s>"
		    re.ReplacementPattern = ">"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ">\s"
		    re.ReplacementPattern = ">"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s<="
		    re.ReplacementPattern = "<="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "<=\s"
		    re.ReplacementPattern = "<="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s>="
		    re.ReplacementPattern = ">="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ">=\s"
		    re.ReplacementPattern = ">="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s\+"
		    re.ReplacementPattern = "+"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\+\s"
		    re.ReplacementPattern = "+"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s-"
		    re.ReplacementPattern = "-"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "-\s"
		    re.ReplacementPattern = "-"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s\*"
		    re.ReplacementPattern = "*"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\*\s"
		    re.ReplacementPattern = "*"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = ",\s"
		    re.ReplacementPattern = ","
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s,"
		    re.ReplacementPattern = ","
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s:"
		    re.ReplacementPattern = ":"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s:"
		    re.ReplacementPattern = ":"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s/"
		    re.ReplacementPattern = "/"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "/\s"
		    re.ReplacementPattern = "/"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\s="
		    re.ReplacementPattern = "="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "=\s"
		    re.ReplacementPattern = "="
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(([a-z0-9\*/\<\>\-/:=+.]*)\)"
		    re.ReplacementPattern = "\1"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(([a-z0-9\*/\<\>\-/:=+.]*)\)"
		    re.ReplacementPattern = "\1"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(([a-z0-9\*/\<\>\-/:=+.]*)\)"
		    re.ReplacementPattern = "\1"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "\(([a-z0-9\*/\<\>\-/:=+.]*)\)"
		    re.ReplacementPattern = "\1"
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    dim match as RegExMatch
		    dim aresult() as string  
		    
		    re.SearchPattern = " ?L[0-9]{1,}:[^=]"
		    match = re.Search(hulp)
		    
		    Do
		      If match <> Nil Then
		        aresult.append(match.SubExpressionString(0))
		      end if   
		      match=re.search
		    Loop Until match Is Nil
		    
		    if aresult.Ubound>0 then
		      
		      dim hulp2 as string
		      for index1 as integer = 0 to aResult.Ubound
		        hulp2=replace(aresult(index1),":","")
		        hulp2=trim(hulp2)
		        re.SearchPattern = hulp2
		        re.Options.ReplaceAllMatches = True
		        re.ReplacementPattern = "L10"+str(index1)
		        hulp=re.Replace(hulp)
		      next
		      
		    end if
		    
		    hulp=hulp.RTrim
		    hulp=hulp.LTrim
		    hulp=hulp.Lowercase
		    
		    dim regelingIndex as string = ""
		    regelingIndex= mid(hulp,InStr(hulp, "sime")-2,2)
		    if regelingIndex <>"" then
		      re.SearchPattern = "\b"+regelingindex+"([a-z0-9]{2,})\b"
		      re.ReplacementPattern = "\1"
		      re.Options.ReplaceAllMatches = True
		      hulp=re.Replace(hulp)
		    end if
		    if regelingIndex ="" then
		      regelingIndex= mid(hulp,InStr(hulp, "vropvt")-2,2)
		      re.SearchPattern = "\b"+regelingindex+"([a-z0-9]{2,})\b"
		      re.ReplacementPattern = "\1"
		      re.Options.ReplaceAllMatches = True
		      hulp=re.Replace(hulp)
		    end if
		    
		    ArrayCleanedUpCode.append(hulp)
		    
		    dim myDictionary as new Dictionary
		    myDictionary.value("cleanedUpCode")=arrayCleanedUpCode(i)
		    Select Case regelingIndex
		    Case "og"
		        myDictionary.value("proces")="influent"
		    Case "in"
		        myDictionary.value("proces")="monstername"
		    Case "mn"
		        myDictionary.value("proces")="monstername"
		    Case "ri"
		        myDictionary.value("proces")="roostergemaal"
		    Case "tu"
		        myDictionary.value("proces")="turbiditeit"
		    Case "tp"
		        myDictionary.value("proces")="regenwaterput"
		    Case "ca"
		        myDictionary.value("proces")="koolstofdosering"
		    Case "cd"
		        myDictionary.value("proces")="koolstofdosering"
		    Case "se"
		        myDictionary.value("proces")="selector"
		    Case "pp"
		        myDictionary.value("proces")="defosfatatie"
		    Case "pd"
		        myDictionary.value("proces")="polymeerdosering"
		    Case "sb"
		        myDictionary.value("proces")="slibstokkage"
		    Case "ss"
		        myDictionary.value("proces")="slibstokkage"
		    Case "vs"
		        myDictionary.value("proces")="voortstuwing"
		    Case "vm"
		        myDictionary.value("proces")="voortstuwing"
		    Case "ns"
		        myDictionary.value("proces")="influentverdeling"
		    Case "sr"
		        myDictionary.value("proces")="slibrecirculatie"
		    Case "bb"
		        myDictionary.value("proces")="beluchting"
		    Case "fr"
		        myDictionary.value("proces")="Krüger"
		    Case "sw"
		        myDictionary.value("proces")="slibontwatering"
		    Case "st"
		        myDictionary.value("proces")="slibtransport"
		    Case "sv"
		        myDictionary.value("proces")="slibrecirculatie verdeling"
		    Case "zv"
		        myDictionary.value("proces")="zandvang"
		    Case "qb"
		        myDictionary.value("proces")="debietbewaking"
		    Case "cv"
		        myDictionary.value("proces")="condensventielen"
		    Case "sb"
		        myDictionary.value("proces")="mixing"
		    Case "so"
		        myDictionary.value("proces")="slibopstart"
		    Case "dl"
		        myDictionary.value("proces")="drijflaag"
		    Case "rb"
		        myDictionary.value("proces")="regenbezinking"
		    Case "mt"
		        myDictionary.value("proces")="slibaanvoer MBR"
		    Case "mp"
		        myDictionary.value("proces")="permeaatonttrekking MBR"
		    Case "pm"
		        myDictionary.value("proces")="permeaatonttrekking MBR"
		    Case "mc"
		        myDictionary.value("proces")="maintenance cleaning MBR"
		    Case "ml"
		        myDictionary.value("proces")="luchtaanvoer MBR"
		    Case "mb"
		        myDictionary.value("proces")="luchtaanvoer MBR"
		    Case "tg"
		        myDictionary.value("proces")="terreinriolering"
		    Case "sa"
		        myDictionary.value("proces")="slibaanvoer"
		    Case "sc"
		        myDictionary.value("proces")="slibconditionering"
		    Case "bl"
		        myDictionary.value("proces")="beluchting"
		    Case "ve"
		        myDictionary.value("proces")="ontwatering blowers"
		    Case "ef"
		        myDictionary.value("proces")="effluent"
		    Case "so"
		        myDictionary.value("proces")="slibopstart"
		    Case "ol"
		        myDictionary.value("proces")="ontluchting"
		    Case "sk"
		        myDictionary.value("proces")="container dosering"
		        
		    Else
		        myDictionary.value("proces")= "ONBEKEND"
		    End Select
		    aMyDictionary.append(myDictionary)
		  next
		  
		   return aMyDictionary()
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function extractOriginalCode() As string()
		   dim arrayOriginalCode() as string 
		   
		   //open files and fill array
		   Dim t As TextinputStream
		   dim textarea1 as new textarea
		   dim index as integer = 0
		   
		   dim folder as  folderitem =exportedSectionsFolder
		   for i as integer = 1 to folder.count
		    if folder.item(i).name.right(4)=".xst" then
		      t = TextinputStream.open(folder.item(i))
		      textarea1.text= t.ReadAll()
		      arrayOriginalCode.append(TextArea1.text)
		       index=index+1
		       t.close
		     end if
		   next
		  
		  //delete files
		  dim j as integer = 0
		  while j<=30
		    for i as integer = 1 to folder.count
		      if folder.item(i).name.right(4)=".xst" then
		        folder.item(i).delete
		      end if
		    next
		    j=j+1
		  wend
		   
		   
		   return arrayOriginalCode()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function listProjectFiles() As FolderItem()
		  dim allProjectFiles() as FolderItem
		  
		  for i as integer = 1 to sourceFolder.Count
		    allProjectFiles.Append(sourceFolder.item(i))
		  next
		  
		  return allProjectFiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function retrieveSectionNames(projectFile as FolderItem) As Dictionary()
		   //create and open a unity project
		   dim oProject as new unitypro(projectfile)
		   dim arraySectionNames() as string 
		  
		   //export sections
		   dim oUnityproject as unityproject = oProject.project
		   dim aSection() as Unityproserver.section 
		   aSection=oUnityproject.sectionswithprefix
		   for index1 as integer = 0 to aSection.ubound 
		     oUnityproject.ExportasTempfile(aSection(index1))
		   next
		  
		   //fill array with section names
		   dim folder as  folderitem=exportedSectionsFolder
		   dim j as integer =0
		   for i as integer = 1 to folder.count
		     if folder.item(i).name.right(4)=".xst" then
		       arraySectionNames.append(folder.item(i).name)
		       j=j+1
		     end if
		   next
		  
		  //export functional modules in array
		  'dim oFctModules  as UnityProServer.FctModules = oUnityproject.FctModules
		  'dim aModule() as UnityProServer.FctModule
		  'dim EmptyString as string
		  'dim z as integer  =0
		  'while z < oFctModules.count*4
		  'aModule.append(oFctModules.item(emptystring,z))
		  'z=z+4
		  'wend
		  
		  
		  
		  //find the exported sections in the exported funcional modules 
		  'dim oProgFctModule as new UnityProServer.ProgFctModule
		  'dim aMatchModule() as string
		  'dim vUnKnown as variant
		  
		  'for i as integer = 0 to aSection.Ubound
		  'dim match as boolean = false
		  
		  'for k as integer = 0 to aModule.Ubound
		  'oProgFctModule=aModule(k).ProgFctModule
		  'vUnKnown=oProgFctModule.GetListOfSectionsAttached
		  'dim aVariant() as integer =vUnKnown
		  
		  'if not vUnKnown.isnull then
		  'dim h as integer =0
		  'while aVariant(h)<>0 
		  'if  aVariant(h)=aSection(i).id then
		  'match=true
		  'aMatchModule.append(aModule(k).name)
		  'exit While
		  'end if
		  'h=h+1
		  'wend
		  'end if
		  
		  'next
		  
		  //indien match
		  'if match then
		  'exit For
		  'end if
		  // indien geen match 
		  'if not match then
		  'aMatchModule.append("-1")
		  'end if
		  
		  'next
		  
		  
		  Dim aMyDictionary() As Dictionary
		  for l as integer = 0 to aSection.ubound 
		    dim myDictionary as new Dictionary
		    myDictionary.value("section_name")=arraySectionNames(l)
		    'myDictionary.value("section_FM")=aMatchModule(l)
		    aMyDictionary.append(myDictionary)
		  next
		  
		  
		   
		   return aMyDictionary()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub returnPrograms()
		  // Quit Unity if it's still running
		  Unitypro.quitall
		  
		  dim te as string
		  dim je as integer = 0
		  
		  
		  
		  //return all stu files to original location
		  while je <500
		    for i as integer = 1 to SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").count
		      dim s as string = SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").item(i).name
		      for j as integer = 0 to a.Ubound
		        te=a(j).value("file_name")
		        if s= te then
		          dim t as FolderItem
		          t=new folderitem(a(j).value("file_path"),FolderItem.PathTypeNative)
		          t.delete
		          SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").item(i).movefileto t
		          exit for
		        end if
		      next
		    next
		    je=je+1
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateProjects()
		  //   Insert Lennerts Update-code here (Conversie naar laatste versie)
		  
		  
		  for index as integer =1 to versionFolder.count
		    versionFolder.item(index).name=versionFolder.item(index).name.replace(".stu",".sta")
		  next
		  for index as integer = 1 to versionFolder.count
		    aFiles.append(versionFolder.item(index))
		  next
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		exportedSectionsFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		sourceFolder As folderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		UnityService As UnityPro
	#tag EndProperty

	#tag Property, Flags = &h0
		versionFolder As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
