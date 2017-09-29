#tag Class
Protected Class MainWindowController
Inherits NSWindowController
	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new MainWindow, nil)
		  
		  // Create the subcontrollers
		  selectViewController = new SelectViewController
		  compareViewController = new CompareViewController
		  
		  // Install the view hierarchy
		  dim mainView as new NSView
		  mainWindow.mainTabPanel.append(mainView, "List and Compare")
		  selectViewController.view.EmbedWithin(mainView)
		  compareViewController.view.EmbedWithin(mainView)
		  
		  // Add some extra tools during debuging
		  
		  mainWindow.mainTabPanel.append(JVBackendViewController.sharedBackendViewController.backendView, "Backend")
		  mainWindow.mainTabPanel.append(JVDevelopmentViewController.sharedDevelopmentViewController.developmentView, "Development")
		  
		  window.Show
		  window.maximize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onWindowClose()
		  exit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onWindowResized(sender as NSWindow)
		  selectViewController.autoLayout
		  compareViewController.autoLayout
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		compareViewController As CompareViewController
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return  MainWindow(window)
			End Get
		#tag EndGetter
		mainWindow As MainWindow
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		selectViewController As SelectViewController
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
