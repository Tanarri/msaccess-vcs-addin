﻿Attribute VB_Name = "modResource"
'---------------------------------------------------------------------------------------
' Module    : modResource
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Manage the resource files (such as ribbon XML and COM add-in files) used
'           : when installing/updating the add-in.
'---------------------------------------------------------------------------------------

Option Compare Database
Option Private Module
Option Explicit


'---------------------------------------------------------------------------------------
' Procedure : LoadResources
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Verify resource files in tblResources. (Run after building from source
'           : or launching installer on a development computer.)
'---------------------------------------------------------------------------------------
'
Public Sub VerifyResources()
    
    ' Ribbon XML and COM add-in for the ribbon
    VerifyResource "Ribbon XML", "\Ribbon\Ribbon.xml"
    VerifyResource "COM Addin x32", "\Ribbon\Build\MSAccessVCS_win32.dll"
    VerifyResource "COM Addin x64", "\Ribbon\Build\MSAccessVCS_win64.dll"
        
End Sub


'---------------------------------------------------------------------------------------
' Procedure : VerifyResource
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Verify a resource in the embedded resources table. (Compare hash to file)
'---------------------------------------------------------------------------------------
'
Private Sub VerifyResource(strKey As String, strFile As String)

    Dim strPath As String
    Dim dbs As DAO.Database
    Dim rst As DAO.Recordset2
    
    ' Build full path to file using system path separator
    strPath = Replace(CodeProject.Path & strFile, "\", PathSep)
    
    ' First check to make sure the file exists
    If FSO.FileExists(strPath) Then
    
        ' Look for specified record in resources table
        Set dbs = CodeDb
        Set rst = dbs.OpenRecordset( _
            "select * from tblResources where ResourceName='" & strKey & "'", dbOpenDynaset)
        If rst.EOF Then
            ' Record does not exist. Add it (silently)
            rst.AddNew
                rst!ResourceName = strKey
                LoadResource rst, strPath
            rst.Update
        Else
            ' Compare the resource hash with the file hash to see if they match.
            If GetFileHash(strPath) <> GetResourceHash(rst) Then
                rst.Edit
                    LoadResource rst, strPath
                    MsgBox2 "Updated Resource", strKey & " has been updated from source.", , vbInformation
                rst.Update
            End If
        End If
    Else
        ' Source file does not exist. No need to go any further. (Might be running
        ' on a client computer during the installation process.)
    End If
    
End Sub


'---------------------------------------------------------------------------------------
' Procedure : AddResource
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Add a resource to the table
'---------------------------------------------------------------------------------------
'
Private Sub LoadResource(rst As DAO.Recordset2, strFile As String)
    Dim rstFiles As Recordset2
    Set rstFiles = rst.Fields("Content").Value
    With rstFiles
        If .EOF Then
            .AddNew
        Else
            .Edit
        End If
        .Fields("FileData").LoadFromFile strFile
        .Update
    End With
End Sub


'---------------------------------------------------------------------------------------
' Procedure : GetResourceHash
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Return a hash of the resource item. (After the header portion)
'---------------------------------------------------------------------------------------
'
Private Function GetResourceHash(rst As DAO.Recordset2)
    
    Dim rstFiles As Recordset2
    Dim bteContent() As Byte
    
    Set rstFiles = rst.Fields("Content").Value
    With rstFiles
        If Not .EOF Then
            With .Fields("FileData")
                bteContent = .Value
                GetResourceHash = GetBytesHash(StripOLEHeader(bteContent))
            End With
        End If
    End With
    
End Function


'---------------------------------------------------------------------------------------
' Procedure : ExtractResource
' Author    : Adam Waller
' Date      : 2/28/2022
' Purpose   : Extract a resource to a specified folder
'---------------------------------------------------------------------------------------
'
Public Sub ExtractResource(strKey As String, strFolder As String)

    Dim dbs As DAO.Database
    Dim rst As DAO.Recordset2
    Dim rstFiles As DAO.Recordset2
    Dim blnSuccess As Boolean
    Dim strPath As String
    Dim strName As String
    
    Set dbs = CodeDb
    Set rst = dbs.OpenRecordset( _
        "select * from tblResources where ResourceName='" & strKey & "'", dbOpenDynaset)
    
    ' Check for requested key
    If Not rst.EOF Then
    
        ' Get embedded recordset of files
        Set rstFiles = rst.Fields("Content").Value
        With rstFiles
            If Not .EOF Then
                strPath = strFolder & PathSep & .Fields("FileName")
                If FSO.FileExists(strPath) Then DeleteFile strPath
                .Fields("FileData").SaveToFile strPath
            End If
        End With
    End If
    
End Sub


'---------------------------------------------------------------------------------------
' Procedure : StripOLEHeader
' Author    : Adam Waller
' Date      : 5/12/2020
' Purpose   : Strip out the OLE header so we can return the raw binary data the way
'           : it would be saved as a file. (First 20 bytes (10 chars) of the data)
'---------------------------------------------------------------------------------------
'
Private Function StripOLEHeader(bteData() As Byte) As Byte()

    Dim strData As String
    
    ' Convert to string
    strData = bteData
    
    ' Strip off header, and convert back to byte array
    StripOLEHeader = Mid$(strData, 11)
    
End Function