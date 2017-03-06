#tag Class
Protected Class ILibset
Inherits COM.IDispatch
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // This class is not instantiable
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Count_Func1(mThis.Ptr( 0 ).Ptr(40 ))
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
		Sub CurrentVersion(ByRef bstrManufactorVersion_Param As String, ByRef bstrCustomVersion_Param As String)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New CurrentVersion_Func2(mThis.Ptr( 0 ).Ptr(28 ))
		  Dim resultCode As Integer
		  Dim Local_bstrManufactorVersion_Param As Ptr = COM.SysAllocString( bstrManufactorVersion_Param )
		  Dim Local_bstrCustomVersion_Param As Ptr = COM.SysAllocString( bstrCustomVersion_Param )
		  resultCode = func.Invoke(mThis, Local_bstrManufactorVersion_Param, Local_bstrCustomVersion_Param)
		  bstrManufactorVersion_Param = COM.BSTRToRBString(Local_bstrManufactorVersion_Param)
		  bstrCustomVersion_Param = COM.BSTRToRBString(Local_bstrCustomVersion_Param)
		  COM.SysFreeString(Local_bstrManufactorVersion_Param)
		  COM.SysFreeString(Local_bstrCustomVersion_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on CurrentVersion", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function CurrentVersion_Func2(this As Ptr, ByRef bstrManufactorVersion_Param As Ptr, ByRef bstrCustomVersion_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Family(p_bstrLibraryName_Param As String, p_bstrFamilyName_Param As String) As UnityProLibset.IFamily
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Family_Func3(mThis.Ptr( 0 ).Ptr(60 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrLibraryName_Param As Ptr
		  Local_p_bstrLibraryName_Param = COM.SysAllocString( p_bstrLibraryName_Param )
		  Dim Local_p_bstrFamilyName_Param As Ptr
		  Local_p_bstrFamilyName_Param = COM.SysAllocString( p_bstrFamilyName_Param )
		  Dim Return_pFamily_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_bstrLibraryName_Param, Local_p_bstrFamilyName_Param, Return_pFamily_Param)
		  COM.SysFreeString(Local_p_bstrLibraryName_Param)
		  COM.SysFreeString(Local_p_bstrFamilyName_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pFamily_Param  Then Return Nil
		    Return New UnityProLibset.IFamily(Return_pFamily_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Family", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Family_Func3(this As Ptr, p_bstrLibraryName_Param As Ptr, p_bstrFamilyName_Param As Ptr, ByRef pFamily_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function GetElement(p_bstrTypeName_Param As String, ByRef peTypeCategory_Param As eLibsetTypeCategory) As COM.IUnknown
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New GetElement_Func3(mThis.Ptr( 0 ).Ptr(68 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrTypeName_Param As Ptr
		  Local_p_bstrTypeName_Param = COM.SysAllocString( p_bstrTypeName_Param )
		  Dim Return_pElement_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_bstrTypeName_Param, peTypeCategory_Param, Return_pElement_Param)
		  COM.SysFreeString(Local_p_bstrTypeName_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pElement_Param  Then Return Nil
		    Return New COM.IUnknown(Return_pElement_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on GetElement", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function GetElement_Func3(this As Ptr, p_bstrTypeName_Param As Ptr, ByRef peTypeCategory_Param As eLibsetTypeCategory, ByRef pElement_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Shared Function IID() As MemoryBlock
		  Return COM.IIDFromString("{949FB1CF-31B1-11D6-A291-00062999F09F}")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(p_key_Param As Variant) As UnityProLibset.ILibrary
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Item_Func2(mThis.Ptr( 0 ).Ptr(44 ))
		  Dim resultCode As Integer
		  Dim Local_p_key_Param As MemoryBlock = COM.RBVariantToVARIANT(p_key_Param)
		  Dim Return_pLibrary_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_key_Param, Return_pLibrary_Param)
		  COM.FreeVARIANT(Local_p_key_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pLibrary_Param  Then Return Nil
		    Return New UnityProLibset.ILibrary(Return_pLibrary_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Item", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Item_Func2(this As Ptr, p_key_Param As Ptr, ByRef pLibrary_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Library(p_bstrLibraryName_Param As String) As UnityProLibset.ILibrary
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New Library_Func2(mThis.Ptr( 0 ).Ptr(52 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrLibraryName_Param As Ptr
		  Local_p_bstrLibraryName_Param = COM.SysAllocString( p_bstrLibraryName_Param )
		  Dim Return_pLibrary_Param As Ptr
		  resultCode = func.Invoke(mThis, Local_p_bstrLibraryName_Param, Return_pLibrary_Param)
		  COM.SysFreeString(Local_p_bstrLibraryName_Param)
		  If resultCode = 0 Then
		    If Nil = Return_pLibrary_Param  Then Return Nil
		    Return New UnityProLibset.ILibrary(Return_pLibrary_Param)
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on Library", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function Library_Func2(this As Ptr, p_bstrLibraryName_Param As Ptr, ByRef pLibrary_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ListAttributesSupported(p_eTypeCategory_Param As eLibsetTypeCategory, p_bstrIdentKeyCode_Param As String) As Variant
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListAttributesSupported_Func3(mThis.Ptr( 0 ).Ptr(32 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrIdentKeyCode_Param As Ptr
		  Local_p_bstrIdentKeyCode_Param = COM.SysAllocString( p_bstrIdentKeyCode_Param )
		  Dim Return_pAttributesDescription_Param As Ptr
		  Dim pAttributesDescription_Param_MB As New MemoryBlock(16)
		  Return_pAttributesDescription_Param = pAttributesDescription_Param_MB
		  resultCode = func.Invoke(mThis, p_eTypeCategory_Param, Local_p_bstrIdentKeyCode_Param, Return_pAttributesDescription_Param)
		  COM.SysFreeString(Local_p_bstrIdentKeyCode_Param)
		  If resultCode = 0 Then
		    Dim retVal As Variant = COM.VARIANTToRBVariant(Return_pAttributesDescription_Param)
		    COM.FreeVARIANT(Return_pAttributesDescription_Param)
		    Return retVal
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListAttributesSupported", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListAttributesSupported_Func3(this As Ptr, p_eTypeCategory_Param As eLibsetTypeCategory, p_bstrIdentKeyCode_Param As Ptr, pAttributesDescription_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub ListAttributesValues(p_bstrLibraryName_Param As String, p_bstrFamilyName_Param As String, p_eTypeCategory_Param As eLibsetTypeCategory, p_ListOfAttributesToRead_Param As Variant, pListOfAttributesValues_Param As Variant, pListOfErrorCodes_Param As Variant, pListOfErrorStrings_Param As Variant)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListAttributesValues_Func7(mThis.Ptr( 0 ).Ptr(64 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrLibraryName_Param As Ptr
		  Local_p_bstrLibraryName_Param = COM.SysAllocString( p_bstrLibraryName_Param )
		  Dim Local_p_bstrFamilyName_Param As Ptr
		  Local_p_bstrFamilyName_Param = COM.SysAllocString( p_bstrFamilyName_Param )
		  Dim Local_p_ListOfAttributesToRead_Param As MemoryBlock = COM.RBVariantToVARIANT(p_ListOfAttributesToRead_Param)
		  Dim Local_pListOfAttributesValues_Param As New MemoryBlock(16)
		  Dim Local_pListOfErrorCodes_Param As New MemoryBlock(16)
		  Dim Local_pListOfErrorStrings_Param As New MemoryBlock(16)
		  resultCode = func.Invoke(mThis, Local_p_bstrLibraryName_Param, Local_p_bstrFamilyName_Param, p_eTypeCategory_Param, Local_p_ListOfAttributesToRead_Param, Local_pListOfAttributesValues_Param, Local_pListOfErrorCodes_Param, Local_pListOfErrorStrings_Param)
		  pListOfAttributesValues_Param = COM.VARIANTToRBVariant(Local_pListOfAttributesValues_Param)
		  pListOfErrorCodes_Param = COM.VARIANTToRBVariant(Local_pListOfErrorCodes_Param)
		  pListOfErrorStrings_Param = COM.VARIANTToRBVariant(Local_pListOfErrorStrings_Param)
		  COM.SysFreeString(Local_p_bstrLibraryName_Param)
		  COM.SysFreeString(Local_p_bstrFamilyName_Param)
		  COM.FreeVARIANT(Local_p_ListOfAttributesToRead_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListAttributesValues", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListAttributesValues_Func7(this As Ptr, p_bstrLibraryName_Param As Ptr, p_bstrFamilyName_Param As Ptr, p_eTypeCategory_Param As eLibsetTypeCategory, p_ListOfAttributesToRead_Param As Ptr, pListOfAttributesValues_Param As Ptr, pListOfErrorCodes_Param As Ptr, pListOfErrorStrings_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ListFamily(p_bstrLibraryName_Param As String) As Variant
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListFamily_Func2(mThis.Ptr( 0 ).Ptr(56 ))
		  Dim resultCode As Integer
		  Dim Local_p_bstrLibraryName_Param As Ptr
		  Local_p_bstrLibraryName_Param = COM.SysAllocString( p_bstrLibraryName_Param )
		  Dim Return_pListOfFamilyName_Param As Ptr
		  Dim pListOfFamilyName_Param_MB As New MemoryBlock(16)
		  Return_pListOfFamilyName_Param = pListOfFamilyName_Param_MB
		  resultCode = func.Invoke(mThis, Local_p_bstrLibraryName_Param, Return_pListOfFamilyName_Param)
		  COM.SysFreeString(Local_p_bstrLibraryName_Param)
		  If resultCode = 0 Then
		    Dim retVal As Variant = COM.VARIANTToRBVariant(Return_pListOfFamilyName_Param)
		    COM.FreeVARIANT(Return_pListOfFamilyName_Param)
		    Return retVal
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListFamily", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListFamily_Func2(this As Ptr, p_bstrLibraryName_Param As Ptr, pListOfFamilyName_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ListLibrary() As Variant
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New ListLibrary_Func1(mThis.Ptr( 0 ).Ptr(48 ))
		  Dim resultCode As Integer
		  Dim Return_pListOfLibraryName_Param As Ptr
		  Dim pListOfLibraryName_Param_MB As New MemoryBlock(16)
		  Return_pListOfLibraryName_Param = pListOfLibraryName_Param_MB
		  resultCode = func.Invoke(mThis, Return_pListOfLibraryName_Param)
		  If resultCode = 0 Then
		    Dim retVal As Variant = COM.VARIANTToRBVariant(Return_pListOfLibraryName_Param)
		    COM.FreeVARIANT(Return_pListOfLibraryName_Param)
		    Return retVal
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on ListLibrary", resultCode)
		  End If
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function ListLibrary_Func1(this As Ptr, pListOfLibraryName_Param As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Operator_Convert(rhs As COM.IUnknown)
		  If rhs.Handle = Nil Then Return
		  Dim p As Ptr
		  If 0 = rhs.QueryInterface( UnityProLibset.ILibset.IID, p ) Then
		    mThis = p
		  Else
		    Raise New IllegalCastException
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFilter(p_PlcFamily_Param As eLibsetPLCFamily, p_PlcKind_Param As eLibsetPLCKind)
		  If mThis = Nil Then Raise New NilObjectException
		  Dim func As New SetFilter_Func2(mThis.Ptr( 0 ).Ptr(72 ))
		  Dim resultCode As Integer
		  resultCode = func.Invoke(mThis, p_PlcFamily_Param, p_PlcKind_Param)
		  If resultCode = 0 Then
		  Else // Throw Exception
		    Raise New COM.COMException("Failed on SetFilter", resultCode)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function SetFilter_Func2(this As Ptr, p_PlcFamily_Param As eLibsetPLCFamily, p_PlcKind_Param As eLibsetPLCKind) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function _NewEnum_Get_Func1(this As Ptr, ByRef pLibraryEnum_Param As Ptr) As Integer
	#tag EndDelegateDeclaration


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mThis = Nil Then Raise New NilObjectException
			  Dim pLibraryEnum_Param As Ptr
			  Dim func As New _NewEnum_Get_Func1( mThis.Ptr( 0 ).Ptr( 36 ) )
			  Dim resultCode As Integer = func.Invoke( mThis, pLibraryEnum_Param )
			  If 0 = resultCode Then
			    If Nil <> pLibraryEnum_Param Then
			      Return New COM.IUnknown( pLibraryEnum_Param )
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
