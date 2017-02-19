#tag Class
Protected Class Ddt
Inherits COM.IDispatch
	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Comment_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(connectEvents As Boolean = False)
		  #if TargetWin32
		    Dim clsid As MemoryBlock
		    Dim riid As MemoryBlock
		    
		    riid = COM.IIDFromString( "{4F5675B7-3732-11D6-A291-00062999F09F}" )
		    clsid = COM.IIDFromString( "{4F5675B8-3732-11D6-A291-00062999F09F}" )
		    
		    Dim p As Ptr
		    If COM.CoCreateInstance( clsid, nil, COM.CLSCTX_INPROC_SERVER or COM.CLSCTX_LOCAL_SERVER, riid, p ) = 0 then
		      If ObjectMap = Nil Then ObjectMap = New Dictionary
		      Super.Constructor( p )
		      If Not connectEvents Then Return
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function DescriptiveForm_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Destructor()
		  If ObjectMap <> Nil And ObjectMap.HasKey(Handle) Then ObjectMap.Remove(Handle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{4F5675B7-3732-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function InfoSignature_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function InfoVersion_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Initialize(pWLIBMFFB_Param As COM.IUnknown)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Initialize_Func1(mThis.Ptr( 0 ).Ptr(28 ))
		  Dim resultCode As Integer
		  Dim Local_pWLIBMFFB_Param As Ptr
		  Local_pWLIBMFFB_Param = pWLIBMFFB_Param.Handle
		  resultCode = func.Invoke(mThis, Local_pWLIBMFFB_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Initialize", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Initialize_Func1(this As Ptr, pWLIBMFFB_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub ListArrayInfos(pSize_Param As Variant, pTypeCategory_Param As Variant, pMinRanges_Param As Variant, pMaxRanges_Param As Variant)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListArrayInfos_Func4(mThis.Ptr( 0 ).Ptr(64 ))
		  Dim resultCode As Integer
		  Dim Local_pSize_Param As New MemoryBlock(16)
		  Dim Local_pTypeCategory_Param As New MemoryBlock(16)
		  Dim Local_pMinRanges_Param As New MemoryBlock(16)
		  Dim Local_pMaxRanges_Param As New MemoryBlock(16)
		  resultCode = func.Invoke(mThis, Local_pSize_Param, Local_pTypeCategory_Param, Local_pMinRanges_Param, Local_pMaxRanges_Param)
		  pSize_Param = COM.VARIANTToRBVariant(Local_pSize_Param)
		  pTypeCategory_Param = COM.VARIANTToRBVariant(Local_pTypeCategory_Param)
		  pMinRanges_Param = COM.VARIANTToRBVariant(Local_pMinRanges_Param)
		  pMaxRanges_Param = COM.VARIANTToRBVariant(Local_pMaxRanges_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListArrayInfos", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListArrayInfos_Func4(this As Ptr, pSize_Param As Ptr, pTypeCategory_Param As Ptr, pMinRanges_Param As Ptr, pMaxRanges_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub ListSubFields(pSubfieldsNamesList_Param As Variant, pSubfieldsTypeNameList_Param As Variant, pSubfieldsTypeCategoryList_Param As Variant)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListSubFields_Func3(mThis.Ptr( 0 ).Ptr(60 ))
		  Dim resultCode As Integer
		  Dim Local_pSubfieldsNamesList_Param As New MemoryBlock(16)
		  Dim Local_pSubfieldsTypeNameList_Param As New MemoryBlock(16)
		  Dim Local_pSubfieldsTypeCategoryList_Param As New MemoryBlock(16)
		  resultCode = func.Invoke(mThis, Local_pSubfieldsNamesList_Param, Local_pSubfieldsTypeNameList_Param, Local_pSubfieldsTypeCategoryList_Param)
		  pSubfieldsNamesList_Param = COM.VARIANTToRBVariant(Local_pSubfieldsNamesList_Param)
		  pSubfieldsTypeNameList_Param = COM.VARIANTToRBVariant(Local_pSubfieldsTypeNameList_Param)
		  pSubfieldsTypeCategoryList_Param = COM.VARIANTToRBVariant(Local_pSubfieldsTypeCategoryList_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListSubFields", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListSubFields_Func3(this As Ptr, pSubfieldsNamesList_Param As Ptr, pSubfieldsTypeNameList_Param As Ptr, pSubfieldsTypeCategoryList_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Name_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.IDdt.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function TypeCategory_Get_Func1(this As Ptr, ByRef pVal_Param As eLibsetTypeCategory) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ValidationDate_Get_Func1(this As Ptr, ByRef pVal_Param As Ptr) As Integer
	#tag EndDelegateDeclaration


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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New DescriptiveForm_Get_Func1( mThis.Ptr( 0 ).Ptr( 44 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on DescriptiveForm", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		DescriptiveForm As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New InfoSignature_Get_Func1( mThis.Ptr( 0 ).Ptr( 48 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on InfoSignature", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		InfoSignature As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New InfoVersion_Get_Func1( mThis.Ptr( 0 ).Ptr( 52 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on InfoVersion", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		InfoVersion As String
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As eLibsetTypeCategory
			  Dim func As New TypeCategory_Get_Func1( mThis.Ptr( 0 ).Ptr( 40 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return pVal_Param
			  Else
			    Raise New COM.COMException("Failed on TypeCategory", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		TypeCategory As eLibsetTypeCategory
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pVal_Param As Ptr
			  Dim func As New ValidationDate_Get_Func1( mThis.Ptr( 0 ).Ptr( 56 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pVal_Param )
			  If 0 = resultCode Then
			    Return COM.BSTRToRBString( pVal_Param )
			  Else
			    Raise New COM.COMException("Failed on ValidationDate", resultCode )
			  End If
			  
			End Get
		#tag EndGetter
		ValidationDate As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Comment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DescriptiveForm"
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
			Name="InfoSignature"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InfoVersion"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="TypeCategory"
			Group="Behavior"
			Type="eLibsetTypeCategory"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidationDate"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
