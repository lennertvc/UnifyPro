#tag Class
Protected Class Dfbs
Inherits COM.IDispatch
	#tag Method, Flags = &h0
		Sub Constructor(connectEvents As Boolean = False)
		  #if TargetWin32
		    Dim clsid As MemoryBlock
		    Dim riid As MemoryBlock
		    
		    riid = COM.IIDFromString( "{4F5675B5-3732-11D6-A291-00062999F09F}" )
		    clsid = COM.IIDFromString( "{4F5675B6-3732-11D6-A291-00062999F09F}" )
		    
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
		Sub Destructor()
		  If ObjectMap <> Nil And ObjectMap.HasKey(Handle) Then ObjectMap.Remove(Handle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{4F5675B5-3732-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(p_DfbKey_Param As Variant) As UnityProLibset.IDfb
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Item_Func2(mThis.Ptr( 0 ).Ptr(36 ))
		  Dim resultCode As Integer
		  Dim Local_p_DfbKey_Param As MemoryBlock = COM.RBVariantToVARIANT(p_DfbKey_Param)
		  Dim Return_pDfb_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_DfbKey_Param, Return_pDfb_Param)
		  COM.FreeVARIANT(Local_p_DfbKey_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pDfb_Param  Then Return Nil
		    Return New UnityProLibset.IDfb(Return_pDfb_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Item", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Item_Func2(this As Ptr, p_DfbKey_Param As Ptr, ByRef pDfb_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function LCItem(p_DfbKey_Param As Variant) As UnityProLibset.IDfb
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New LCItem_Func2(mThis.Ptr( 0 ).Ptr(36 ))
		  Dim resultCode As Integer
		  //Dim Local_p_DfbKey_Param As MemoryBlock = COM.RBVariantToVARIANT(p_DfbKey_Param)
		  Dim Local_p_DfbKey_Param As UnityEnum = VariantToUnityEnum(p_DfbKey_Param)
		  Dim Return_pDfb_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_DfbKey_Param, Return_pDfb_Param)
		  //COM.FreeVARIANT(Local_p_DfbKey_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pDfb_Param  Then Return Nil
		    Return New UnityProLibset.IDfb(Return_pDfb_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Item", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function LCItem_Func2(this As Ptr, p_DfbKey_Param As UnityEnum, ByRef pDfb_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.IDfbs.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function _NewEnum_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h1
		Protected mCookie As UInt32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPtrToVTable As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mVTable As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared ObjectMap As Dictionary
	#tag EndProperty

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
