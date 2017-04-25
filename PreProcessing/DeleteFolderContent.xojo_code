#tag Class
Protected Class DeleteFolderContent
	#tag Method, Flags = &h0
		Function DeleteEntireFolder(theFolder as FolderItem, continueIfErrors as Boolean = false) As Integer
		  // Returns an error code if it fails, or zero if the folder was deleted successfully
		  
		  Dim returnCode, lastErr, itemCount As Integer
		  Dim files(), dirs() As FolderItem
		  
		  If theFolder = Nil Or Not theFolder.Exists Then
		    Return 0
		  End If
		  
		  // Collect the folder‘s contents first.
		  // This is faster than collecting them in reverse order and deleting them right away!
		  itemCount = theFolder.Count
		  For i As Integer = 1 To itemCount
		    Dim f As FolderItem
		    f = theFolder.TrueItem( i )
		    If f <> Nil Then
		      If f.Directory Then
		        dirs.Append f
		      Else
		        files.Append f
		      End If
		    End If
		  Next
		  
		  // Now delete the files
		  For Each f As FolderItem In files
		    f.Delete
		    lastErr = f.LastErrorCode   // Check if an error occurred
		    If lastErr <> 0 Then
		      If continueIfErrors Then
		        If returnCode = 0 Then returnCode = lastErr
		      Else
		        // Return the error code if any. This will cancel the deletion.
		        Return lastErr
		      End If
		    End If
		  Next
		  
		  Redim files(-1) // free the memory used by the files array before we enter recursion
		  
		  // Now delete the directories
		  For Each f As FolderItem In dirs
		    lastErr = DeleteEntireFolder( f, continueIfErrors )
		    If lastErr <> 0 Then
		      If continueIfErrors Then
		        If returnCode = 0 Then returnCode = lastErr
		      Else
		        // Return the error code if any. This will cancel the deletion.
		        Return lastErr
		      End If
		    End If
		  Next
		  
		  If returnCode = 0 Then
		    // We‘re done without error, so the folder should be empty and we can delete it.
		    'theFolder.Delete
		    returnCode = theFolder.LastErrorCode
		  End If
		  
		  Return returnCode
		End Function
	#tag EndMethod


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
