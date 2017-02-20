#tag Class
Protected Class RegelingenDataBase
Inherits SQLiteDatabase
	#tag Method, Flags = &h0
		Function addCodeToDB(originalcode as string,cleanedupcode as String) As Boolean
		  Dim record As New DatabaseRecord
		  // ID will be added automatically
		  record.Column("OriginalCode") = originalcode
		  record.Column("CleanedUpCode") = cleanedupcode
		  
		  InsertRecord("RegelingTypes", record)
		  
		  If Error Then
		    MsgBox("DB Error: " + ErrorMessage)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function addFilePath(filePath as string = "",foreignkey as integer) As Boolean
		  Dim record As New DatabaseRecord
		  // ID will be added automatically
		  record.Column("FilePath") = filepath
		  
		  // Foreign keys
		  record.IntegerColumn("RegelingTypeID") = foreignkey
		  
		  InsertRecord("Regelingen", record)
		  
		  If Error Then
		    MsgBox("DB Error: " + ErrorMessage)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function lookupRecord(lookupTable as String,lookupField as String, lookupValue as string) As integer
		  dim number as integer =0
		  'dim previousRecords as Recordset = SQLSelect("Select regelingTypeID From "+lookupTable+" WHERE "+lookupField+" = '"+lookupValue+"'")
		  dim previousRecords as Recordset = SQLSelect("Select regelingTypeID From regelingTypes where cleanedUpCode= "+"'"+lookupValue+"'")
		  if previousrecords.fieldcount>=1 then
		    system.DebugLog("ident")
		    previousRecords.MoveFirst 
		    number=previousRecords.Field("regelingTypeID").IntegerValue
		    return number
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function newPKFromTable(TableName as String) As Integer
		  dim newPK as RecordSet= SQLSelect("select seq from sqlite_sequence where name='"+TableName +"';")
		  return newPK.Field("seq").IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open() As RegelingenDataBase
		  
		  If  (defaultFile <> nil) and (defaultFile.exists) Then
		    
		    // Open
		    Dim database As New RegelingenDataBase
		    database.databaseFile = defaultFile
		    
		    if database.connect Then
		      return database
		    else
		      msgbox("[RegelingenDataBase] Error connecting to database 'Regelingendatabse' "+database.ErrorMessage)
		      return nil
		    end if
		    
		  else
		    
		    msgbox("[RegelingenDataBase] 'RegelingenDatabase' was not found")
		    
		  end if
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  dim pathFinder as new JVPathFinder
			  dim dataBaseFile as folderItem = pathFinder.findFile("RegelingenDataBase.db")
			  
			  Return  dataBaseFile
			  
			End Get
		#tag EndGetter
		Shared defaultFile As FolderItem
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="DatabaseFile"
			Visible=true
			Type="FolderItem"
			EditorType="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugMode"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EncryptionKey"
			Visible=true
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LoadExtensions"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MultiUser"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortColumnNames"
			Visible=true
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadYieldInterval"
			Visible=true
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Timeout"
			Visible=true
			Type="Double"
			EditorType="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
