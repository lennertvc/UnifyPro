#tag Class
Protected Class JVSQLiteDatabase
Inherits SQLiteDatabase
	#tag Method, Flags = &h0
		Sub InsertOrUpdateRecords(tableName as String, matchFields as Dictionary, newFields as Dictionary)
		  
		  dim recordsToUpdate as RecordSet = selectRecords(tableName, matchFields)
		  
		  if recordsToUpdate <> nil  then 
		    updateRecords(tableName, recordsToUpdate, newFields)
		  else
		    insertRecords(tableName, newFields)
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertRecords(tableName as String, newFields as Dictionary)
		  newfields = stripPKsFromRecord(tableName, newFields)
		  
		  dim newFieldNames() as String
		  dim placeHolders() as String
		  for each fieldName as String in newFields.keys
		    newFieldNames.append(fieldName)
		    placeHolders.append("?")
		  next
		  dim newFieldNamesString as String= join(newFieldNames, ", ")
		  dim placeHolderString as String= join(placeHolders, ", ")
		  
		  dim sqlString as String = "INSERT INTO "+tableName+" ("+newFieldNamesString+") VALUES ("+placeHolderString+")" 
		  dim sqlStatement as SQLitePreparedStatement = Prepare(sqlString)
		  
		  sqlStatement.bindType(newFields.Values)
		  sqlStatement.bind(newFields.Values)
		  
		  sqlStatement.SQLExecute
		  
		  If Error Then
		    #if debugbuild then
		      system.debuglog( _
		      "[JVSQLiteDatabase] DB Error: " + ErrorMessage+ENDOFLINE+ _
		      sqlString)
		    #endif
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function lookupID(lookupTable as String, lookupFields as Dictionary) As Integer
		  
		  dim pkField As String
		  
		  dim tableInfo as RecordSet = FieldSchema(lookupTable)
		  while not tableInfo.eof
		    if tableInfo.Field("IsPrimary").BooleanValue = TRUE then
		      pkField = tableInfo.Field("ColumnName")
		    end if
		    tableInfo.MoveNext
		  wend
		  
		  
		  Dim matchFieldNames() as String
		  for each fieldName as String in lookupFields.Keys
		    matchFieldNames.append(fieldName+" = ?")
		  next
		  dim matchFieldsString as String= join(matchFieldNames, ", ")
		  
		  dim sqlString as String = "SELECT "+pkField+" FROM "+lookupTable+" WHERE "+matchFieldsString
		  dim sqlStatement as SQLitePreparedStatement = Prepare(sqlString)
		  
		  sqlStatement.bindType(lookupFields.Values)
		  sqlStatement.bind(lookupFields.Values)
		  
		  dim foundRecords as RecordSet = sqlStatement.SQLSelect
		  
		  If Error Then
		    #if debugbuild then
		      system.debuglog( _
		      "[JVSQLiteDatabase] DB Error: " + ErrorMessage+ENDOFLINE+ _
		      sqlString)
		    #endif
		    return -1
		  End If
		  
		  if foundRecords <> nil then
		    foundRecords.moveFirst
		    return foundRecords.field(pkField).IntegerValue
		  else
		    return -1
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectRecords(tableName as String, matchFields as Dictionary) As Recordset
		  Dim matchFieldNames() as String
		  
		  for each fieldName as String in matchFields.Keys
		    matchFieldNames.append(fieldName+" = ?")
		  next
		  dim matchFieldsString as String= join(matchFieldNames, ", ")
		  
		  dim sqlString as String = "SELECT FROM "+tableName+" WHERE "+matchFieldsString
		  dim sqlStatement as SQLitePreparedStatement = Prepare(sqlString)
		  
		  sqlStatement.bindType(matchFields.Values)
		  sqlStatement.bind(matchFields.Values)
		  
		  dim foundRecords as RecordSet = sqlStatement.SQLSelect
		  
		  If Error Then
		    #if debugbuild then
		      system.debuglog( _
		      "[JVSQLiteDatabase] DB Error: " + ErrorMessage+ENDOFLINE+ _
		      sqlString)
		    #endif
		    Return nil
		  End If
		  
		  return foundRecords
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function stripPKsFromRecord(tableName as String, record as Dictionary) As Dictionary
		  // Make sure to exclude any Primary Keys from the new values
		  dim fieldsInTable as RecordSet = FieldSchema(tableName)
		  If fieldsInTable <> Nil Then
		    While Not fieldsInTable.EOF
		      dim isPrimaryField as Boolean = fieldsInTable.Field("IsPrimary")
		      dim fieldName as String =  fieldsInTable.Field("ColumnName")
		      if isPrimaryField and record.Keys.IndexOf(fieldname) >=0 then
		        record.Remove(fieldname)
		      end If
		      fieldsInTable.MoveNext
		    Wend
		    fieldsInTable.Close
		  End If 
		  
		  return record
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateRecords(tableName as String, records as RecordSet, newFields as Dictionary)
		  newFields = stripPKsFromRecord(tableName, newFields)
		  
		  If records <> Nil Then
		    records.MoveFirst
		    records.Edit
		    
		    While Not records.EOF
		      
		      for each fieldName as String in newFields.keys
		        dim fieldValue as Variant = newFields.value(fieldName)
		        records.field(fieldName).value = fieldValue
		      next
		      
		      records.Update
		      records.MoveNext
		    Wend
		    
		    records.Close
		  End If
		End Sub
	#tag EndMethod


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
