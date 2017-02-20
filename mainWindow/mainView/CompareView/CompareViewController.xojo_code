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
		Sub compare(leftFile as folderItem, rightFile as FolderItem)
		  // Execute Compare it trough the CLI
		  
		  #if TargetWindows then
		    dim compareShellController as new JVTerminalViewController
		    compareShellController.view = JVTerminalViewController.MainTerminalView
		    
		    compareShellController.Execute("c:\program files (x86)\Compare It!\wincmp3.exe,"+leftFile.absolutepath +" "+ rightFile.absolutepath + " " +reportFile.absolutepath+"  /G:SH")
		  #endif
		  
		  showReport
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new CompareView, nil)
		  
		  
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
		Sub showReport()
		  
		  compareView.ReportView.LoadPage(reportFile)
		  compareView.ReportView.SetFocus
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

	#tag Property, Flags = &h0
		reportFile As folderitem
	#tag EndProperty


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
