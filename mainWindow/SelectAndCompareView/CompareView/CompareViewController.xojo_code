#tag Class
Protected Class CompareViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  
		  
		  me.view.top = me.view.window.height/4+margins
		  me.view.left = 0+margins
		  me.view.width = me.view.window.width-(margins*2)
		  me.view.height = me.view.window.height*3/4-(margins*2)
		  
		  dim extraRoomForLabel as Integer= 25
		  Dim usefulHeight as Integer = me.view.height-extraRoomForLabel
		  
		  CompareView.ListMetaLeft.top = extraRoomForLabel+0
		  CompareView.ListMetaLeft.left = 0
		  CompareView.ListMetaLeft.Width = me.view.width*1/2-margins/2
		  CompareView.ListMetaLeft.height = usefulHeight*1/3-margins/2
		  
		  CompareView.ListMetaRight.top =  extraRoomForLabel+0
		  CompareView.ListMetaRight.left = me.view.width*1/2+Margins/2
		  CompareView.ListMetaRight.Width = me.view.width*1/2-margins/2
		  CompareView.ListMetaRight.height = usefulHeight*1/3-margins/2
		  
		  CompareView.ReportView.top = extraRoomForLabel+usefulHeight*1/3+margins/2
		  CompareView.ReportView.left = 0
		  CompareView.ReportView.Width = me.view.width
		  CompareView.ReportView.height = usefulHeight*2/3-margins/2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub compare(leftFile as folderItem, rightFile as FolderItem)
		  // Execute Compare it trough the CLI
		  
		  dim compShellController as new JVTerminalViewController
		  compShellController.view = JVTerminalViewController.MainTerminalView
		  
		  compShellController.terminal.Execute("c:\program files (x86)\Compare It!\wincmp3.exe", leftFile.absolutepath +" "+ rightFile.absolutepath + " " +reportFile.absolutepath+"  /G:SH")
		  
		  showReport
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new CompareView, nil)
		  
		  dim reportFolder as folderitem = SpecialFolder.Temporary.child("UnifyPro")
		  dim reportName  as String = "CompareItReport.html"
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
		  compareView.ReportView.Enabled = TRUE
		  
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


	#tag Constant, Name = margins, Type = Double, Dynamic = False, Default = \"2", Scope = Public
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
