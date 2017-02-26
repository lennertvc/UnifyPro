#tag Class
Protected Class IDdts
Inherits COM.IDispatch
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // This class is not instantiable
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Count_Func1(mThis.Ptr( 0 ).Ptr(32 ))
		  Dim resultCode As Integer
		  Dim Return_pNumber_Param As Integer
		  resultCode = func.Invoke(mThis, Return_pNumber_Param)
		  If resultCode = 0 Then
		    Return Return_pNumber_Param
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Count", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Count_Func1(this As Ptr, ByRef pNumber_Param As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{4F5675B3-3732-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(p_DdtKey_Param As Variant) As UnityProLibset.IDdt
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Item_Func2(mThis.Ptr( 0 ).Ptr(36 ))
		  Dim resultCode As Integer
		  Dim Local_p_DdtKey_Param As MemoryBlock = COM.RBVariantToVARIANT(p_DdtKey_Param)
		  Dim Return_pDdt_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_DdtKey_Param, Return_pDdt_Param)
		  COM.FreeVARIANT(Local_p_DdtKey_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pDdt_Param  Then Return Nil
		    Return New UnityProLibset.IDdt(Return_pDdt_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Item", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Item_Func2(this As Ptr, p_DdtKey_Param As Ptr, ByRef pDdt_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.IDdts.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function _NewEnum_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New _NewEnum_Get_Func1( mThis.Ptr( 0 ).Ptr( 28 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    If Nil <> pVal_Param Then
			      Return New COM.IUnknown( pVal_Param )
			    End If
			  Else
			    Raise New COM.COMException("Failed on _NewEnum", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		_NewEnum As COM.IUnknown
	#tag EndComputedProperty


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
