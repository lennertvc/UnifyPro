#tag Module
Protected Module versionUpdateModule
	#tag Property, Flags = &h0
		a() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		aFiles() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		BackupIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		bool As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		conversionComplete As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		CutString As String
	#tag EndProperty

	#tag Property, Flags = &h0
		file As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Index As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		IsComplete As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim UnityShell as new shell
			  UnityShell.mode=0
			  unityshell.Execute("tasklist /FI ""IMAGENAME eq UnityL.exe"" /FI ""windowtitle ne Unity Pro L"" /FI ""MEMUSAGE gt 300000""")
			  System.DebugLog("open"+unityshell.result)
			  dim result as boolean =  (unityshell.result.InStr(0,"unity")>0)
			  return result
			End Get
		#tag EndGetter
		IsOpen As boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim UnityShell as new shell
			  UnityShell.mode=0
			  unityshell.Execute("tasklist /FI ""IMAGENAME eq UnityL.exe"" /FI ""MEMUSAGE gt 23000""")
			  System.DebugLog("running"+unityshell.result)
			  dim result as boolean =  (unityshell.result.InStr(0,"Unity")>0)
			  return result
			  
			End Get
		#tag EndGetter
		IsRunning As boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		preprocess As PreProcessor
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BackupIndex"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bool"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="conversionComplete"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CutString"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsComplete"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOpen"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Group="Behavior"
			Type="boolean"
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
End Module
#tag EndModule
