#tag Class
Protected Class UnityPro
	#tag Method, Flags = &h21
		Private Sub connectAllEvents()
		  AddHandler unityApp.DisplayStart_Event, AddressOf  me.eventsTest
		  AddHandler unityApp.DisplayStop_Event, AddressOf  me.eventsTest
		  
		  // AddHandler UnityApp.AfterSave_Event, AddressOf  eventsTest
		  // AddHandler unityApp.OnLine_Event, AddressOf  eventsTest
		  // AddHandler unityApp.WriteAccessAvailable_Event, AddressOf  eventsTest
		  // AddHandler unityApp.OffLine_Event, AddressOf  eventsTest
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(projectFile as FolderItem, accessRights as UnityProServer.epsrAccessRight =UnityProServer.epsrAccessRight.PSR_ACCESS_RIGHT_READ_WRITE)
		  
		  // U need a UnityProBroker to even get started
		  dim unityBroker as New UnityProBroker.PServerBroker(TRUE) // argument = 'connectEvents'
		  
		  // Attach a UnityProServer.Application-Instance to this Class to do most of the work
		  // (You can't subclass it since it created with a factory-method on UnityBroker)
		  unityApp = unityBroker.OpenApplication(projectFile.NativePath) 
		  connectAllEvents
		  
		  // Set the accesRights
		  project=unityApp.Project(Integer(accessRights)) 
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  // Don't forget to cleanup the attched UnityProServer.Application
		  quit
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function eventsTest(sender as UnityProServer.Application) As Integer
		  // Only for testing events (untill a final implementation is worked out)
		  msgBox("Event fired hoera")
		  return 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hide()
		  
		  if (unityApp <> nil) and (unityApp.IsVisible <> 0) then
		    Dim dosterminal as new shell
		    Dim doscommand as string
		    
		    // Close the foreground Proces
		    doscommand = "TASKKILL /im UnityL.exe"
		    dosterminal.Execute(doscommand)
		    
		    System.DebugLog("Unity was hidden")
		  end if
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub quit()
		  // Close the foreground Process,
		  hide
		  
		  // Release the attached application before you close it
		  unityApp = nil
		  
		  // and all the background processes as well
		  UnityPro.QuitAll
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub QuitAll()
		  #if TargetWindows then
		    
		    while IsRunning
		      
		      Dim dosterminal as new shell
		      Dim doscommand as string
		      
		      doscommand = "TASKKILL /f /im UnityL.exe"
		      dosterminal.Execute(doscommand)
		      
		      System.DebugLog("Unity was quit")
		    wend
		    
		  #Endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub show()
		  If unityApp <> nil and (unityApp.IsVisible=0) Then
		    
		    // Show the Unity-interface as an extra in readOnly mode
		    dim commandLineArguments as String = "-tool 356" // This is the browser window
		    unityApp.DisplayStart(UnityProServer.epsrHmiOptions.psrHmiReadOnly, commandLineArguments)
		    
		    System.DebugLog("Unity was made visible")
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showOrHide(visible as Boolean = FALSE)
		  if  (visible) Then
		    show
		  else
		    hide 
		  end if
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  #if TargetWindows then
			    
			    Dim dosterminal as new shell
			    Dim doscommand as string
			    
			    doscommand = "TASKLIST"
			    dosterminal.Execute(doscommand)
			    
			    return InStr(dosterminal.Result, "UnityL") <> 0
			    
			  #else
			    
			    return FALSE
			    
			  #endif
			End Get
		#tag EndGetter
		Private Shared isRunning As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		project As UnityProject
	#tag EndProperty

	#tag Property, Flags = &h0
		unityApp As UnityProServer.Application
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
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
