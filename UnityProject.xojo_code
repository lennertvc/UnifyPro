#tag Class
Protected Class UnityProject
Inherits UnityProServer.Project
	#tag Method, Flags = &h0
		Sub addCode(SourceCode as String, task as UnityProServer.Task)
		  
		  saveTextAsTempFile(SourceCode)
		  importFromTempFile(task)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub close()
		  //app.unitypro.hide
		  
		  system.DebugLog("Closing project "+name)
		  
		  // you must release the project before you can close it
		  //app.unityPro.project =  nil 
		  
		  //app.unityPro.unityApp.ProjectClose
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function code(item as variant) As String
		  
		  exportAsTempFile(item, epsrExportOption.psrExportWithSr)
		  return readTextFromTempFile
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub exportAsTempFile(item as variant, exportOption as epsrExportOption = epsrExportOption.psrExportWithsr)
		  dim exportFile as FolderItem = UnityProject.tempFile
		  
		  if item isa UnityProServer.Section then
		    
		    // Export it to a temp file
		    dim section as UnityProServer.Section = item
		    section.Export(section.name, Integer(exportOption))
		    
		  elseif item isa UnityProServer.Sr then 
		    
		    // Export it to a temp file
		    dim subRoutine as UnityProServer.sr = item
		    subRoutine.Export(exportFile.NativePath)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub importFromTempFile(task as UnityProServer.Task = nil)
		  dim importFile as FolderItem = UnityProject.tempFile
		  dim importOption as UnityProServer.epsrImportOption = epsrImportOption.psrImportOptionOverwrite
		  
		  if task = nil then
		    task = mastTask
		  end if
		  
		  dim sections as UnityProServer.Sections  =  task.Sections
		  sections.ImportWithStrategy(importFile.NativePath,importOption)
		  
		  save
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function readTextFromTempFile() As String
		  // Return the contents of the tempFile
		  dim ti as TextInputStream = TextInputStream.Open(UnityProject.tempFile)
		  ti.Encoding = Encodings.MacRoman
		  dim sourceCode as String = ti.ReadAll
		  ti.close
		  
		  return sourceCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub save()
		  if IsModified >0 then
		    super.save
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub saveTextAsTempFile(sourceCode as String)
		  dim t as TextOutputStream = TextOutputStream.Create(UnityProject.tempfile)
		  t.WriteLine(sourcecode)
		  t.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sectionsWithPrefix(tagPrefix as String) As UnityProServer.Section()
		  dim sectionList() as UnityProServer.Section
		  
		  dim sections as UnityProServer.Sections  =  mastTask.Sections
		  dim numberOfSections as Integer = sections.Count
		  dim sectionNumber as Integer
		  
		  for sectionNumber = 0 to numberOfSections-1
		    dim section as UnityProServer.Section = sections.JVItem(sectionNumber)
		    dim sectionPrefix as String = Uppercase(left(Trim(section.name),Len(tagPrefix)))
		    if (sectionPrefix = upperCase(tagPrefix))  then 
		      sectionList.Append(section)
		    end if
		  next
		  
		  return sectionList
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return program.tasks.JVitem(UnityProServer.epsrTaskType.PSR_FAST_TASK)
			End Get
		#tag EndGetter
		fastTask As UnityProServer.Task
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return program.tasks.JVitem(UnityProServer.epsrTaskType.PSR_MAST_TASK)
			End Get
		#tag EndGetter
		mastTask As UnityProServer.Task
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  dim tempFilePath as String = SpecialFolder.Temporary.NativePath+"tempSourceFile.xst"
			  dim tempFile as new FolderItem(tempFilePath)
			  return tempFile
			End Get
		#tag EndGetter
		Private Shared tempFile As FolderItem
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Comment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasProjectFileName"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Id"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InfoBuildState"
			Group="Behavior"
			Type="epsrBuildState"
			EditorType="Enum"
			#tag EnumValues
				"0 - psrBuildStateNotBuilt"
				"1 - psrBuildStateBuiltOk"
				"2 - psrBuildStateAnalyzed"
				"3 - psrBuildStateUnknown"
			#tag EndEnumValues
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
			Name="PrivateInfo"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProjectFileName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
