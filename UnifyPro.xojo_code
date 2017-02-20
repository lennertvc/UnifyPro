#tag Class
Protected Class UnifyPro
Inherits NSApplicationDelegate
	#tag Event
		Sub Open()
		  datamodel = RegelingenDataBase.open
		  
		  preProcessor = new PreProcessor
		  mainController = new mainWindowController
		  
		  
		  #if DebugBuild then
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Collect Projects",  NSButton.action(addressof  testRoutineCollectProjects))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Update Projects",  NSButton.action(addressof testRoutineUpdateProjects))
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Fill database",  NSButton.action(addressof testRoutineFillDatabase))
		    
		    JVDevelopmentViewController.sharedDevelopmentViewController.addTestButton("Lees listings",  NSButton.action(addressof testRoutineLeestListings))
		    
		  #endif
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub testRoutinecollectProjects(sender as NSButton)
		  
		  preProcessor.collectProjects
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineFillDatabase(sender as NSButton)
		  preProcessor.fillDatabase
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineLeestListings(sender as NSButton)
		  mainWindowController.selectViewController.syncInterface(TRUE)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testRoutineUpdateprojects(sender as NSButton)
		  preProcessor.updateProjects
		End Sub
	#tag EndMethod


	#tag Note, Name = ToDo Jan
		View aanmaken met count van related records regelingen 
		
		Dataset/PreparedSQLStatement uitwerken voor verschillende viewcontrollers.
		
		Filterveld voorzien voor project
		
		
	#tag EndNote

	#tag Note, Name = ToDo Lennert
		
		Review eigen code na consolidatie (nu grotendeels onder preProcessing)!!!
		
		
		Private methods als dusdanig aanduiden
		
		Wegwerken defaultvalues in arrays door gebruik van append inplaats van item(i)
		
		For next loops indien mogelijk voorzien van fast enumaration
		
		WegFilteren van de prefix van de subroutine op basis van een variabele die gekend is met bij regex \D+(SiSTSP) en vervangen door niks
		Vullen veld procesdeel
		Vullen van filepath
		Vullen van metadata
		
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
		preProcessor As PreProcessor
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
