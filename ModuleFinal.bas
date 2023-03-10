Attribute VB_Name = "Module1"
Sub vbaproject()
Dim wsheets, sht As Integer
Dim openPrice, closePrice, priceChTrick, priceChangePer, totalVolume, rangeToUse, rangToUse As Variant
Dim counter As Integer
Dim myMaxTotalRow, myMinRow, myMaxRow As String
wsheets = ActiveWorkbook.Worksheets.Count
Application.ScreenUpdating = False
For sht = 1 To wsheets
    openPrice = 0
    closePrice = 0
    priceChange = 0
    priceChangePer = 0
    totalVolume = 0
    myMaxTotalRow = 0
    myMinRow = 0
    myMaxRow = 0
    biggestTotalTicker = 0
    biggestTotal = 0
    shtLastRow = 0
    shtLastRow = ActiveWorkbook.Sheets(sht).Cells(Rows.Count, 1).End(xlUp).Row
    Worksheets(sht).Activate
    ActiveSheet.Range("I1").Value = "Ticker"
    ActiveSheet.Range("J1").Value = "Yearly Change"
    ActiveSheet.Range("K1").Value = "Percent Change"
    ActiveSheet.Range("L1").Value = "Total Stock Volume"
    ActiveSheet.Range("P1").Value = "Ticker"
    ActiveSheet.Range("Q1").Value = "Value"
    ActiveSheet.Range("O2").Value = "Greatest % Increase"
    ActiveSheet.Range("O3").Value = "Greatest % Decrease"
    ActiveSheet.Range("O4").Value = "Greatest Total Volume"
    counter = 0
    For ind = 2 To shtLastRow
        counter = counter + 1
        If ActiveSheet.Cells(ind + 1, 1).Value <> ActiveSheet.Cells(ind, 1).Value Then
            openPrice = ActiveSheet.Cells(ind - (counter - 1), 3).Value
            rangeToUse = (ind - (counter - 1))
            rangToUse = "G" & rangeToUse & ":G" & ind
            totalVolume = Application.WorksheetFunction.Sum(Range(rangToUse))
            Ticker = ActiveSheet.Cells(ind - 1, 1).Value
            closePrice = ActiveSheet.Cells(ind, 6).Value
            priceChange = (closePrice - openPrice)
            priceChangePer = Application.WorksheetFunction.RoundDown(((priceChange * 100) / openPrice), 2) & "%"
            With ActiveSheet
                lastr = .Cells(.Rows.Count, "I").End(xlUp).Row
            End With
            ActiveSheet.Range("I" & lastr + 1).Value = Ticker
            ActiveSheet.Range("J" & lastr + 1).Value = priceChange
            ActiveSheet.Range("K" & lastr + 1).Value = priceChangePer
            ActiveSheet.Range("K" & lastr + 1).NumberFormat = "0.00%"
            ActiveSheet.Range("L" & lastr + 1).Value = totalVolume
            counter = 0
        End If
    Next ind
    biggestIncrease = Application.WorksheetFunction.Max(Range("K:K"))
    biggestDecrease = Application.WorksheetFunction.Min(Range("K:K"))
    biggestTotal = Application.WorksheetFunction.Max(Range("L:L"))
    'biggestTotal = Application.WorksheetFunction.Large(Sheets(sht).Range("L:L"), 1)
    myMaxRow = Application.Match(Application.Max(Sheets(sht).Range("J:J").SpecialCells(xlCellTypeVisible)), Sheets(sht).Range("J:J"), 0)
    myMinRow = Application.Match(Application.Min(Sheets(sht).Range("J:J").SpecialCells(xlCellTypeVisible)), Sheets(sht).Range("J:J"), 0)
    myMaxTotalRow = Application.Match(Application.Max(Sheets(sht).Range("L:L").SpecialCells(xlCellTypeVisible)), Sheets(sht).Range("L:L"), 0)
    maxTicker = ActiveSheet.Range("I" & myMaxRow).Value
    minTicker = ActiveSheet.Range("I" & myMinRow).Value
    biggestTotalTicker = ActiveSheet.Range("I" & myMaxTotalRow).Value
    ActiveSheet.Range("P2").Value = maxTicker
    ActiveSheet.Range("P3").Value = minTicker
    ActiveSheet.Range("P4").Value = biggestTotalTicker
    ActiveSheet.Range("Q2").Value = biggestIncrease
    ActiveSheet.Range("Q3").Value = biggestDecrease
    ActiveSheet.Range("Q2").NumberFormat = "0.00%"
    ActiveSheet.Range("Q3").NumberFormat = "0.00%"
    ActiveSheet.Range("Q4").Value = biggestTotal
    ActiveSheet.Range("I:Q").Columns.AutoFit
    With ActiveSheet
        lastro = .Cells(.Rows.Count, "J").End(xlUp).Row
    End With
    For Each cell In ActiveSheet.Range("J2:K" & lastro)
        If cell.Value >= 0 Then
            cell.Interior.ColorIndex = 4
        Else
           cell.Interior.ColorIndex = 3
        End If
    Next cell
