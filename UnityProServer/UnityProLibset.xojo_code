#tag Module
Protected Module UnityProLibset
	#tag PathToTypeLibrary = C : \ Program Files ( x86 ) \ Common Files \ Schneider Electric Shared \ Tlb \ LibsetServer . tlb
	#tag Enum, Name = eLibsetLanguage, Type = Integer, Flags = &h0
		LIBSRV_LANG_ENGLISH = 0
		  LIBSRV_LANG_SPANISH = 1
		  LIBSRV_LANG_FRENCH = 2
		  LIBSRV_LANG_ITALIAN = 3
		  LIBSRV_LANG_GERMAN = 4
		  LIBSRV_LANG_CHINESE = 5
		LIBSRV_LANG_JAPANESE = 6
	#tag EndEnum

	#tag Enum, Name = eLibsetPLCFamily, Type = Integer, Flags = &h0
		LIBSRV_PLCFAM_ALL = 0
		  LIBSRV_PLCFAM_PREMIUM = 1
		  LIBSRV_PLCFAM_QUANTUM = 2
		  LIBSRV_PLCFAM_MICRO_BASIC = 5
		  LIBSRV_PLCFAM_NET_MICRO = 6
		LIBSRV_PLCFAM_OPTIMIZED_MICRO = 7
	#tag EndEnum

	#tag Enum, Name = eLibsetPLCKind, Type = Integer, Flags = &h0
		LIBSRV_PLCKIND_ALL = 0
		  LIBSRV_PLCKIND_SIMULATION = 1
		  LIBSRV_PLCKIND_LEGACY16 = 2
		  LIBSRV_PLCKIND_LEGACY32 = 3
		LIBSRV_PLCKIND_HIGHEND = 4
	#tag EndEnum

	#tag Enum, Name = eLibsetTypeCategory, Type = Integer, Flags = &h0
		LIBSRV_TYPECAT_UNKNOWN = 0
		  LIBSRV_TYPECAT_EDT = 1
		  LIBSRV_TYPECAT_DDT_STRUCT = 2
		  LIBSRV_TYPECAT_DDT_ARRAY = 3
		  LIBSRV_TYPECAT_IODDT = 4
		  LIBSRV_TYPECAT_EFB = 5
		  LIBSRV_TYPECAT_DFB = 6
		LIBSRV_TYPECAT_ANONYMOUS_ARRAY = 7
	#tag EndEnum


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
End Module
#tag EndModule
