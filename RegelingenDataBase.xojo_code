#tag Class
Protected Class RegelingenDataBase
Inherits JVSQLiteDatabase
	#tag Method, Flags = &h0
		Function addCodeToDB(originalcode as string,cleanedupcode as String,procesPart as string) As Boolean
		  Dim record As New DatabaseRecord
		  
		  // ID will be added automatically
		  record.Column("OriginalCode") = originalcode
		  record.Column("CleanedUpCode") = cleanedupcode
		  record.Column("procesDeel") = procesPart
		  
		  InsertRecord("RegelingTypes", record)
		  
		  If Error Then
		    MsgBox("DB Error: " + ErrorMessage)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function addFilePath(filePath as string,installation as string,KP as string,name as string,foreignkey as integer,FM as string) As Boolean
		  Dim record As New DatabaseRecord
		  // ID will be added automatically
		  record.Column("FilePath") = filepath
		  record.Column("Installatie") = installation
		  record.Column("kostenPlaats") = KP
		  record.Column("naam") = name
		  record.Column("FM") = FM
		  
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
		Function addMetaData(Key as string,value as string,foreignkey as integer) As Boolean
		  Dim record As New DatabaseRecord
		  
		  // ID will be added automatically
		  record.Column("Key") =Key
		  record.Column("Value") = Value
		  
		  // Foreign keys
		  record.IntegerColumn("RegelingTypeID") = foreignkey
		  
		  InsertRecord("Metadata", record)
		  
		  If Error Then
		    MsgBox("DB Error: " + ErrorMessage)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function lookupChanges(lookupvalue1 as string,lookupValue2 as string, lookupValue3 as string) As integer
		  dim number as integer =0
		  'dim previousRecords as Recordset = SQLSelect("Select regelingTypeID From "+lookupTable+" WHERE "+lookupField+" = '"+lookupValue+"'")
		  dim previousRecords as Recordset = SQLSelect("Select regelingTypeID From regelingen where Installatie= "+"'"+lookupValue1+"'"+" AND filePath = " +"'"+lookupValue2+"'"+" AND naam = " +"'"+lookupValue3+"'")
		  
		  if previousRecords <> nil then
		    if previousrecords.fieldcount>=1 then
		      system.DebugLog("ident")
		      previousRecords.MoveFirst 
		      number=previousRecords.Field("regelingTypeID").IntegerValue
		      return number
		    end if
		  end if
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
			  dim fileName as String = "RegelingenDataBase.db"
			  
			  dim pathFinder as new JVPathFinder
			  dim dataBaseFile as folderItem = pathFinder.findFile(fileName)
			  system.debuglog("Database is located at "+dataBaseFile.NativePath+" for this platform")
			  
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
