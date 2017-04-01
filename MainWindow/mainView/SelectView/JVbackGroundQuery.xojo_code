#tag Class
Protected Class JVbackGroundQuery
Inherits Thread
	#tag Event
		Sub Run()
		  foundRecords = preparedStatement.SQLSelect
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub bindVariables(variables() as Variant)
		  preparedStatement.bindVariables(variables)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(preparedStatement as SQLitePreparedStatement)
		  me.preparedStatement = preparedStatement
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		foundRecords As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		preparedStatement As SQLitePreparedStatement
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return foundRecords.RecordCount
			End Get
		#tag EndGetter
		recordCount As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="recordCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
