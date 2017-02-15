#tag Class
Protected Class SelectAndCompareViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor( new SelectAndCompareView, nil)
		  
		  selectViewController = new SelectViewController
		  compareViewController = new CompareViewController
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onviewResizing(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		compareViewController As CompareViewController
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SelectAndCompareView(view)
			End Get
		#tag EndGetter
		selectAndCompareView As SelectAndCompareView
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
