#tag Window
Begin NSView SelectView
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   448
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   656
   Begin JVTreeview ListViewLeft
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   True
      ColumnWidths    =   "30%,20%,10%,40%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   2
      GridLinesVertical=   2
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   355
      HelpTag         =   ""
      Hierarchical    =   True
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Type>Regeling	Installatie	Kostenplaats	Filepath"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   47
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   282
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin JVTreeview ListViewRight
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   True
      ColumnWidths    =   "30%,20%,10%,40%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   2
      GridLinesVertical=   2
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   355
      HelpTag         =   ""
      Hierarchical    =   True
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Type>Regeling	Installatie	Kostenplaats	Filepath"
      Italic          =   False
      Left            =   336
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   47
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin TextField TextFieldFilterLeft
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFF00FFFF
      Bold            =   False
      Border          =   True
      CueText         =   "Filter"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   138
      Begin ProgressWheel ProgressWheelLeft
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TextFieldFilterLeft"
         Left            =   139
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   14
         Visible         =   False
         Width           =   16
      End
   End
   Begin TextField TextFieldFilterRight
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFF00FFFF
      Bold            =   False
      Border          =   True
      CueText         =   "Filter"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   336
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   138
      Begin ProgressWheel ProgressWheelRight
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TextFieldFilterRight"
         Left            =   455
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   14
         Visible         =   False
         Width           =   16
      End
   End
   Begin Label LabelCountLeft
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "..."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   414
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label LabelCountRight
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   336
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "..."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   414
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return selectViewController(owner)
			End Get
		#tag EndGetter
		selectViewController As SelectViewController
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events ListViewLeft
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  if  (row < me.ListCount) and (me.RowIsFolder(row)) then
		    
		    if (column = 0) then
		      me.CellType(row,0) = Listbox.TypeCheckbox
		    end if
		    
		    If (me.CellState(row, 0) = CheckBox.CheckedStates.Checked) Then
		      
		      g.ForeColor = &c00FF00
		      g.FillRect(0, 0, g.Width,g.Height)
		      
		    else
		      g.ForeColor = &cFFFFFF
		      g.FillRect(0, 0, g.Width,g.Height)
		    end If
		    
		    Me.InvalidateCell(row,-1) // Invalidate this entire row, so it gets repainted with the next change in selection (and the associated refresh)
		    
		    Return TRUE
		    
		  else
		    g.ForeColor = &cFFFFFF
		    g.FillRect(0, 0, g.Width,g.Height)
		    
		    
		    Return  FALSE
		    
		  end if
		  
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  selectViewController.leftSourceFile.delete
		  
		  // Get and display selection
		  selectViewController.leftSelectedtype = SelectViewController.SelectType(me,selectViewController.leftRecords)
		  App.mainWindowController.CompareViewController.showLeftMetaData(selectViewController.leftSelectedType.ID)
		  
		  // Export selection
		  selectViewController.leftSourceFile.Write(selectViewController.leftSelectedType.cleanedUpCode)
		  selectViewController.leftReportLabel = STR(selectViewController.leftSelectedType.ID)
		  
		  // Compare if possible
		  app.mainWindowController.compareViewController.reportFile.delete
		  App.mainWindowController.compareViewController.compare(_
		  selectViewController.leftSourceFile, selectViewController.leftReportLabel, _
		  selectViewController.rightSourceFile, selectViewController.rightReportLabel _
		  )
		  
		  
		  // Set "STANDAARD" types to bold
		  if selectviewcontroller.leftrecords.eof then
		    selectViewController.leftRecords.MoveFirst
		  end if
		  app.mainWindowController.selectViewController.boldTextDafult(me,selectviewcontroller.leftRecords)
		  
		  // Repaint  the cells backgrounds after a selection has changed
		  refresh( TRUE) 
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  if  (row < me.ListCount) and (me.RowIsFolder(row))  and column = 0 then
		    me.Selected(row) = (me.CellState(row, 0) = CheckBox.CheckedStates.Checked)
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListViewRight
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  if  (row < me.ListCount) and (me.RowIsFolder(row)) then
		    
		    if (column = 0) then
		      me.CellType(row,0) = Listbox.TypeCheckbox
		    end if
		    
		    If (me.CellState(row, 0) = CheckBox.CheckedStates.Checked) Then
		      
		      g.ForeColor = &cFF0000
		      g.FillRect(0, 0, g.Width,g.Height)
		      
		    else
		      g.ForeColor = &cFFFFFF
		      g.FillRect(0, 0, g.Width,g.Height)
		    end If
		    
		    Me.InvalidateCell(row,-1) // Invalidate this entire row, so it gets repainted with the next change in selection (and the associated refresh)
		    
		    return TRUE
		    
		  else
		    g.ForeColor = &cFFFFFF
		    g.FillRect(0, 0, g.Width,g.Height)
		    
		    Return  FALSE
		    
		  end if
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  selectViewController.rightSourceFile.delete
		  
		  // Get and display selection
		  selectViewController.rightSelectedtype = SelectViewController.SelectType(me,selectViewController.rightRecords)
		  App.mainWindowController.CompareViewController.showrightMetaData(selectViewController.rightSelectedType.ID)
		  
		  // Export selection
		  selectViewController.rightSourceFile.Write(selectViewController.rightSelectedType.cleanedUpCode)
		  selectViewController.rightReportLabel = STR(selectViewController.rightSelectedType.ID)
		  
		  // Compare if possible
		  app.mainWindowController.compareViewController.reportFile.delete
		  App.mainWindowController.compareViewController.compare(_
		  selectViewController.leftSourceFile, selectViewController.leftReportLabel, _
		  selectViewController.rightSourceFile, selectViewController.rightReportLabel _
		  )
		  
		  
		  
		  // Set "STANDAARD" types to bold
		  if selectviewcontroller.rightrecords.eof then
		    selectViewController.rightRecords.MoveFirst
		  end if
		  app.mainWindowController.selectViewController.boldTextDafult(me,selectviewcontroller.rightRecords)
		  
		  // Repaint  the cells backgrounds after a selection has changed
		  refresh( TRUE) 
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  if  (row < me.ListCount) and (me.RowIsFolder(row))  and column = 0 then
		    me.Selected(row) = (me.CellState(row, 0) = CheckBox.CheckedStates.Checked)
		  end if
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldFilterLeft
	#tag Event
		Sub LostFocus()
		  if (me.text) <> (selectViewController.leftFilterExpression.StringValue.replaceAll("%", "")) then
		    
		    selectViewController.leftFilterExpression = me.text
		    selectViewController.loadLeftData
		    
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  if Key = CHR(13) or Key = CHR(10) then
		    
		    if (me.text) <> (selectViewController.leftFilterExpression.StringValue.replaceAll("%", "")) then
		      
		      selectViewController.leftFilterExpression = me.text
		      selectViewController.loadLeftData
		      
		    end if
		    
		    return TRUE
		  end if
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.BackColor = &cFFFFFF
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldFilterRight
	#tag Event
		Sub LostFocus()
		  if (me.text) <> (selectViewController.rightFilterExpression.StringValue.replaceAll("%", "")) then
		    
		    selectViewController.rightFilterExpression = me.Text
		    selectViewController.loadrightData
		    
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  if Key = CHR(13) or Key = CHR(10) then
		    
		    if (me.text) <> (selectViewController.rightFilterExpression.StringValue.replaceAll("%", "")) then
		      
		      selectViewController.rightFilterExpression = me.Text
		      selectViewController.loadrightData
		      
		    end if
		    
		    return TRUE
		  end if
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.BackColor = &cFFFFFF
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="isInstalled"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
