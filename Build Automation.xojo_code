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
					FolderItem = Li4vQXJ0d29yay8=
					FolderItem = Li4vVW5pZnklMjBQcm8lMjBSZWxlYXNlJTIwbm90ZXMudHh0
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
					FolderItem = Li4vQXJ0d29yay8=
					FolderItem = Li4vVW5pZnklMjBQcm8lMjBSZWxlYXNlJTIwbm90ZXMudHh0
				End
			End
#tag EndBuildAutomation
