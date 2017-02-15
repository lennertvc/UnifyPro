#tag Class
Protected Class SelectViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  me.view.top = 0+margins
		  me.view.left = 0+margins
		  me.view.width = me.view.window.width-(margins*2)
		  me.view.height = me.view.window.height/2-(margins*2)
		  
		  selectView.ListViewLeft.top = 0
		  selectView.ListViewLeft.left = 0
		  selectView.ListViewLeft.Width = me.view.width/2-margins/2
		  selectView.ListViewLeft.Height = me.view.height
		  
		  selectView.ListViewRight.top = 0
		  selectView.ListViewRight.left = me.view.width/2+Margins/2
		  selectView.ListViewRight.Width = me.view.width/2-margins/2
		  selectView.ListViewRight.Height = me.view.height
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new SelectView, nil)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onviewActivate(sender as nsview)
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
			  return SelectView(view)
			End Get
		#tag EndGetter
		selectView As SelectView
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
