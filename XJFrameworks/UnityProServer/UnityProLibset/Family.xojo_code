#tag Class
Protected Class Family
Inherits COM.IDispatch
	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Comment_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(connectEvents As Boolean = False)
		  #if TargetWin32
		    Dim clsid As MemoryBlock
		    Dim riid As MemoryBlock
		    
		    riid = COM.IIDFromString( "{D95AF066-32A2-11D6-A291-00062999F09F}" )
		    clsid = COM.IIDFromString( "{D95AF067-32A2-11D6-A291-00062999F09F}" )
		    
		    Dim p As Ptr
		    If COM.CoCreateInstance( clsid, nil, COM.CLSCTX_INPROC_SERVER or COM.CLSCTX_LOCAL_SERVER, riid, p ) = 0 then
		      If ObjectMap = Nil Then ObjectMap = New Dictionary
		      Super.Constructor( p )
		      If Not connectEvents Then Return
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ddts() As UnityProLibset.IDdts
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Ddts_Func1(mThis.Ptr( 0 ).Ptr(40 ))
		  Dim resultCode As Integer
		  Dim Return_pDdts_Param As Ptr
		  resultCode = func.Invoke(mThis, Return_pDdts_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pDdts_Param  Then Return Nil
		    Return New UnityProLibset.IDdts(Return_pDdts_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Ddts", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Ddts_Func1(this As Ptr, ByRef pDdts_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Destructor()
		  If ObjectMap <> Nil And ObjectMap.HasKey(Handle) Then ObjectMap.Remove(Handle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Dfbs() As UnityProLibset.IDfbs
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Dfbs_Func1(mThis.Ptr( 0 ).Ptr(44 ))
		  Dim resultCode As Integer
		  Dim Return_pDfbs_Param As Ptr
		  resultCode = func.Invoke(mThis, Return_pDfbs_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pDfbs_Param  Then Return Nil
		    Return New UnityProLibset.IDfbs(Return_pDfbs_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Dfbs", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Dfbs_Func1(this As Ptr, ByRef pDfbs_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Efbs() As UnityProLibset.IEfbs
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Efbs_Func1(mThis.Ptr( 0 ).Ptr(48 ))
		  Dim resultCode As Integer
		  Dim Return_pEfbs_Param As Ptr
		  resultCode = func.Invoke(mThis, Return_pEfbs_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pEfbs_Param  Then Return Nil
		    Return New UnityProLibset.IEfbs(Return_pEfbs_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Efbs", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Efbs_Func1(this As Ptr, ByRef pEfbs_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{D95AF066-32A2-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize(pWLIBMFamily_Param As COM.IUnknown, p_pLibset_Param As UnityProLibset.ILibset)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Initialize_Func2(mThis.Ptr( 0 ).Ptr(28 ))
		  Dim resultCode As Integer
		  Dim Local_pWLIBMFamily_Param As Ptr
		  Local_pWLIBMFamily_Param = pWLIBMFamily_Param.Handle
		  Dim Local_p_pLibset_Param As Ptr
		  Local_p_pLibset_Param = p_pLibset_Param.Handle
		  resultCode = func.Invoke(mThis, Local_pWLIBMFamily_Param, Local_p_pLibset_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Initialize", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Initialize_Func2(this As Ptr, pWLIBMFamily_Param As Ptr, p_pLibset_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Name_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.IFamily.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New Comment_Get_Func1( mThis.Ptr( 0 ).Ptr( 36 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on Comment", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		Comment As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mCookie As UInt32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPtrToVTable As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mVTable As MemoryBlock
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New Name_Get_Func1( mThis.Ptr( 0 ).Ptr( 32 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on Name", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected Shared ObjectMap As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Comment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
