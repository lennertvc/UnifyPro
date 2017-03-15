#tag Class
Protected Class FillDatabase
	#tag Method, Flags = &h0
		Sub AddData(preProcessor as PreProcessor,datamodel as RegelingenDataBase,a() as Dictionary)
		  // Quit Unity if it's still running
		  Unitypro.quitall
		  
		  
		  
		  dim b() as Dictionary
		  dim c() as Dictionary
		  dim array0() as string
		  dim te as string
		  dim je as integer = 0
		  
		  
		  
		  
		  
		  
		  
		  if  conversionComplete then
		    
		    //return all stu files to original location
		    while je <500
		      for i as integer = 1 to SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").count
		        dim s as string = SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").item(i).name
		        for j as integer = 0 to a.Ubound
		          te=a(j).value("file_name")
		          if s= te then
		            dim t as FolderItem
		            t=new folderitem(a(j).value("file_path"),FolderItem.PathTypeNative)
		            t.delete
		            SpecialFolder.ApplicationData.child("UnifyPro").Child("UnityProjects").item(i).movefileto t
		            exit for
		          end if
		        next
		      next
		      je=je+1
		    wend
		    
		    
		    
		    for j as integer = 0 to a.Ubound
		      
		      dim tt as folderitem =a(j).value("file_folderitem")
		      
		      //starup project + retrieve sectionnames
		      b=preprocessor.retrievesectionnames( a(j).value("file_folderitem") )
		      
		      //extract original code (destination table = regelingtypes, column = originalcode)
		      array0=preprocessor.extractoriginalcode
		      
		      //convert original code (destination table = regelingtypes, column = cleanedupcode)
		      c=preprocessor.convertCode(array0)
		      
		      //write to DB (table = RegelingTypes)
		      
		      for i as integer =0 to c.ubound
		        
		        if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) <>0 then
		          call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") , datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")))
		        end if
		        if datamodel.lookupRecord("regelingTypes","cleanedUpCode",c(i).value("cleanedUpCode")) = 0 then
		          call datamodel.addcodetodb(array0(i) , c(i).value("cleanedUpCode") , " " , c(i).value("proces"))
		          call datamodel.addFilePath( a(j).value("file_path") , a(j).value("file_RWZI") , a(j).value("file_KP") , b(i).value("section_name") ,datamodel.newpkfromtable("regelingTypes"))
		        end if
		        
		        
		      next
		      
		      // Quit Unity if it's still running
		      Unitypro.quitall
		    next
		    
		  end if
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
