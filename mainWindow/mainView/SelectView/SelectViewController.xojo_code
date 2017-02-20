#tag Class
Protected Class SelectViewController
Inherits NSViewController
	#tag Method, Flags = &h0
		Sub autoLayout()
		  selectView.top = 0
		  selectView.left = 0
		  selectView.width = selectView.window.Width
		  selectView.height = selectView.window.Height*0.33
		  
		  dim extraRoomForListBoxHeader as Integer= 10
		  Dim extraRoomForFilterFields as Integer = 22
		  Dim usefulHeight as Integer = selectView.height-extraRoomForListBoxHeader-extraRoomForFilterFields
		  
		  selectView.TextFieldFilterLeft.top= 0+margins
		  selectView.TextFieldFilterLeft.left= 0+margins
		  
		  selectView.ListViewLeft.top = 0+margins+extraRoomForListBoxHeader+extraRoomForFilterFields
		  selectView.ListViewLeft.left = 0+margins
		  selectView.ListViewLeft.Width = selectView.width*0.5-margins*1.5
		  selectView.ListViewLeft.Height = usefulHeight-margins*1.5
		  
		  selectView.TextFieldFilterRight.top = 0+margins
		  selectView.TextFieldFilterRight.left = selectView.width*0.5+margins*0.5
		  
		  selectView.ListViewRight.top = 0+margins+extraRoomForListBoxHeader+extraRoomForFilterFields
		  selectView.ListViewRight.left = selectView.width*0.5+margins*0.5
		  selectView.ListViewRight.Width = selectView.width*0.5-margins*1.5
		  selectView.ListViewRight.Height = usefulHeight-margins*1.5
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new SelectView, app.dataModel.Prepare("SELECT * FROM 'Types En Regelingen' WHERE filepath LIKE ? ORDER BY timesUsed DESC , regelingTypeID"))
		  
		  exportFolder =SpecialFolder.ApplicationData.child("UnifyPro")
		  if  not exportFolder.Exists then
		    exportFolder.CreateAsFolder
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub exportSelected()
		  // if selectedLeft and selectedRight then
		  // 
		  // 
		  // 
		  // end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onviewActivate(sender as nsview)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewResizing(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectType(list as listbox, selectedRow as integer)
		  
		  for rowNumber as Integer =  0 to list.ListCount-1
		    list.CellState(rownumber, 0) = CheckBox.CheckedStates.Unchecked
		  next
		  
		  list.CellState(selectedRow, 0) = CheckBox.CheckedStates.Checked
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub syncInterface(up as Boolean)
		  if up then
		    
		    // Fill the lefthand TreeView
		    
		    dim leftFilterValue as Variant ="%"+selectview.TextFieldFilterLeft.Text+"%"
		    selectData.BindType(array(leftFilterValue))
		    selectData.Bind(array(leftFilterValue))
		    dim dataLeft as Recordset = selectData.SQLSelect
		    
		    If dataLeft <> Nil Then
		      
		      dim regelingType as String
		      dim regelingen(-1,-1) as String
		      dim regelingCounter as Integer
		      dim currentTypeID as String
		      dim previousTypeID as String
		      
		      redim regelingen(-1,-1)
		      regelingCounter = 0
		      previousTypeID  = ""
		      
		        While Not dataLeft.EOF
		        dim lastRownUmber as Integer = selectView.ListViewLeft.ListCount-1
		        
		        regelingType = dataLeft.IdxField(7).stringvalue+ " Keer " + dataLeft.IdxField(6).stringvalue + " Regeling " +dataLeft.IdxField(5).stringvalue
		        
		        redim regelingen(regelingCounter, 2)
		        regelingen(regelingCounter, 0) = dataLeft.IdxField(2).stringvalue
		        regelingen(regelingCounter, 1) = dataLeft.IdxField(3).stringvalue
		        regelingen(regelingCounter, 2) = dataLeft.IdxField(4).stringvalue
		        
		        currentTypeID = dataLeft.IdxField(5).StringValue
		        If currentTypeID <>  previousTypeID then
		          
		          if lastRownUmber >= 0 then
		            selectView.ListViewLeft.RowTag(lastRownUmber) = regelingen
		            regelingCounter = 0
		          end if
		          
		          selectView.ListViewLeft.AddFolder(regelingType)
		          
		        end if
		        
		            previousTypeID = currentTypeID
		            regelingCounter = regelingCounter+1
		            dataLeft.MoveNext
		            
		        Wend
		      
		        dataLeft.Close
		    End If
		    
		    
		  End If
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		exportFolder As FolderItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SQLitePreparedStatement(representedObject)
			End Get
		#tag EndGetter
		selectData As SQLitePreparedStatement
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		selectedLeft As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		selectedRight As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SelectView(view)
			End Get
		#tag EndGetter
		selectView As SelectView
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
			Name="selectedLeft"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="selectedRight"
			Group="Behavior"
			Type="Integer"
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
