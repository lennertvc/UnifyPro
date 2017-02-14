#tag Class
Protected Class CompareViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  
		  CompareView.ListMetaLeft.top = 0
		  CompareView.ListMetaLeft.left = 0
		  CompareView.ListMetaLeft.Width = view.width/2
		  CompareView.ListMetaLeft.height = view.height/2
		  
		  
		  CompareView.ListMetaRight.top = 0
		  CompareView.ListMetaRight.left = view.width/2
		  CompareView.ListMetaRight.Width = view.width/2
		  CompareView.ListMetaRight.height = view.height/2
		  
		  
		  CompareView.ReportView.top = view.height/2
		  CompareView.ReportView.left = 0
		  CompareView.ReportView.Width = view.width
		  CompareView.ReportView.height = view.height/2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new CompareView, nil)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewActivate(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewResizing(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return CompareView(view)
			End Get
		#tag EndGetter
		compareView As CompareView
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
