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
		    dim aCompare() as string
		    
		    oPathFinder.basefolder = rootFolder
		    aResult=oPathFinder.findFile("huidig")
		    
		    for index10 as integer = 0 to aResult.Ubound
		      oProgramFinder.baseFolder=aResult(index10)
		      aBackupfile=oProgramFinder.findFile("stu")
		      
		      for index11 as integer=0 to aBackupFile.Ubound
		        if aCompare.IndexOf(aBackupFile(index11).Name) =-1 then
		          
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
		        end if 
		        
		        aCompare.Append(aBackupFile(index11).name)
		        
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
		    dim myDictionary as new Dictionary ("proces":"onbekend")
		    
		    // extra info uit oproeproutine halen
		    dim matchbel as new RegExMatch
		    re.SearchPattern = "Bbdeni\s*:=\s*%MW"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      myDictionary.value("proces")="subregeling beluchting"
		    end if
		    
		    re.SearchPattern = "Bbnpr"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      myDictionary.value("proces")="beluchting - one sensor"
		    end if
		    
		    re.SearchPattern = "Bbcyc1"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      myDictionary.value("proces")="beluchting - two sensor"
		    end if
		    
		    re.SearchPattern = "BbselNPR"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      myDictionary.value("proces")="beluchting (combi)"
		    end if
		    
		    re.SearchPattern = "Bbpara"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      myDictionary.value("proces")="master/slave beluchting"
		    end if
		    
		    re.SearchPattern = "BbselNPR\s*:=\s*true"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      if  myDictionary.value("proces")="onbekend" or myDictionary.value("proces")="beluchting regeling (combi)" or myDictionary.value("proces")="one sensor beluchting" or myDictionary.value("proces")="two sensor beluchting"then
		        myDictionary.value("proces")="one sensor beluchting (combi)"
		      else
		        myDictionary.value("proces")=myDictionary.value("proces")+" - one sensor"
		      end if
		    end if
		    
		    re.SearchPattern = "BbselNiAm\s*:=\s*true"
		    matchbel = re.Search(hulp)
		    if matchbel <> nil then
		      if  myDictionary.value("proces")="onbekend" or myDictionary.value("proces")="beluchting regeling (combi)" or myDictionary.value("proces")="one sensor beluchting" or myDictionary.value("proces")="two sensor beluchting"then
		        myDictionary.value("proces")="two sensor beluchting (combi)"
		      else
		        myDictionary.value("proces")=myDictionary.value("proces")+" - two sensor"
		      end if
		    end if
		    
		    
		    
		    
		    
		    
		    
		    
		    
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
		    
		    re.SearchPattern = "DEC\("
		    re.ReplacementPattern = "DEC ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INC_INT\("
		    re.ReplacementPattern = "INC_INT ("
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    
		    re.SearchPattern = "INC\("
		    re.ReplacementPattern = "INC ("
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
		    
		    
		    myDictionary.value("cleanedUpCode")=arrayCleanedUpCode(i)
		    Select Case regelingIndex
		    Case "og"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "in"
		      myDictionary.value("proces")="monstername"
		    Case "mn"
		      myDictionary.value("proces")="monstername"
		    Case "ri"
		      myDictionary.value("proces")="roosterinstallatie"
		    Case "tu"
		      myDictionary.value("proces")="turbiditeit"
		    Case "tp"
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "ca"
		      myDictionary.value("proces")="koolstofdosering"
		    Case "cd"
		      myDictionary.value("proces")="koolstofdosering"
		    Case "se"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "pp"
		      myDictionary.value("proces")="defosfatatie"
		    Case "pd"
		      myDictionary.value("proces")="polymeerdosering"
		    Case "sb"
		      myDictionary.value("proces")="slibstokkage"
		    Case "ss"
		      myDictionary.value("proces")="slibstokkage"
		    Case "vs"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "vm"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "ns"
		      myDictionary.value("proces")="influentverdeling"
		    Case "sr"
		      myDictionary.value("proces")="slibrecirculatie"
		    Case "bb"
		      if myDictionary.value("proces")="onbekend" then
		        myDictionary.value("proces")="beluchting"
		      end if
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
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "sa"
		      myDictionary.value("proces")="slibaanvoer"
		    Case "sc"
		      myDictionary.value("proces")="slibconditionering"
		    Case "bl"
		      myDictionary.value("proces")="beluchting"
		    Case "ba"
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
		    Case "dr"
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "um"
		      myDictionary.value("proces")="unitank"
		    Case "ba"
		      myDictionary.value("proces")="batchsturing"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "si"
		      myDictionary.value("proces")="secundair spui"
		    Case "cm"
		      myDictionary.value("proces")="koolstofdosering"
		    Case "cs"
		      myDictionary.value("proces")="koolstofdosering"
		    Case "vb"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "sp"
		      myDictionary.value("proces")="spui"
		    Case "cf"
		      myDictionary.value("proces")="slibafvoer"
		    Case "cw"
		      myDictionary.value("proces")="centrifuge"
		    Case "ni"
		      myDictionary.value("proces")="niveausturing"
		    Case "rp"
		      myDictionary.value("proces")="filterpers"  
		    Case "fd"
		      myDictionary.value("proces")="dosering filterpers"
		    Case "dp"
		      myDictionary.value("proces")="drijflaagpomp"
		    Case "es"
		      myDictionary.value("proces")="roosterinstallatie"
		    Case "fb"
		      myDictionary.value("proces")="Krüger"
		    Case "os"
		      myDictionary.value("proces")="overstort"
		    Case "bp"
		      myDictionary.value("proces")="backpuls MBR"
		    Case "ro"
		      myDictionary.value("proces")="roosterinstallatie"
		    Case "ms"
		      myDictionary.value("proces")="slibaanvoer MBR"
		    Case "an"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "no"
		      myDictionary.value("proces")="noodkoeling"
		    Case "as"
		      myDictionary.value("proces")="anit-schuim"
		    Case "ww"
		      myDictionary.value("proces")="warmtewisseling"
		    Case "su"
		      myDictionary.value("proces")="septische unit"
		    Case "vd"
		      myDictionary.value("proces")="voeding zandfilter"
		    Case "db"
		      myDictionary.value("proces")="koolstofdosering zandfilter"
		    Case "pc"
		      myDictionary.value("proces")="koolstofdosering"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "or"
		      myDictionary.value("proces")="slibrecirculatie"
		    Case "rv"
		      myDictionary.value("proces")="slibrecirculatieverdeling"
		    Case "sg"
		      myDictionary.value("proces")="stormgemaal"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "vz"
		      myDictionary.value("proces")="voeding zandfilter"
		    Case "lz"
		      myDictionary.value("proces")="lucht zandfilter"
		    Case "cz"
		      myDictionary.value("proces")="koolstofdosering zandfilter"
		    Case "eg"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "al"
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "ps"
		      myDictionary.value("proces")="effluentgemaal"
		    Case "tw"
		      myDictionary.value("proces")="Krüger"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "sl"
		      myDictionary.value("proces")="slibtransport"
		    Case "iv"
		      myDictionary.value("proces")="influentverdeling"
		    Case "re"
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "rf"
		      myDictionary.value("proces")="reflux MBR"
		    Case "gc"
		      myDictionary.value("proces")="looptijd/stoptijd"
		    Case "ov"
		      myDictionary.value("proces")="hoofdregeling MBR"
		    Case "ps"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "ts"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "bx"
		      myDictionary.value("proces")="subregeling beluchting"
		    Case "rr"
		      myDictionary.value("proces")="regenbezinking"
		    Case "ep"
		      myDictionary.value("proces")="slibrecirculatie"
		    Case "br"
		      myDictionary.value("proces")="Krüger"
		    Case "vu"
		      myDictionary.value("proces")="terreinriolering/vuilwater"
		    Case "tr"
		      myDictionary.value("proces")="slibstockage"
		    Case "on"
		      myDictionary.value("proces")="opvoergemaal"
		    Case "bi"
		      myDictionary.value("proces")="bufferwerking industrie"
		    Case "ts"
		      myDictionary.value("proces")="master-slave beluchting"
		    Case "bm"
		      myDictionary.value("proces")="subregeling beluchting"
		    Case "bs"
		      myDictionary.value("proces")="subregeling beluchting"
		    Case "nr"
		      myDictionary.value("proces")="nitraatretour"
		    Case "pa"
		      myDictionary.value("proces")="slibconditionering"
		    Case "lm"
		      myDictionary.value("proces")="leeglaat"
		    Case "af"
		      myDictionary.value("proces")="afvlakbuffer"
		    Case "eg"
		      myDictionary.value("proces")="effluent goot"
		    Case "ex"
		      myDictionary.value("proces")="extern slib"
		    Case "si"
		      myDictionary.value("proces")="slibsilo"
		    Case "pr"
		      myDictionary.value("proces")="primaire spui"
		    Case "sy"
		      myDictionary.value("proces")="sifon"
		    Case "gv"
		      myDictionary.value("proces")="gasverwerking"
		    Case "ce"
		      myDictionary.value("proces")="centraat"
		    Case "se"
		      myDictionary.value("proces")="extern slib"
		    Case "tb"
		      myDictionary.value("proces")="tussenbuffer"
		    Case "ve"
		      myDictionary.value("proces")="ventilator"
		      
		      
		      
		      
		      
		      
		      
		    Else
		      myDictionary.value("proces")= "ONBEKEND"
		    End Select
		    aMyDictionary.append(myDictionary)
		  next
		  
		  return aMyDictionary()
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function extractOriginalCode(storedFiles() as FolderItem) As string()
		  dim arrayOriginalCode() as string 
		  
		  //open files and fill array
		  Dim t As TextinputStream
		  dim textarea1 as new textarea
		  dim index as integer = 0
		  
		  dim folder as  folderitem =exportedSectionsFolder
		  for i as integer = 0 to storedFiles.ubound 
		    t = TextinputStream.open(storedFiles(i))
		    textarea1.text= t.ReadAll()
		    arrayOriginalCode.append(TextArea1.text)
		    index=index+1
		    t.close
		  next
		  
		  //delete all files
		  dim deleter as new DeleteFolderContent
		  call deleter.DeleteEntireFolder(exportedSectionsFolder)
		  
		  
		  return arrayOriginalCode()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindMetaData(CleanedUpCode as string) As Dictionary
		  
		  
		  dim match as RegExMatch
		  dim re as new regex
		  dim myDictionary as new dictionary  
		  
		  
		  //find number of werktuigen
		  dim aResultW() as string
		  
		  re.SearchPattern = "augvw[0-9]"
		  match = re.Search(CleanedUpCode)
		  Do
		    If match <> Nil Then
		      if aResultW.IndexOf(match.SubExpressionString(0))=-1 then
		        aresultW.append(match.SubExpressionString(0))
		      end if
		    end if   
		    match=re.search
		  Loop Until match Is Nil
		  
		  if aResultW.Ubound<>-1 then
		    myDictionary.value("NumberW")=aResultW.Ubound+1
		  else
		    myDictionary.value("NumberW")=0
		  end if
		  
		  
		  
		  //find number of metingen
		  dim aResultM() as string
		  
		  re.SearchPattern = "m[0-9]sm"
		  match = re.Search(CleanedUpCode)
		  Do
		    If match <> Nil Then
		      if aResultM.IndexOf(match.SubExpressionString(0))=-1 then
		        aresultM.append(match.SubExpressionString(0))
		      end if
		    end if   
		    match=re.search
		  Loop Until match Is Nil
		  
		  if aResultM.Ubound<>-1 then
		    myDictionary.value("NumberM")=aResultM.Ubound+1
		  else
		    myDictionary.value("NumberM")=0
		  end if
		  
		  
		  
		  //find number of vlotters
		  dim aResultV() as string
		  
		  re.SearchPattern = "v[0-9lh]p"
		  match = re.Search(CleanedUpCode)
		  Do
		    If match <> Nil Then
		      if aResultV.IndexOf(match.SubExpressionString(0))=-1 then
		        aresultV.append(match.SubExpressionString(0))
		      end if
		    end if   
		    match=re.search
		  Loop Until match Is Nil
		  
		  if aResultV.Ubound<>-1 then
		    myDictionary.value("NumberV")=aResultV.Ubound+1
		  else
		    myDictionary.value("NumberV")=0
		  end if
		  
		  
		  
		  //find PID controller
		  
		  re.SearchPattern = "set pidauto"
		  match = re.Search(CleanedUpCode)
		  if match <> nil then
		    myDictionary.value("PIDControl")="aanwezig"
		  else
		    myDictionary.value("PIDControl")="niet aanwezig"
		  end if
		  
		  
		  //find opstelling
		  dim resultString as string
		  dim level() as integer = array(0,0,0,0,0)
		  dim highlevel() as Integer = array(0,0,0,0)
		  
		  re.SearchPattern = "\(te(rangorde)?[0-9]=[0-9] and ni[0-9]\)( or \(te(rangorde)?[0-9]=[0-9] and ni[0-9]\))?( or \(te(rangorde)?[0-9]=[0-9] and ni[0-9]\))?( or \(te(rangorde)?[0-9]=[0-9] and ni[0-9]\))?( or \(?ni[0-9]\)?)?"
		  match = re.Search(CleanedUpCode)
		  if match = nil then
		    myDictionary.value("Config")="NVT"
		  else
		    resultString=match.SubExpressionString(0)
		    level(0)=resultString.InStr("te1")
		    level(1)=resultString.InStr("te2")
		    level(2)=resultString.InStr("te3")
		    level(3)=resultString.InStr("te4")
		    level(4)=resultString.InStr("te5")
		    if level(0)=0 and level(1)=0 and level(2)=0 and level(3)=0 and level(4)=0 then
		      level(0)=resultString.InStr("terangorde1")
		      level(1)=resultString.InStr("terangorde2")
		      level(2)=resultString.InStr("terangorde3")
		      level(2)=resultString.InStr("terangorde4")
		      level(4)=resultString.InStr("terangorde5")
		    end if
		    highlevel(0)=resultString.instr("or ni2")
		    highlevel(1)=resultString.instr("or ni3")
		    highlevel(2)=resultString.instr("or ni4")
		    highlevel(3)=resultString.instr("or ni5")
		    if highlevel(0)=0 and highlevel(1)=0 and highlevel(2)=0 and highlevel(3)=0 then
		      highlevel(0)=resultString.instr("or (ni2)")
		      highlevel(1)=resultString.instr("or (ni3)")
		      highlevel(2)=resultString.instr("or (ni4)")
		      highlevel(3)=resultString.instr("or (ni5)")
		    end if
		    
		    dim maxlevel as integer=0
		    for index as integer = 0 to 4
		      if level(index)<>0 then
		        maxlevel=maxlevel+1
		      end if
		    next
		    
		    dim maxlevelhigh as integer=0
		    for index as integer = 0 to 3
		      if highlevel(index)<>0 then
		        maxlevelhigh=maxlevelhigh+1
		      end if
		    next
		    
		    myDictionary.value("Config")= str(maxlevel+maxlevelhigh)+" + "+str(myDictionary.value("NumberW")- maxlevel-maxlevelhigh)
		  end if
		  
		  return myDictionary
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function retrieveSectionNames(projectFile as FolderItem) As Dictionary()
		  //create and open a unity project
		  dim oProject as new unitypro(projectfile)
		  dim arraySectionNames() as FolderItem
		  
		  //export sections
		  dim oUnityproject as unityproject = oProject.project
		  dim aSection() as Unityproserver.section 
		  aSection=oUnityproject.sectionswithprefix
		  for index1 as integer = 0 to aSection.ubound 
		    oUnityproject.ExportasTempfile(aSection(index1))
		  next
		  
		  
		  
		  
		  Dim aMyDictionary() As Dictionary
		  
		  
		  //export functional modules in array
		  dim oFctModules  as unityproserver.FctModules=oUnityproject.FctModules
		  dim oFctModule as variant
		  dim aModule() as string
		  for i as integer = 2 to 32767
		    oFctModule=oFctModules.item("",i)
		    if oFctModule <>nil then
		      aModule.append(oFctModules.item("",i).Name)
		    end if
		  next
		  
		  
		  
		  //find the exported sections in the exported funcional modules 
		  dim oProgFctModule as new UnityProServer.ProgFctModule
		  dim aMatchModule() as string
		  dim vUnKnown as variant
		  
		  
		  for i as integer = 0 to aSection.Ubound
		    dim match as boolean = false
		    
		    for kk as integer = 0 to aModule.Ubound
		      
		      oProgFctModule=oFctModules.item(aModule(kk)).ProgFctModule
		      
		      if oProgFctModule.GetListOfSectionsAttached<>nil then
		        
		        vUnKnown=oProgFctModule.GetListOfSectionsAttached
		        dim aVariant() as variant =vUnKnown
		        if not vUnKnown.isnull then
		          
		          for teller as integer =0 to aVariant.Ubound
		            if  aVariant(teller)=aSection(i).id then
		              match=true
		              aMatchModule.append(oFctModules.item(aModule(kk)).name)
		              dim myDictionary as new Dictionary
		              myDictionary.value("section_name")=aSection(i).name
		              myDictionary.value("section_FM")=oFctModules.item(aModule(kk)).name
		              //fill array with section names
		              dim folder as  folderitem=exportedSectionsFolder
		              for j as integer = 1 to folder.count
		                if folder.item(j).name=aSection(i).name+".xst" then
		                  arraySectionNames.append(folder.item(j))
		                end if
		              next
		              myDictionary.value("fileAsFolderItem")=arraySectionNames(i)
		              aMyDictionary.append(myDictionary)
		              exit for
		            end if
		          next
		        end if
		        //indien match
		        if match then
		          exit For
		        end if
		        
		      end if
		      
		    next
		    
		    // indien geen match 
		    if not match then
		      dim myDictionary as new Dictionary
		      myDictionary.value("section_name")=aSection(i).name
		      myDictionary.value("section_FM")="niet aanwezig"
		      //fill array with section names
		      dim folder as  folderitem=exportedSectionsFolder
		      for j as integer = 1 to folder.count
		        if folder.item(j).name=aSection(i).name+".xst" then
		          arraySectionNames.append(folder.item(j))
		        end if
		      next
		      myDictionary.value("fileAsFolderItem")=arraySectionNames(i)
		      aMyDictionary.append(myDictionary)
		    end if
		    
		    
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
