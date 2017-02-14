#tag Class
Protected Class mainWindowController
Inherits NSWindowController
	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new MainWindow, nil)
		  
		  dim selectAndCompareViewController as new SelectAndCompareViewController
		  
		  mainWindow.mainTabPanel.append(selectAndCompareViewController.view, "List and Compare")
		  mainWindow.mainTabPanel.append(JVDevelopmentViewController.sharedDevelopmentViewController.developmentView, "Development")
		  
		  window.Show
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return  MainWindow(window)
			End Get
		#tag EndGetter
		mainWindow As MainWindow
	#tag EndComputedProperty


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
