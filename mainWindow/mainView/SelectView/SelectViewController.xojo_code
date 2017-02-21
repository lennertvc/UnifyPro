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
		  Super.Constructor(new SelectView, app.dataModel.Prepare("SELECT * FROM 'DefaultListing' WHERE filepath LIKE ? ORDER BY timesUsed DESC , regelingTypeID"))
		  
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
		  syncInterface(TRUE)
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
		      
		      dim regelingen(-1,-1) as String
		      dim regelingCounter as Integer = 0
		      
		      dim previousTypeID as String = ""
		      
		      dim currentTypeID as String
		      dim procesDeel as String
		      dim numberOfChildren as Integer
		      
		      dim installatie as String
		      dim kostenPlaats as String
		      dim filePath as String
		      
		      
		      While Not dataLeft.EOF
		        
		        currentTypeID = dataLeft.IdxField(1).stringvalue
		        procesDeel = dataLeft.IdxField(2).stringvalue
		        numberOfChildren = dataLeft.IdxField(3).IntegerValue
		        
		        installatie = dataLeft.IdxField(7).stringvalue
		        kostenPlaats = dataLeft.IdxField(8).stringvalue
		        filePath = dataLeft.IdxField(9).stringvalue
		        
		        
		        currentTypeID = dataLeft.IdxField(1).StringValue
		        
		        If currentTypeID <>  previousTypeID then
		          
		          dim previousRowNumber as integer = selectView.ListViewLeft.LastIndex
		          if previousRowNumber >=0 then
		            
		            //Deep Copy Array--Refactor this!!! with extends if possible on Array!!
		            dim children(-1,-1) as String
		            dim numberOfRows as Integer=ubound(regelingen, 1)
		            dim numberOfColumns as Integer=ubound(regelingen, 2)
		            redim children(numberOfRows,numberOfColumns+1)
		            for rowNumber as Integer = 0 to numberOfRows
		              for columnNumber as Integer = 0 to numberOfColumns
		                children(rowNumber,columnNumber+1)=regelingen(rowNumber,columnNumber)
		              next
		            next
		            
		            selectView.ListViewLeft.RowTag(previousRowNumber) = children
		          end if
		          
		          dim regelingDescription as String = Str(numberOfChildren) + " Keer " + procesDeel + " Regeling " + currentTypeID
		          selectView.ListViewLeft.AddFolder(regelingDescription)
		          
		          dim numberOfColumns as Integer = selectView.ListViewLeft.ColumnCount
		          redim regelingen(numberOfChildren, numberOfColumns-1)
		          regelingCounter = 0
		          
		        end if
		        
		        regelingen(regelingCounter, 0) = installatie
		        regelingen(regelingCounter, 1) = kostenPlaats
		        regelingen(regelingCounter, 2) = filePath
		        
		        
		        previousTypeID = currentTypeID
		        regelingCounter = regelingCounter+1
		        
		        dataLeft.MoveNext
		        
		      Wend
		      
		      dataLeft.Close
		      
		    end if
		    
		    
		    
		    // Fill the righthand TreeView
		    
		    dim rightFilterValue as Variant ="%"+selectview.TextFieldFilterright.Text+"%"
		    selectData.BindType(array(rightFilterValue))
		    selectData.Bind(array(rightFilterValue))
		    dim dataright as Recordset = selectData.SQLSelect
		    
		    If dataright <> Nil Then
		      
		      dim regelingen(-1,-1) as String
		      dim regelingCounter as Integer = 0
		      
		      dim previousTypeID as String = ""
		      
		      dim currentTypeID as String
		      dim procesDeel as String
		      dim numberOfChildren as Integer
		      
		      dim installatie as String
		      dim kostenPlaats as String
		      dim filePath as String
		      
		      
		      
		      
		      While Not dataright.EOF
		        
		        currentTypeID = dataright.IdxField(1).stringvalue
		        procesDeel = dataright.IdxField(2).stringvalue
		        numberOfChildren = dataright.IdxField(3).IntegerValue
		        
		        installatie = dataright.IdxField(7).stringvalue
		        kostenPlaats = dataright.IdxField(8).stringvalue
		        filePath = dataright.IdxField(9).stringvalue
		        
		        
		        currentTypeID = dataright.IdxField(1).StringValue
		        
		        If currentTypeID <>  previousTypeID then
		          
		          dim previousRowNumber as integer = selectView.ListViewright.LastIndex
		          if previousRowNumber >=0 then
		            
		            //Deep Copy Array--Refactor this!!! with extends if possible on Array!!
		            dim children(-1,-1) as String
		            dim numberOfRows as Integer=ubound(regelingen, 1)
		            dim numberOfColumns as Integer=ubound(regelingen, 2)
		            redim children(numberOfRows,numberOfColumns+1)
		            for rowNumber as Integer = 0 to numberOfRows
		              for columnNumber as Integer = 0 to numberOfColumns
		                children(rowNumber,columnNumber+1)=regelingen(rowNumber,columnNumber)
		              next
		            next
		            
		            selectView.ListViewright.RowTag(previousRowNumber) = children
		          end if
		          
		          dim regelingDescription as String = Str(numberOfChildren) + " Keer " + procesDeel + " Regeling " + currentTypeID
		          selectView.ListViewright.AddFolder(regelingDescription)
		          
		          dim numberOfColumns as Integer = selectView.ListViewright.ColumnCount
		          redim regelingen(numberOfChildren, numberOfColumns-1)
		          regelingCounter = 0
		          
		        end if
		        
		        regelingen(regelingCounter, 0) = installatie
		        regelingen(regelingCounter, 1) = kostenPlaats
		        regelingen(regelingCounter, 2) = filePath
		        
		        
		        previousTypeID = currentTypeID
		        regelingCounter = regelingCounter+1
		        
		        dataright.MoveNext
		        
		      Wend
		      
		      dataright.Close
		      
		    end if
		    
		    
		  else
		    
		    
		    
		    
		    
		    
		    
		  end if
		  
		  
		  
		  
		  
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
