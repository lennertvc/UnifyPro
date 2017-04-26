#tag Class
Protected Class CompareViewController
Inherits NSViewController
Implements JVBackgroundTaskDelegate
	#tag Method, Flags = &h0
		Sub addRow(sender as JVTreeView)
		  // Select Case sender
		  // 
		  // Case  compareView.ListMetaRight
		  
		  if sender.Cell(sender.LastIndex,0) <>"" and sender.Cell(sender.LastIndex,1) <>"" then
		    sender.addrow()
		  end if 
		  
		  // Case compareView.ListMetaLeft
		  // 
		  // if compareView.ListMetaLeft.Cell(compareView.ListMetaLeft.LastIndex,0) <>"" and compareView.ListMetaLeft.Cell(compareView.ListMetaLeft.LastIndex,1) <>"" then
		  // compareview.ListMetaLeft.addrow()
		  // end if 
		  // 
		  // End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub autoLayout()
		  compareView.top = compareView.window.height*0.33
		  compareView.left = 0
		  compareView.width = compareView.window.width
		  compareView.height = compareView.window.height*0.66
		  
		  dim extraRoomForLabel as Integer= 25
		  Dim usefulHeight as Integer = compareView.height-extraRoomForLabel
		  
		  compareView.ListMetaLeft.top = 0+extraRoomForLabel+margins
		  CompareView.ListMetaLeft.left =  0+margins
		  CompareView.ListMetaLeft.Width =compareView.width*0.5-margins*1.5
		  CompareView.ListMetaLeft.height = usefulHeight*0.33-margins*1.5
		  
		  CompareView.ListMetaRight.top =  0+extraRoomForLabel+margins
		  CompareView.ListMetaRight.left = compareView.width*0.5+margins*0.5
		  CompareView.ListMetaRight.Width = compareView.width*0.5-margins*1.5
		  CompareView.ListMetaRight.height = usefulHeight*0.33-margins*1.5
		  
		  CompareView.ReportView.top = extraRoomForLabel+usefulHeight*0.33+margins*0.5
		  CompareView.ReportView.left = 0+margins
		  CompareView.ReportView.Width = compareView.width-2*margins
		  CompareView.ReportView.height = usefulHeight*0.66-margins*1.5
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub compare(leftFile as JVTextFile, rightFile as JVTextFile)
		  
		  if (leftFile <> nil) and (rightFile <> nil) then
		    // Execute Compare it trough the CLI of Compare-it when on the right platform
		    
		    #if TargetWindows then
		      dim compareShellController as new JVTerminalViewController
		      compareShellController.view = JVTerminalViewController.MainTerminalView
		      
		      compareShellController.Execute("c:\program files (x86)\Compare It!\wincmp3.exe",  leftFile.absolutepath +" "+ rightFile.absolutepath + " " +reportFile.absolutepath+"  /G:SH")
		      
		    #endif
		    
		    showReport // On Mac OSX the last report created under Windows will be shown
		    
		    leftFile.delete
		    rightFile.delete
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new CompareView, app.datamodel)
		  
		  leftMetaFilter = new JVbackGroundQuery(compareData, "SELECT* FROM metaData WHERE regelingTypeID = ?")
		  leftMetaFilter.backgroundTaskDelegate = me
		  leftMetaFilter.bindVariables()
		  leftMetaFilter.Run
		  
		  rightMetaFilter = new JVbackGroundQuery(compareData, "SELECT* FROM metaData WHERE regelingTypeID = ?")
		  rightMetaFilter.backgroundTaskDelegate = me
		  rightMetaFilter.bindVariables()
		  rightMetaFilter.Run
		  
		  
		  dim reportFolder as folderitem = SpecialFolder.ApplicationData.child("UnifyPro")
		  
		  dim reportName  as String
		  #if TargetWindows then
		    reportName = "CompareItReport.html"
		  #else 
		    reportName ="ExampleReport.html"
		  #endif
		  reportFile = reportFolder.Child(reportName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub modifyMetaData(sender as JVTreeView,row as integer,column as integer,ID as integer,dbRecordset as RecordSet)
		  //compare data between listbox and database => UPDATE - INSERT - DELETE
		  
		  
		  If dbRecordset <> Nil and dbRecordset.RecordCount > 0  and not dbRecordset.EOF Then
		    
		    
		    //both rows contain data
		    if sender.cell(row,0)<>"" and sender.cell(row,1)<>"" then
		      
		      //DB count = cell listcount
		      if dbRecordset.RecordCount=sender.ListCount or  dbRecordset.RecordCount < sender.ListCount  then 
		        dim key as String
		        dim value as String
		        dim match as boolean =false
		        
		        //check for updates through use of DB key's 
		        While Not dbRecordset.EOF
		          match = false
		          key = dbRecordset.field("key").stringvalue
		          value = dbRecordset.field("value").stringvalue
		          
		          for index as integer =0 to dbRecordset.RecordCount-1
		            if key = sender.Cell(index,0) then
		              match=true
		              if value <> sender.Cell(index,1) then
		                if sender.Cell(index,1) =""  then
		                  app.dataModel.SQLExecute("DELETE FROM metaData WHERE key= '"+key+"';")
		                else
		                  app.dataModel.SQLExecute ( "UPDATE metaData SET Value = '"+sender.Cell(index,1)+"'"+" WHERE metaDataID = '"+dbRecordset.field("metaDataID").stringvalue+"';" )
		                end if
		              end if
		            end if
		          next
		          
		          //if DB key not found => regenerate metadata
		          if not match then
		            app.dataModel.SQLExecute("DELETE FROM metaData WHERE regelingTypeID= '"+str(ID)+"';")
		            for j as integer = 0 to Sender.ListCount -1
		              dim rowRecord as new DatabaseRecord
		              if sender.Cell(j,0)<>"" and sender.Cell(j,1) <>""  then
		                rowRecord.Column("Key")=sender.Cell(j,0)
		                rowRecord.Column("Value")=sender.cell(j,1)
		                rowRecord.Column("RegelingTypeID")=str(ID)
		                app.dataModel.InsertRecord("metaData",rowRecord)
		              end if
		            next
		          end if
		          
		          dbRecordset.MoveNext
		        Wend
		      end if
		      
		      //DB count < cell listcount
		      if dbRecordset.RecordCount < sender.ListCount then
		        for i as integer = dbRecordset.recordcount to sender.ListCount -1
		          dim rowRecord as new DatabaseRecord
		          if sender.Cell(i,0)<>"" and sender.Cell(i,1) <>""  then
		            rowRecord.Column("Key")=sender.Cell(i,0)
		            rowRecord.Column("Value")=sender.cell(i,1)
		            rowRecord.Column("RegelingTypeID")=str(ID)
		            app.dataModel.InsertRecord("metaData",rowRecord)
		          end if
		        next
		      end if
		      
		    end if
		    
		    
		    
		    //only one or no cells contain data => regenerate metadata
		    if sender.cell(row,0)="" or sender.cell(row,1)="" then
		      app.dataModel.SQLExecute("DELETE FROM metaData WHERE regelingTypeID= '"+str(ID)+"';")
		      for l as integer = 0 to sender.ListCount -1
		        dim rowRecord as new DatabaseRecord
		        if sender.Cell(l,0)<>"" or sender.Cell(l,1)<>"" then
		          rowRecord.Column("Key")=sender.Cell(l,0)
		          rowRecord.Column("Value")=sender.cell(l,1)
		          rowRecord.Column("RegelingTypeID")=str(ID)
		          app.dataModel.InsertRecord("metaData",rowRecord)
		        end if
		        
		      next
		    end if
		    
		    
		    
		    
		  end if
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onTaskFinished(sender as JVBackgroundTask)
		  // Part of the JVBackgroundTaskDelegate interface.
		  
		  Select Case sender
		    
		  Case  leftMetaFilter
		    
		    leftMetaRecords = leftMetaFilter.foundRecords
		    showList(compareView.ListMetaLeft, leftMetaRecords)
		    
		  Case rightMetaFilter
		    
		    rightMetaRecords = rightMetaFilter.foundRecords
		    showList(compareView.ListMetaRight, rightMetaRecords)
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewActivate(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewResizing(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showLeftMetaData(type as Variant)
		  if type <> -1 then
		    leftMetaFilter.bindVariables(array(type))
		    leftMetaFilter.run
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub showList(list as JVTreeView, data as recordset)
		  
		  If data <> Nil and data.RecordCount > 0  and not Data.EOF Then
		    
		    list.DeleteAllRows
		    
		    dim key as String
		    dim value as String
		    
		    While Not data.EOF
		      
		      key = data.field("key").stringvalue
		      value = data.field("value").stringvalue
		      
		      list.AddRow(array(key, value))
		      
		      data.MoveNext
		    Wend
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showReport()
		  
		  compareView.ReportView.LoadPage(reportFile)
		  compareView.ReportView.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showRightMetaData(type as Variant)
		  if type <> nil then
		    rightMetaFilter.bindVariables(array(type))
		    rightMetaFilter.run
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub syncInterface(optional up as Boolean =TRUE)
		  if up then
		    
		    
		  else
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SQLiteDatabase(representedObject)
			End Get
		#tag EndGetter
		compareData As SQLiteDatabase
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return CompareView(view)
			End Get
		#tag EndGetter
		compareView As CompareView
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		leftMetaFilter As JVbackGroundQuery
	#tag EndProperty

	#tag Property, Flags = &h0
		leftMetaRecords As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		reportFile As folderitem
	#tag EndProperty

	#tag Property, Flags = &h0
		rightMetaFilter As JVbackGroundQuery
	#tag EndProperty

	#tag Property, Flags = &h0
		rightMetaRecords As RecordSet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		selectViewController As SelectViewController
	#tag EndComputedProperty


	#tag Constant, Name = margins, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant


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