Next sht
Worksheets(1).Activate
End Sub
Sub clear()
wsheets = ActiveWorkbook.Worksheets.Count
For sht = 1 To wsheets
    Worksheets(sht).Activate
    shtLastRow = ActiveWorkbook.Sheets(sht).Cells(Rows.Count, 1).End(xlUp).Row
    ActiveSheet.Range("I1:L" & shtLastRow).ClearContents
    ActiveSheet.Range("O1:r4, r1").ClearContents
    ActiveSheet.Range("J:J").Interior.ColorIndex = 0
    ActiveSheet.Range("k:k").Interior.ColorIndex = 0
Next sht
Worksheets(1).Activate
End Sub
Sub clearCFormatColumnj()
Dim cbValue As Long
cbValue = ActiveSheet.Shapes("Check box 6").ControlFormat.Value
wsheets = ActiveWorkbook.Worksheets.Count
Application.ScreenUpdating = False
If cbValue = 1 Then
    For sht = 1 To wsheets
        Worksheets(sht).Activate
        shtLastRow = ActiveWorkbook.Sheets(sht).Cells(Rows.Count, 1).End(xlUp).Row
        ActiveSheet.Range("J:J").Interior.ColorIndex = 0
    Next sht
ElseIf cbValue <> 1 Then
    For sht = 1 To wsheets
        Worksheets(sht).Activate
        With ActiveSheet
            lastro = .Cells(.Rows.Count, "J").End(xlUp).Row
        End With
        For Each cell In ActiveSheet.Range("J2:J" & lastro)
            If cell.Value >= 0 Then
                cell.Interior.ColorIndex = 4
            Else
               cell.Interior.ColorIndex = 3
            End If
        Next cell
    Next sht
End If
Worksheets(1).Activate

End Sub
Sub clearCFormatColumnk()
Dim cbValue As Long
cbValue = ActiveSheet.Shapes("Check box 9").ControlFormat.Value
wsheets = ActiveWorkbook.Worksheets.Count
Application.ScreenUpdating = False
If cbValue = 1 Then
    For sht = 1 To wsheets
        Worksheets(sht).Activate
        shtLastRow = ActiveWorkbook.Sheets(sht).Cells(Rows.Count, 1).End(xlUp).Row
        ActiveSheet.Range("K:K").Interior.ColorIndex = 0
    Next sht
ElseIf cbValue <> 1 Then
    For sht = 1 To wsheets
        Worksheets(sht).Activate
        With ActiveSheet
            lastro = .Cells(.Rows.Count, "k").End(xlUp).Row
        End With
        For Each cell In ActiveSheet.Range("K2:K" & lastro)
            If cell.Value >= 0 Then
                cell.Interior.ColorIndex = 4
            Else
               cell.Interior.ColorIndex = 3
            End If
        Next cell
    Next sht
End If
Worksheets(1).Activate
End Sub
