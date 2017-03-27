#tag Class
Protected Class FillDatabase
	#tag Method, Flags = &h0
		Sub AddData(preProcessor as PreProcessor,datamodel as RegelingenDataBase,a() as Dictionary)
		  // Quit Unity if it's still running
		  Unitypro.quitall
		  
		  
		  
		  
		  
		  for j as integer = 0 to a.Ubound
		    
		    dim b() as Dictionary
		    dim c() as Dictionary
		    dim array0() as string
		    dim array1() as FolderItem
		    
		    //starup project + retrieve sectionnames
		    b=preprocessor.retrievesectionnames( a(j).value("file_folderitem") )
		    for z as integer=0 to b.Ubound
		      array1.append(b(z).Value("fileAsFolderItem"))
		    next
		    
		    //extract original code (destination table = regelingtypes, column = originalcode)
		    array0=preprocessor.extractoriginalcode(array1)
		    
		    //convert original code (destination table = regelingtypes, column = cleanedupcode)
		    c=preprocessor.convertCode(array0)
		    
		    //write to DB (table = RegelingTypes)
		    
		    for i as integer =0 to c.ubound
		      
		      //collect metadata
		      dim d as new Dictionary
		      d=preprocessor.FindMetaData(c(i).value("cleanedUpCode"))
		      
		      if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) <>0 then
		        call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") , datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")),b(i).value("section_FM"))
		      end if
		      if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) = 0 then
		        
		        if datamodel.lookupRecordMeta(d.Value("NumberW"),d.Value("NumberM"),d.Value("NumberV"),d.Value("Config"),d.Value("PIDControl"))= 0  then
		          call datamodel.addMetaData(d.Value("NumberW"),d.Value("NumberM"),d.Value("NumberV"),d.Value("Config"),d.Value("PIDControl"))
		          call datamodel.addcodetodb(array0(i) , c(i).value("cleanedUpCode") , c(i).value("proces"),datamodel.newpkfromtable("metaData"))
		          call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") ,datamodel.newpkfromtable("regelingTypes"),b(i).value("section_FM"))
		          
		        else
		          call datamodel.addcodetodb(array0(i) , c(i).value("cleanedUpCode") , c(i).value("proces"),datamodel.lookupRecordMeta(d.Value("NumberW"),d.Value("NumberM"),d.Value("NumberV"),d.Value("Config"),d.Value("PIDControl")))
		          call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") ,datamodel.newpkfromtable("regelingTypes"),b(i).value("section_FM"))
		        end if
		        
		      end if
		      
		      
		    next
		    
		    // Quit Unity if it's still running
		    Unitypro.quitall
		  next
		  
		End Sub
	#tag EndMethod


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
