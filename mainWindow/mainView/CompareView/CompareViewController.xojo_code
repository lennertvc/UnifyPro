#tag Class
Protected Class CompareViewController
Inherits NSViewController
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
		  
		  // Execute Compare it trough the CLI of Compare-it when on the right platform
		  
		  #if TargetWindows then
		    dim compareShellController as new JVTerminalViewController
		    compareShellController.view = JVTerminalViewController.MainTerminalView
		    
		    compareShellController.Execute("c:\program files (x86)\Compare It!\wincmp3.exe",  leftFile.absolutepath +" "+ rightFile.absolutepath + " " +reportFile.absolutepath+"  /G:SH")
		  #endif
		  
		  showReport // On Mac OSX the last report created under Windows will be shown
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new CompareView, nil)
		  
		  leftMetaFilter = new JVbackGroundQuery(app.datamodel, "SELECT* FROM metaData WHERE regelingTypeID = ?")
		  leftMetaFilter.bindVariables()
		  leftMetaFilter.Run
		  
		  rightMetaFilter = new JVbackGroundQuery(app.datamodel, "SELECT* FROM metaData WHERE regelingTypeID = ?")
		  rightMetaFilter.bindVariables()
		  rightMetaFilter.Run
		  
		  dim reportFolder as folderitem = SpecialFolder.ApplicationData.child("UnifyPro")
		  system.debuglog(reportFolder.absolutePath)
		  
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
		Sub onViewActivate(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewResizing(sender as NSView)
		  autoLayout
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
		Sub showMetaData(leftType as Variant, rightType as Variant)
		  leftMetaFilter.bindVariables(array(leftType))
		  leftMetaFilter.run
		  
		  rightMetaFilter.bindVariables(array(rightType))
		  rightMetaFilter.run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showReport()
		  
		  compareView.ReportView.LoadPage(reportFile)
		  compareView.ReportView.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub syncInterface(up as Boolean)
		  if up then
		    
		    
		    // Update the filtered result whenever the left filter is no longer running
		    if  leftMetaFilter.State = Thread.NotRunning then
		      leftMetaRecords = leftMetaFilter.foundRecords
		      showList(compareView.ListMetaLeft, leftMetaRecords)
		    end if
		    
		    // Update the filtered result whenever the right filter is no longer running
		    if  rightMetaFilter.State = Thread.NotRunning then
		      rightMetaRecords = rightMetaFilter.foundRecords
		      showList(compareView.ListMetaRight, rightMetaRecords)
		    end if
		    
		  else
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return CompareView(view)
			End Get
		#tag EndGetter
		compareView As CompareView
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private leftMetaFilter As JVbackGroundQuery
	#tag EndProperty

	#tag Property, Flags = &h0
		leftMetaRecords As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		reportFile As folderitem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rightMetaFilter As JVbackGroundQuery
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
