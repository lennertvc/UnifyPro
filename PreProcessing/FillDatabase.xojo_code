#tag Class
Protected Class FillDatabase
	#tag Method, Flags = &h0
		Sub AddData(preProcessor as PreProcessor,datamodel as RegelingenDataBase,a() as Dictionary)
		  // Quit Unity if it's still running
		  Unitypro.quitall
		  
		  //start loop
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
		    
		    //write info to DB 
		    for i as integer =0 to c.ubound
		      
		      //collect metadata
		      dim d as new Dictionary
		      d=preprocessor.FindMetaData(c(i).value("cleanedUpCode"))
		      
		      //check for removed
		      dim match as boolean = false
		      dim deletedSections as Recordset =  datamodel.SQLSelect("Select naam From regelingen where Installatie= '"+a(j).value("file_RWZI")+"'"+" AND filePath = '"+a(j).value("file_path")+"';")
		      if deletedSections <> nil then
		        while not deletedSections.eof
		          match=false
		          for y as integer = 0 to c.ubound
		            if b(y).value("section_name") =deletedSections.Field("naam").StringValue then
		              match=true
		              exit for
		            end if
		          next
		          if match = false then
		            datamodel.SQLExecute("DELETE FROM regelingen WHERE regelingTypeID= '"+str(datamodel.lookupChanges( a(j).value("file_RWZI") , a(j).value("file_path"), deletedSections.Field("naam").StringValue ))+"';")
		            JVBackendViewController.sharedBackendViewController.logController.logAsPlainText(deletedSections.Field("naam").StringValue + " has been deleted on location "+a(j).value("file_path"))
		          end if
		          deletedSections.movenext
		        wend
		      end if
		      
		      
		      //check presence of section_name in DB
		      dim keySection as integer = datamodel.lookupChanges( a(j).value("file_RWZI") , a(j).value("file_path"), b(i).value("section_name") )
		      if  keySection<> 0 then
		        dim f as RecordSet = datamodel.SQLSelect( "Select cleanedUpCode From regelingTypes where regelingTypeID= '"+str(keySection)+"'")
		        if c(i).value("cleanedUpCode") <> f.Field("cleanedUpCode").StringValue then
		          datamodel.SQLExecute("DELETE FROM regelingen WHERE regelingTypeID= '"+str(keySection)+"';")
		          JVBackendViewController.sharedBackendViewController.logController.logAsPlainText( b(i).value("section_name") + " has been changed on location "+a(j).value("file_path"))
		        else
		          goto label
		        end if
		      else
		        JVBackendViewController.sharedBackendViewController.logController.logAsPlainText( b(i).value("section_name") + " has been added on location "+a(j).value("file_path"))
		      end if
		      
		      //check presence of clean code in DB
		      if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) <>0 then
		        call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") , datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")),b(i).value("section_FM"))
		      end if
		      
		      
		      if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) = 0 then
		        
		        call datamodel.addcodetodb(array0(i) , c(i).value("cleanedUpCode") , c(i).value("proces"))
		        call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") ,datamodel.newpkfromtable("regelingTypes"),b(i).value("section_FM"))
		        call datamodel.addMetaData("aantal werktuigen",d.Value("NumberW"),datamodel.newpkfromtable("regelingTypes"))
		        call datamodel.addMetaData("aantal metingen",d.Value("NumberM"),datamodel.newpkfromtable("regelingTypes"))
		        call datamodel.addMetaData("aantal vlotters",d.Value("NumberV"),datamodel.newpkfromtable("regelingTypes"))
		        call datamodel.addMetaData("opstelling",d.Value("Config"),datamodel.newpkfromtable("regelingTypes"))
		        call datamodel.addMetaData("PID",d.Value("PIDControl"),datamodel.newpkfromtable("regelingTypes"))
		      end if
		      
		      //label
		      label:
		      system.debuglog(b(i).value("section_name") + " " +a(j).value("file_RWZI"))
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
