#tag Class
Protected Class PreProcessor
	#tag Method, Flags = &h0
		Sub collectProjects()
		  
		  Dim rootFolder As FolderItem
		  rootFolder = SelectFolder
		  If rootFolder<> Nil Then
		    //   Insert Lennerts Collection-code here
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  
		  sourceFolder =  SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects")
		  
		  if  not sourceFolder.Exists then
		    sourceFolder.CreateAsFolder
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function convertCode(arrayOriginalCode() as string) As string()
		  dim hulp,hulpstring,backuphulp as string
		  dim SR_Beluchting as Boolean
		  dim arrayCleanedUpCode() as string = array  ("","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","")
		  
		  
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
		    
		    re.SearchPattern = "\(\*.+\*\)"
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
		    
		    re.SearchPattern = "\(\*.*\*\)"
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
		    
		    re.SearchPattern = "\<.[^\(\)]+\>"
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
		    
		    
		    dim index88 as integer=0
		    dim match as RegExMatch
		    dim aresult() as string  = array("-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1")
		    
		    re.SearchPattern = " ?L[0-9]{2,}:[^=]"
		    match = re.Search(hulp)
		    
		    Do
		      If match <> Nil Then
		        aresult(index88)=match.SubExpressionString(0)
		        index88=index88+1    
		      end if   
		      match=re.search
		    Loop Until match Is Nil
		    
		    if aresult(0) <> "-1" then
		      
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
		    re.SearchPattern = "[\n\r]+"
		    re.ReplacementPattern = " "
		    re.Options.ReplaceAllMatches = True
		    hulp=re.Replace(hulp)
		    hulp=hulp.RTrim
		    hulp=hulp.LTrim
		    hulp=hulp.Lowercase
		    ArrayCleanedUpCode(i)=hulp
		    
		  next
		  
		  return arrayCleanedUpCode()
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function extractOriginalCode() As string()
		  dim arrayOriginalCode() as string = array ("","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","")
		  
		  //open files and fill array
		  Dim t As TextinputStream
		  dim textarea1 as new textarea
		  dim index as integer = 0
		  
		  dim folder as new folderitem(testfilelocation)
		  for i as integer = 1 to folder.count
		    if folder.item(i).name.right(4)<>".stu" then
		      t = TextinputStream.open(folder.item(i))
		      textarea1.text= t.ReadAll()
		      arrayOriginalCode(index)=TextArea1.text
		      index=index+1
		      t.close
		    end if
		  next
		  
		  //delete files
		  dim j as integer = 0
		  while j<=30
		    for i as integer = 1 to folder.count
		      if folder.item(i).name.right(4)<>".stu" then
		        folder.item(i).delete
		      end if
		    next
		    j=j+1
		  wend
		  
		  return arrayOriginalCode()
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub fillDatabase()
		  dim array0() as string
		  dim array1() as string
		  dim array2() as string
		  dim projectFiles() as FolderItem = listProjectFiles
		  
		  for j as integer = 0 to listProjectFiles.Ubound
		    
		    //starup project + retrieve sectionnames
		    array0=retrieveSectionNames(projectFiles(j))
		    
		    //extract original code (destination table = regelingtypes, column = originalcode)
		    array1=extractoriginalcode
		    
		    //convert original code (destination table = regelingtypes, column = cleanedupcode)
		    array2=convertCode(array1)
		    
		    //write to DB (table = RegelingTypes)
		    
		    for i as integer =0 to array2.ubound
		      if array2(i)<>"" then
		        if app.datamodel.lookupRecord("regelingTypes","cleanedUpCode",array2(i)) <>0 then
		          'call datamodel.addcodetodb(array1(i),array2(i)) 
		          call app.datamodel.addFilePath(projectFiles(j).name + " " +"-" +" " + array0(i) ,app.datamodel.lookupRecord("regelingTypes","cleanedUpCode",array2(i)) )
		        end if
		        if app.datamodel.lookupRecord("regelingTypes","cleanedUpCode",array2(i)) = 0 then
		          call app.datamodel.addcodetodb(array1(i),array2(i)) 
		          call app.datamodel.addFilePath(projectFiles(j).name + " " +"-" +" " + array0(i) ,app.datamodel.newpkfromtable("regelingTypes"))
		        end if
		        
		      end if
		    next
		    
		    // Quit Unity if it's still running
		    quitApplication
		    
		  next
		End Sub
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

	#tag Method, Flags = &h21
		Private Function retrieveSectionNames(projectFile as FolderItem) As string()
		  //create and open a unity project
		  dim oProject as new unitypro(projectfile)
		  dim arraySectionNames() as string = array ("","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","")
		  
		  //export sections
		  dim oUnityproject as unityproject = oProject.project
		  dim aSection() as Unityproserver.section 
		  aSection=oUnityproject.sectionswithprefix("R_")
		  for index1 as integer = 0 to aSection.ubound 
		    oUnityproject.ExportasTempfile(aSection(index1))
		  next
		  
		  //fill array with section names
		  dim folder as new folderitem(testfilelocation)
		  dim j as integer =0
		  for i as integer = 1 to folder.count
		    if folder.item(i).name.right(4)<>".stu" then
		      arraySectionNames(j)=folder.item(i).name
		      j=j+1
		    end if
		  next
		  
		  return arraySectionNames()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateProjects()
		  //   Insert Lennerts Update-code here
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		sourceFolder As folderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		UnityService As UnityPro
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
