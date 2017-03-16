#tag Class
Protected Class JVPathFind
	#tag Method, Flags = &h0
		Sub constructor()
		  // Return a resourceFolder based on the platform and build state
		  #if debugBuild then
		    #if TargetWindows then
		      baseFolder = app.ExecutableFile.Parent.Parent
		    #else
		      baseFolder = app.ExecutableFile.Parent.Parent.parent.Parent
		    #Endif
		  #else
		    #if TargetWindows then
		      baseFolder = app.ExecutableFile.Parent
		    #else
		      baseFolder = app.ExecutableFile.Parent.Parent.Parent
		    #Endif
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findFile(fileName as String) As FolderItem()
		  dim subDirectoriesToSearch() as FolderItem=array(basefolder)
		  dim completeMatch as FolderItem
		  dim partialMatch as FolderItem
		  dim aBackup() as FolderItem
		  dim index as integer = 0
		  dim hulp as integer = 0
		  dim MyRegex as new regex
		  dim MyRegexMatch as new regexmatch
		  dim MyString1,MyString2 as string
		  
		  while  (subDirectoriesToSearch.Ubound >= 0)  or hulp=0
		    
		    hulp=1
		    dim currentDirectory as folderItem = subDirectoriesToSearch(0)
		    
		    for i as Integer=1 to currentDirectory.Count
		      dim currentItem as FolderItem = currentDirectory.Item(i)
		      
		      if currentItem.Directory then
		        subDirectoriesToSearch.Append(currentItem)
		      else
		        Myregex.SearchPattern = "\."+filename
		        MyRegexMatch=MyRegex.search(currentitem.name)
		        
		        if Myregexmatch<>nil  then
		          aBackup.append(currentItem)
		          for index2 as integer = 0 to (abackup.ubound)
		            MyString1=abackup(index2).name
		            MyString2=currentitem.name
		            Mystring1=Mystring1.replace(".stu","")
		            Mystring1=Mystring1.replace(".auto","")
		            Mystring2=Mystring2.replace(".stu","")
		            Mystring2=Mystring2.replace(".auto","")
		            System.DebugLog(str(currentitem.ModificationDate))
		            System.DebugLog(str(abackup(index2).modificationdate))
		            if Mystring1= Mystring2 and abackup(index2).modificationdate<currentitem.ModificationDate then
		              abackup.remove(index2)
		              aBackup.append(currentItem)
		            end if
		            if Mystring1= Mystring2 and abackup(index2).modificationdate>currentitem.ModificationDate then
		              abackup.remove(index2+1)
		            end if
		          next
		          index=index+1
		        end if
		        
		      end if
		      
		    next
		    
		    subDirectoriesToSearch.Remove(0)
		    
		  wend
		  
		  return abackup
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		baseFolder As folderitem
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
