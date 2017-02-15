#tag Class
Protected Class CompareViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  me.view.top = me.view.window.height/2+margins
		  me.view.left = 0+margins
		  me.view.width = me.view.window.width-(margins*2)
		  me.view.height = me.view.window.height/2-(margins*2)
		  
		  CompareView.ListMetaLeft.top = 0
		  CompareView.ListMetaLeft.left = 0
		  CompareView.ListMetaLeft.Width = me.view.width/2-margins/2
		  CompareView.ListMetaLeft.height = me.view.height/2-margins/2
		  
		  CompareView.ListMetaRight.top = 0
		  CompareView.ListMetaRight.left = me.view.width/2+Margins/2
		  CompareView.ListMetaRight.Width = me.view.width/2-margins/2
		  CompareView.ListMetaRight.height = me.view.height/2-margins/2
		  
		  CompareView.ReportView.top = me.view.height/2+margins/2
		  CompareView.ReportView.left = 0
		  CompareView.ReportView.Width = me.view.width
		  CompareView.ReportView.height = me.view.height/2-margins/2
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


	#tag Constant, Name = margins, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


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
