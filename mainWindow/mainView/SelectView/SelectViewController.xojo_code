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
		  dim extraRoomForCountlabels as Integer = 20
		  Dim usefulHeight as Integer = selectView.height-extraRoomForListBoxHeader-extraRoomForFilterFields-extraRoomForCountlabels
		  
		  selectView.TextFieldFilterLeft.top= 0+margins
		  selectView.TextFieldFilterLeft.left= 0+margins
		  
		  selectView.ListViewLeft.top = 0+margins+extraRoomForListBoxHeader+extraRoomForFilterFields
		  selectView.ListViewLeft.left = 0+margins
		  selectView.ListViewLeft.Width = selectView.width*0.5-margins*1.5
		  selectView.ListViewLeft.Height = usefulHeight-margins*1.5
		  
		  selectView.LabelCountLeft.top = selectView.ListViewLeft.top+selectView.ListViewLeft.height+2
		  selectView.LabelCountLeft.left = selectView.ListViewLeft.left
		  selectView.LabelCountLeft.width = 200
		  selectView.LabelCountLeft.height = 20
		  
		  
		  selectView.TextFieldFilterRight.top = 0+margins
		  selectView.TextFieldFilterRight.left = selectView.width*0.5+margins*0.5
		  
		  selectView.ListViewRight.top = 0+margins+extraRoomForListBoxHeader+extraRoomForFilterFields
		  selectView.ListViewRight.left = selectView.width*0.5+margins*0.5
		  selectView.ListViewRight.Width = selectView.width*0.5-margins*1.5
		  selectView.ListViewRight.Height = usefulHeight-margins*1.5
		  
		  
		  selectView.LabelCountRight.top = selectView.ListViewRight.top+selectView.ListViewRight.height+2
		  selectView.LabelCountRight.left = selectView.ListViewRight.left
		  selectView.LabelCountRight.width = 200
		  selectView.LabelCountRight.height = 20
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor(new SelectView, app.dataModel.Prepare("SELECT * FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ?"))
		  
		  leftDataFilter = new fastDataFilter(selectData)
		  leftDataFilter.bindVariables(array(filterExpressionLeft, filterExpressionLeft))
		  leftDataFilter.Run
		  
		  rightDataFilter = new fastDataFilter(selectData)
		  rightDataFilter.bindVariables(array(filterExpressionRight, filterExpressionRight))
		  rightDataFilter.Run
		  
		  exportFolder =SpecialFolder.ApplicationData.child("UnifyPro")
		  if  not exportFolder.Exists then
		    exportFolder.CreateAsFolder
		  end if
		  
		  sourceFileLeft = exportFolder.Child("sourceLeft.txt")
		  sourceFileRight = exportFolder.Child("sourceRight.txt")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub exportAndCompare()
		  if (selectedCodeLeft <> "") and  (selectedCodeRight<> "")  then
		    
		    exportAsTextFile(sourceFileLeft,selectedCodeLeft)
		    exportAsTextFile(sourceFileRight, selectedCodeRight)
		    
		    app.mainWindowController.compareViewController.compare(sourceFileLeft, sourceFileRight)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub exportAsTextFile(file as FolderItem, contents as String)
		  Dim tos As TextOutputStream
		  If file <> Nil Then
		    tos = TextOutputStream.Create(file)
		    tos.WriteLine(contents)
		    tos.Close
		  End If
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
		Function selectType(list as JVTreeView, data as RecordSet) As String
		  // Start with no record selected in the dataset
		  data.MoveFirst
		  data.MovePrevious
		  
		  dim currentParrentRow as Integer = 0
		  dim selectedParentRow as Integer = -1
		  
		  dim currentParentCode as String
		  dim selectedParentCode as String = ""
		  
		  for rowNumber as Integer =  0 to list.listcount-1
		    
		    data.MoveNext
		    
		    // Unchek all the parentfolders
		    if list.RowIsFolder(rownumber) then
		      
		      currentParrentRow = rowNumber
		      currentParentCode = data.Field("cleanedUpcode").StringValue
		      list.CellState(currentParrentRow, 0) = CheckBox.CheckedStates.UnChecked
		      
		      //  It's a closed parentrow, skip over the extra invisible rows
		      if (list.Expanded(currentParrentRow) = FALSE) And (list.RowTag(rowNumber) <> nil ) then
		        dim closedRows(-1,-1) as String = list.RowTag(rowNumber)
		        for closedRow as Integer = 1 to ubound(closedRows)
		          data.MoveNext
		        next
		      end if
		      
		    end if
		    
		    if list.Selected(rowNumber) then
		      // Remember the selections parent and its code
		      selectedParentRow = currentParrentRow
		      selectedParentCode = currentParentCode
		      // Report the selected row while developing
		      #if DebugBuild then
		        dim installatie as String =data.Field("installatie").StringValue
		        dim kostenplaats as String =data.Field("kostenplaats").StringValue
		        System.DebugLog(installatie+", " +kostenplaats+" Selected")
		      #endif
		    end if
		  next
		  
		  // Reselect the parent type afterwords
		  if selectedParentRow >=0 then
		    list.CellState(selectedParentRow, 0) = CheckBox.CheckedStates.Checked
		  end if
		  
		  // and return the code
		  return selectedParentCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub showList(list as JVTreeView, data as recordset)
		  
		  If data <> Nil and data.RecordCount > 0  and not Data.EOF Then
		    
		    list.DeleteAllRows
		    
		    dim regelingen(-1,-1) as String
		    dim regelingCounter as Integer = 0
		    
		    dim previousTypeID as String = ""
		    
		    dim currentTypeID as String
		    dim procesDeel as String
		    dim numberOfChildren as Integer
		    
		    dim regelingNaam as String
		    dim installatie as String
		    dim kostenPlaats as String
		    dim filePath as String
		    
		    
		    While Not data.EOF
		      
		      currentTypeID = data.field("regelingTypeID").stringvalue
		      procesDeel = data.field("procesDeel").stringvalue
		      numberOfChildren = data.field("timesUsed").IntegerValue
		      
		      regelingNaam = data.field("naam").stringvalue
		      installatie = data.field("installatie").stringvalue
		      kostenPlaats = data.field("kostenPlaats").stringvalue
		      filePath = data.field("filePath").stringvalue
		      
		      
		      currentTypeID = data.IdxField(1).StringValue
		      
		      If (currentTypeID <>  previousTypeID) then
		        
		        dim previousRowNumber as integer = list.LastIndex
		        if previousRowNumber >=0 then
		          
		          // Copy Array
		          dim children(-1,-1) as String
		          dim numberOfRows as Integer=ubound(regelingen, 1)
		          dim numberOfColumns as Integer=ubound(regelingen, 2)
		          redim children(numberOfRows,numberOfColumns+1)
		          for rowNumber as Integer = 0 to numberOfRows
		            for columnNumber as Integer = 0 to numberOfColumns
		              children(rowNumber,columnNumber)=regelingen(rowNumber,columnNumber)
		            next
		          next
		          
		          list.RowTag(previousRowNumber) = children
		        end if
		        
		        dim regelingDescription as String = Str(numberOfChildren) + " Keer " + procesDeel + " Regeling " + currentTypeID
		        list.AddFolder(regelingDescription)
		        
		        redim regelingen(numberOfChildren-1, list.ColumnCount-1)
		        regelingCounter = 0
		        
		      end if
		      
		      redim regelingen(regelingCounter, list.ColumnCount-1)
		      regelingen(regelingCounter, 0) = regelingNaam
		      regelingen(regelingCounter, 1) = installatie
		      regelingen(regelingCounter, 2) = kostenPlaats
		      regelingen(regelingCounter, 3) = filePath
		      
		      
		      previousTypeID = currentTypeID
		      regelingCounter = regelingCounter+1
		      
		      data.MoveNext
		    Wend
		    
		    
		    dim previousRowNumber as integer = list.LastIndex
		    if previousRowNumber >=0 then
		      
		      // Copy Array
		      dim children(-1,-1) as String
		      dim numberOfRows as Integer=ubound(regelingen, 1)
		      dim numberOfColumns as Integer=ubound(regelingen, 2)
		      redim children(numberOfRows,numberOfColumns+1)
		      for rowNumber as Integer = 0 to numberOfRows
		        for columnNumber as Integer = 0 to numberOfColumns
		          children(rowNumber,columnNumber)=regelingen(rowNumber,columnNumber)
		        next
		      next
		      
		      list.RowTag(previousRowNumber) = children
		    end if
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub syncInterface(up as Boolean)
		  if up then
		    
		    
		    // Update the filtered result whenever the left filter is no longer running
		     if  leftDataFilter.State = Thread.NotRunning then
		      recordsLeft = leftDataFilter.foundRecords
		      showList(selectView.ListViewLeft, recordsLeft)
		      selectView.LabelCountLeft.Text = leftCount
		    end if
		    
		    
		    // Update the filtered result whenever the right filter is no longer running
		    if rightDataFilter.State = Thread.NotRunning then
		      recordsright = rightDataFilter.foundRecords
		      showList(selectView.ListViewRight, recordsright)
		      selectView.LabelCountRight.Text = rightCount
		    end if
		    
		  else
		    
		    
		  end if
		  
		  system.DebugLog("Links "+str(recordsleft.RecordCount)+" & Rechts " + str(recordsright.RecordCount))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		exportFolder As FolderItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim filterExpression as Variant = "%"+selectview.TextFieldFilterLeft.Text+"%"
			  Return filterExpression
			End Get
		#tag EndGetter
		filterExpressionLeft As Variant
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim filterExpression as Variant = "%"+selectview.TextFieldFilterRight.Text+"%"
			  Return filterExpression
			End Get
		#tag EndGetter
		filterExpressionRight As Variant
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim typesSearch as SQLitePreparedStatement = app.dataModel.Prepare("SELECT DISTINCT RegelingTypeID FROM Regelingen WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
			  typesSearch.BindType(array(filterExpressionLeft, filterExpressionLeft))
			  typesSearch.Bind(array(filterExpressionLeft, filterExpressionLeft))
			  
			  dim types as recordset = typesSearch.SQLSelect
			  
			  dim numberOfTypes as String = Str(types.RecordCount)
			  
			  dim numberOfRegelingen as String = Str(recordsLeft.RecordCount)
			  
			  Return numberOfTypes +" types op "+numberOfRegelingen
			End Get
		#tag EndGetter
		leftCount As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			_
		#tag EndNote
		leftDataFilter As fastDataFilter
	#tag EndProperty

	#tag Property, Flags = &h0
		recordsLeft As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		recordsRight As RecordSet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim typesSearch as SQLitePreparedStatement = app.dataModel.Prepare("SELECT DISTINCT RegelingTypeID FROM Regelingen WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
			  typesSearch.BindType(array(filterExpressionright,filterExpressionright))
			  typesSearch.Bind(array(filterExpressionright, filterExpressionright))
			  
			  dim types as recordset = typesSearch.SQLSelect
			  
			  dim numberOfTypes as String = Str(types.RecordCount)
			  
			  dim numberOfRegelingen as String = Str(recordsright.RecordCount)
			  
			  Return numberOfTypes +" types op "+numberOfRegelingen
			End Get
		#tag EndGetter
		rightCount As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			_
		#tag EndNote
		rightDataFilter As fastDataFilter
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
		selectedCodeLeft As String
	#tag EndProperty

	#tag Property, Flags = &h0
		selectedCodeRight As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SelectView(view)
			End Get
		#tag EndGetter
		selectView As SelectView
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		sourceFileLeft As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		sourceFileRight As FolderItem
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
			Name="leftCount"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rightCount"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="selectedCodeLeft"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="selectedCodeRight"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
