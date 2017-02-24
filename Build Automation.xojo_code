#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFilesMac
					AppliesTo = 2
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vUmVnZWxpbmdlbkRhdGFCYXNlLmRi
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyFilesWindows
					AppliesTo = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vUmVnZWxpbmdlbkRhdGFCYXNlLmRi
				End
			End
#tag EndBuildAutomation
