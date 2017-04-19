#tag Class
Protected Class UnifyPro
Inherits NSApplicationDelegate
	#tag Event
		Sub Open()
		  #if not (TargetWindows or DebugBuild) then
		    MsgBox("this program is Windows-only")
		    quit
		  #endif
		  
		  Unitypro.QuitAll
		  
		  datamodel = RegelingenDataBase.open
		  
		  preProcess= new PreProcessor
		  
		  
		  mainController = new mainWindowController
		  
		  
		  #if DebugBuild then
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Collect Projects",  NSButton.action(addressof  testRoutineCollectProjects))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Update Projects",  NSButton.action(addressof testRoutineUpdateProjects))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Return to original",  NSButton.action(addressof testRoutineReturntoOriginal))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Fill database",  NSButton.action(addressof testRoutineFillDatabase))
		    
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Lees Multiline",  NSButton.action(addressof testRoutineMultiLine))
		    
		  #endif
		  
		  // Xojo only supports coöperitive multitasking so threads simply divide the resources of as single processor core
		  // Therefore Xojo halts the creation of window and viewcontrollers when lots of data gets pulled from the dbase to soon.
		  // This is why the data gets loaded here, when the app is fully initialized an all windows are already open
		  mainWindowController.selectViewController.loadLeftData 
		  mainWindowController.selectViewController.loadRightData 
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub testRoutinecollectProjects(sender as NSButton)
		  //collect all stu files
		  a= preProcess.collectProjects
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineFillDatabase(sender as NSButton)
		  dim filler as new FillDatabase
		  // dim datamodel as new RegelingenDataBase
		  // 
		  // datamodel = RegelingenDataBase.open
		  filler.addData(preprocess,datamodel,a)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineMultiLine(sender as NSButton)
		  dim  exampleOfCleanCode as String ="<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"+CHR(10)+"<STExchangeFile>"
		  dim test as RecordSet = app.dataModel.SQLSelect("Select * FROM regelingTypes WHERE originalCode ='"+exampleOfCleanCode+"'")
		  MsgBox(str(test.RecordCount))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineReturntoOriginal(sender as NSButton)
		  //collect all stu files
		  call preProcess.returnPrograms
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineUpdateprojects(sender as NSButton)
		  //update all stu files
		  call preProcess.updateProjects
		  versionUpdateWindow.show
		End Sub
	#tag EndMethod


	#tag Note, Name = ToDo Jan v2.0
		Extra windows voorzien voor tonen original code
		
		
		
	#tag EndNote

	#tag Note, Name = ToDo Lennert
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		dataModel As RegelingenDataBase
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mainWindowController(mainController)
			End Get
		#tag EndGetter
		mainWindowController As mainWindowController
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		preprocess As PreProcessor
	#tag EndProperty


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
