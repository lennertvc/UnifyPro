#tag Class
Protected Class RootLibsetServer
Inherits COM.IDispatch
	#tag Method, Flags = &h0
		Sub Constructor(connectEvents As Boolean = False)
		  #if TargetWin32
		    Dim clsid As MemoryBlock
		    Dim riid As MemoryBlock
		    
		    riid = COM.IIDFromString( "{949FB1CD-31B1-11D6-A291-00062999F09F}" )
		    clsid = COM.IIDFromString( "{949FB1CE-31B1-11D6-A291-00062999F09F}" )
		    
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
		Sub Destructor()
		  If ObjectMap <> Nil And ObjectMap.HasKey(Handle) Then ObjectMap.Remove(Handle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{949FB1CD-31B1-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OpenApplication(p_bstrLibsetPathName_Param As String, p_eLanguage_Param As eLibsetLanguage) As UnityProLibset.ILibset
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New OpenApplication_Func3(mThis.Ptr( 0 ).Ptr(28 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrLibsetPathName_Param As Ptr
		  Local_p_bstrLibsetPathName_Param = COM.SysAllocString( p_bstrLibsetPathName_Param )
		  Dim Return_pLibset_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_bstrLibsetPathName_Param, p_eLanguage_Param, Return_pLibset_Param)
		  COM.SysFreeString(Local_p_bstrLibsetPathName_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pLibset_Param  Then Return Nil
		    Return New UnityProLibset.ILibset(Return_pLibset_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on OpenApplication", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OpenApplicationExt(p_bstrSystemLibsetPathName_Param As String, p_bstrCustomPathName_Param As String, p_eLanguage_Param As eLibsetLanguage) As UnityProLibset.ILibset
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New OpenApplicationExt_Func4(mThis.Ptr( 0 ).Ptr(32 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrSystemLibsetPathName_Param As Ptr
		  Local_p_bstrSystemLibsetPathName_Param = COM.SysAllocString( p_bstrSystemLibsetPathName_Param )
		  Dim Local_p_bstrCustomPathName_Param As Ptr
		  Local_p_bstrCustomPathName_Param = COM.SysAllocString( p_bstrCustomPathName_Param )
		  Dim Return_pLibset_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_bstrSystemLibsetPathName_Param, Local_p_bstrCustomPathName_Param, p_eLanguage_Param, Return_pLibset_Param)
		  COM.SysFreeString(Local_p_bstrSystemLibsetPathName_Param)
		  COM.SysFreeString(Local_p_bstrCustomPathName_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pLibset_Param  Then Return Nil
		    Return New UnityProLibset.ILibset(Return_pLibset_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on OpenApplicationExt", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function OpenApplicationExt_Func4(this As Ptr, p_bstrSystemLibsetPathName_Param As Ptr, p_bstrCustomPathName_Param As Ptr, p_eLanguage_Param As eLibsetLanguage, ByRef pLibset_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function OpenApplication_Func3(this As Ptr, p_bstrLibsetPathName_Param As Ptr, p_eLanguage_Param As eLibsetLanguage, ByRef pLibset_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.IRootLibsetServer.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod


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
