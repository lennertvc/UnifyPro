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
		  Super.Constructor(new SelectView, app.dataModel)
		  
		  leftDataFilter = new JVbackGroundQuery(selectData, "SELECT * FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ? OR procesDeel LIKE ?")
		  leftDataFilter.backgroundTaskDelegate = me
		  leftDataFilter.bindVariables()
		  
		  rightDataFilter = new JVbackGroundQuery(selectData, "SELECT * FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ? OR procesDeel LIKE ?")
		  rightDataFilter.backgroundTaskDelegate = me
		  rightDataFilter.bindVariables()
		  
		  leftTypesCounter = new JVbackGroundQuery(selectData, "SELECT DISTINCT RegelingTypeID FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ? OR procesDeel LIKE ?")
		  leftTypesCounter.backgroundTaskDelegate = me
		  leftTypesCounter.bindVariables()
		  
		  rightTypesCounter = new JVbackGroundQuery(selectData, "SELECT DISTINCT RegelingTypeID FROM 'DefaultListing' WHERE Installatie LIKE ? OR kostenplaats LIKE ? OR procesDeel LIKE ?")
		  rightTypesCounter.backgroundTaskDelegate = me
		  rightTypesCounter.bindVariables()
		  
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
		Sub loadLeftData()
		  
		  selectView.ProgressWheelLeft.Visible = TRUE
		  selectView.LabelCountLeft.text ="Loading data"
		  selectView.Refresh
		  app.DoEvents
		  
		  leftDataFilter.bindVariables(array(leftFilterExpression, leftFilterExpression, leftFilterExpression))
		  leftDataFilter.Run
		  
		  leftTypesCounter.bindVariables(array(leftFilterExpression, leftFilterExpression, leftFilterExpression))
		  leftTypesCounter.Run
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadRightData()
		  
		  selectView.ProgressWheelRight.Visible = TRUE
		  selectView.LabelCountRight.text ="Loading data"
		  selectView.Refresh
		  app.DoEvents
		  
		  rightDataFilter.bindVariables(array(rightFilterExpression, rightFilterExpression, rightFilterExpression))
		  rightDataFilter.Run
		  
		  rightTypesCounter.bindVariables(array(rightFilterExpression, rightFilterExpression, rightFilterExpression))
		  rightTypesCounter.Run
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onTaskFinished(sender as JVBackgroundTask)
		  // Part of the JVBackgroundTaskDelegate interface.
		  
		  Select Case sender
		    
		    
		  Case  leftDataFilter
		    
		    leftRecords = leftDataFilter.foundRecords
		    showList(selectView.ListViewLeft, leftRecords)
		    selectView.ProgressWheelLeft.Visible = FALSE
		    
		  Case rightDataFilter
		    
		    rightRecords = rightDataFilter.foundRecords
		    showList(selectView.ListViewRight, rightRecords)
		    selectView.ProgressWheelRight.Visible = FALSE
		    
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
		Sub onViewOpen(sender as NSView)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub onViewResizing(sender as NSView)
		  autoLayout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectType(list as JVTreeView, data as RecordSet) As Pair
		  // Start with no record selected in the dataset
		  data.MoveFirst
		  data.MovePrevious
		  
		  dim currentParentRow as Integer = 0
		  dim selectedParentRow as Integer = -1
		  
		  dim currentParentCode as String
		  dim selectedParentCode as String = ""
		  
		  dim currentParentType as Integer = 0
		  dim selectedParentType as Integer = -1
		  
		  for rowNumber as Integer =  0 to list.listcount-1
		    
		    data.MoveNext
		    
		    // Unchek all the parentfolders
		    if list.RowIsFolder(rownumber) then
		      
		      currentParentRow = rowNumber
		      currentParentType = data.Field("regelingTypeID").IntegerValue
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
		      selectedParentType = currentParentType
		      selectedParentCode = currentParentCode
		      // Report the selected row while developing
		      #if DebugBuild then
		        dim type as String = data.Field("regelingTypeID").StringValue
		        dim installatie as String =data.Field("installatie").StringValue
		        dim kostenplaats as String =data.Field("kostenplaats").StringValue
		        System.DebugLog("Type "+type+", "+installatie+" " +kostenplaats+" Selected")
		      #endif
		    end if
		  next
		  
		  // Reselect the parent type afterwords
		  if selectedParentRow >=0 then
		    list.CellState(selectedParentRow, 0) = CheckBox.CheckedStates.Checked
		  end if
		  
		  // and return the code
		  Dim typeWithCode As Pair = selectedParentType : selectedParentCode
		  
		  return typeWithCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub showList(list as JVTreeView, data as recordset)
		  
		  If (list <> Nil)  and (data <> Nil) and (data.RecordCount > 0)  and (not Data.EOF) Then
		    
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
			  dim filterExpression as Variant = "%"+mLeftFilterExpression+"%"
			  Return filterExpression
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  System.DebugLog(value.StringValue)
			  mLeftFilterExpression = value.StringValue
			End Set
		#tag EndSetter
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

	#tag Property, Flags = &h21
		Private mLeftFilterExpression As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightFilterExpression As String
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
			  dim filterExpression as Variant = "%"+mRightFilterExpression+"%"
			  Return filterExpression
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRightFilterExpression =  value.StringValue
			End Set
		#tag EndSetter
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
			  return SQLiteDatabase(representedObject)
			End Get
		#tag EndGetter
		selectData As SQLiteDatabase
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
