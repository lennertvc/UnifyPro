#tag Class
Protected Class SelectViewController
Inherits NSViewController
Implements JVBackgroundTaskDelegate
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
		  
		  leftDataFilter = new JVbackGroundQuery(app.dataModel, "SELECT * FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
		  leftDataFilter.backgroundTaskDelegate = me
		  leftDataFilter.bindVariables()
		  leftDataFilter.Run
		  
		  rightDataFilter = new JVbackGroundQuery(app.dataModel, "SELECT * FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
		  rightDataFilter.backgroundTaskDelegate = me
		  rightDataFilter.bindVariables()
		  rightDataFilter.Run
		  
		  leftTypesCounter = new JVbackGroundQuery(app.dataModel, "SELECT DISTINCT RegelingTypeID FROM Regelingen WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
		  leftTypesCounter.backgroundTaskDelegate = me
		  leftTypesCounter.bindVariables()
		  leftTypesCounter.Run
		  
		  rightTypesCounter = new JVbackGroundQuery(app.dataModel, "SELECT DISTINCT RegelingTypeID FROM Regelingen WHERE Installatie LIKE ? OR kostenplaats LIKE ?")
		  rightTypesCounter.backgroundTaskDelegate = me
		  rightTypesCounter.bindVariables()
		  rightTypesCounter.Run
		  
		  exportFolder =SpecialFolder.ApplicationData.child("UnifyPro")
		  if  not exportFolder.Exists then
		    exportFolder.CreateAsFolder
		  end if
		  
		  leftSelectedType = -1
		  rightSelectedType = -1
		  
		  leftSourceFile = new JVTextFile(exportFolder.Child("sourceLeft.txt"))
		  rightSourceFile = new JVTextFile(exportFolder.Child("sourceRight.txt"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub exportAndCompare()
		  
		  
		  if (leftSelectedCode <> "") and  (rightSelectedCode<> "")  then
		    
		    
		    leftSourceFile.Write(leftSelectedCode)
		    rightSourceFile.Write(rightSelectedCode)
		    
		    app.mainWindowController.compareViewController.compare(leftSourceFile, rightSourceFile)
		    
		  end if
		  
		  if (leftSelectedType <> -1) and (rightSelectedType <> -1) then
		    app.mainWindowController.compareViewController.showMetaData(leftSelectedType, rightSelectedType)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onTaskFinished(sender as JVBackgroundTask)
		  // Part of the JVBackgroundTaskDelegate interface.
		  
		  Select Case sender
		    
		  Case  leftDataFilter
		    
		    leftRecords = leftDataFilter.foundRecords
		    showList(selectView.ListViewLeft, leftRecords)
		    
		  Case rightDataFilter
		    
		    rightRecords = rightDataFilter.foundRecords
		    showList(selectView.ListViewRight, rightRecords)
		    
		  Case leftTypesCounter
		    
		    selectView.LabelCountLeft.Text = Str(leftTypesCounter.RecordCount) +" types op "+Str(leftDataFilter.recordCount)
		    
		  Case rightTypesCounter
		    
		    selectView.LabelCountRight.Text =  Str(rightTypesCounter.RecordCount) +" types op "+Str(rightDataFilter.recordCount)
		    
		  End Select
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
		Function selectType(list as JVTreeView, data as RecordSet) As String
		  // Start with no record selected in the dataset
		  data.MoveFirst
		  data.MovePrevious
		  
		  dim currentParentRow as Integer = 0
		  dim selectedParentRow as Integer = -1
		  
		  dim currentParentCode as String
		  dim selectedParentCode as String = ""
		  
		  for rowNumber as Integer =  0 to list.listcount-1
		    
		    data.MoveNext
		    
		    // Unchek all the parentfolders
		    if list.RowIsFolder(rownumber) then
		      
		      currentParentRow = rowNumber
		      currentParentCode = data.Field("cleanedUpcode").StringValue
		      list.CellState(currentParentRow, 0) = CheckBox.CheckedStates.UnChecked
		      
		      //  It's a closed parentrow, skip over the extra invisible rows
		      if (list.Expanded(currentParentRow) = FALSE) And (list.RowTag(rowNumber) <> nil ) then
		        dim closedRows(-1,-1) as String = list.RowTag(rowNumber)
		        for closedRow as Integer = 1 to ubound(closedRows)
		          data.MoveNext
		        next
		      end if
		      
		    end if
		    
		    if list.Selected(rowNumber) then
		      // Remember the selections parent and its code
		      selectedParentRow = currentParentRow
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
		Sub syncInterface(optional up as Boolean = TRUE)
		  if up then
		    
		  else
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		exportFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			_
		#tag EndNote
		leftDataFilter As JVbackGroundQuery
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim filterExpression as Variant = "%"+selectview.TextFieldFilterLeft.Text+"%"
			  Return filterExpression
			End Get
		#tag EndGetter
		leftFilterExpression As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		leftRecords As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		leftSelectedCode As String
	#tag EndProperty

	#tag Property, Flags = &h0
		leftSelectedType As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		leftSourceFile As JVTextFile
	#tag EndProperty

	#tag Property, Flags = &h0
		leftTypesCounter As JVbackGroundQuery
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			_
		#tag EndNote
		rightDataFilter As JVbackGroundQuery
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  dim filterExpression as Variant = "%"+selectview.TextFieldFilterRight.Text+"%"
			  Return filterExpression
			End Get
		#tag EndGetter
		rightFilterExpression As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		rightRecords As RecordSet
	#tag EndProperty

	#tag Property, Flags = &h0
		rightSelectedCode As String
	#tag EndProperty

	#tag Property, Flags = &h0
		rightSelectedType As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rightSourceFile As JVTextFile
	#tag EndProperty

	#tag Property, Flags = &h0
		rightTypesCounter As JVbackGroundQuery
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return SQLitePreparedStatement(representedObject)
			End Get
		#tag EndGetter
		selectData As SQLitePreparedStatement
	#tag EndComputedProperty

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
			Name="leftSelectedCode"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="leftSelectedType"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rightSelectedCode"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rightSelectedType"
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
