#tag Class
Protected Class UnifyPro
Inherits NSApplicationDelegate
	#tag Event
		Sub Open()
		  mainController = new mainWindowController
		  
		  #if DebugBuild then
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Fill database",  NSButton.action(addressof testRoutineRefillDatabase))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Export both types",  NSButton.action(addressof testRoutineExportLeftAndRigthSelection))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Show TestReport",  NSButton.action(addressof testRoutineShowReport))
		  #endif
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub testRoutineExportLeftAndRigthSelection(sender as NSButton)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineRefillDatabase(sender as NSButton)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineShowReport(sender as NSButton)
		  dim exportFolder as FolderItem = mainWindowController.selectAndCompareViewController.selectViewController.exportFolder
		  dim TestFile1 as Folderitem = exportFolder.child("TypeLeft.xst")
		  dim TestFile2 as Folderitem = exportFolder.child("TypeRight.xst")
		  mainWindowController.selectAndCompareViewController.compareViewController.compare(TestFile1, TestFile2)
		End Sub
	#tag EndMethod


	#tag Note, Name = ToDo Jan
		Dataset/PreparedSQLStatement uitwerken voor verschillende viewcontrollers.
		kleuren achtergronden source/target "left"/"right"
		Oplossen scrollProbleem html-view
		
		
	#tag EndNote

	#tag Note, Name = ToDo Lennert
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mainWindowController(mainController)
			End Get
		#tag EndGetter
		mainWindowController As mainWindowController
	#tag EndComputedProperty


	#tag Constant, Name = Developer, Type = String, Dynamic = False, Default = \"Lennert Van Campenhout\nJan Verrept", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="fullVersion"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shortName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
