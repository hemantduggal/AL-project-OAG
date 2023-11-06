page 50011 "Budget Matrix Standard1"
{
    Caption = 'Budget Matrix Standard';
    DataCaptionExpression = BudgetName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Dimension Code Buffer";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the code of the record.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookUpCode(LineDimType, LineDimCode, Rec.Code);
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the name of the record.';
                }
                field(TotalBudgetedAmount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    Caption = 'Budgeted Amount';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the G/L account''s total budget.';

                    trigger OnDrillDown()
                    begin
                        SetCommonFilters(GLAccBudgetBuf);
                        SetDimFilters(GLAccBudgetBuf, 0);
                        BudgetDrillDown;
                    end;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Field2; MATRIX_EncumCellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount1(2);
                    end;
                }
                field(Field3; MATRIX_BalanceCellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }
                field(Field4; MATRIX_FundsCellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Field5; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Field6; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Field7; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Field8; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Field9; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Field10; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Field11; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Field12; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
                //>>>>>>>
                field(Field13; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(13);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(13);
                    end;
                }
                field(Field14; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(14);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(14);
                    end;
                }
                field(Field15; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(15);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(15);
                    end;
                }
                field(Field16; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(16);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(16);
                    end;
                }
                field(Field17; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(17);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(17);
                    end;
                }
                field(Field18; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(18);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(18);
                    end;
                }
                field(Field19; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(19);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(19);
                    end;
                }
                field(Field20; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(20);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(20);
                    end;
                }
                field(Field21; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(21);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(21);
                    end;
                }
                field(Field22; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(22);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(22);
                    end;
                }
                field(Field23; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(23);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(23);
                    end;
                }
                field(Field24; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(24);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(24);
                    end;
                }
                field(Field25; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(25);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(25);
                    end;
                }
                field(Field26; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(26);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(26);
                    end;
                }
                field(Field27; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(27);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(27);
                    end;
                }
                field(Field28; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(28);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(28);
                    end;
                }
                field(Field29; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(29);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(29);
                    end;
                }
                field(Field30; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(30);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(30);
                    end;
                }
                field(Field31; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(31);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(31);
                    end;
                }
                field(Field32; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(32);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(32);
                    end;
                }
                field(Field33; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(33);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(33);
                    end;
                }
                field(Field34; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(34);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(34);
                    end;
                }
                field(Field35; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(35);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(35);
                    end;
                }
                field(Field36; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(36);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(36);
                    end;
                }
                field(Field37; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(37);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(37);
                    end;
                }
                field(Field38; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(38);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(38);
                    end;
                }
                field(Field39; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(39);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(39);
                    end;
                }
                field(Field40; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(40);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(40);
                    end;
                }
                field(Field41; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(41);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(41);
                    end;
                }
                field(Field42; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(42);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(42);
                    end;
                }
                field(Field43; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(43);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(43);
                    end;
                }
                field(Field44; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(44);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(44);
                    end;
                }
                field(Field45; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12] + 'Budget Amount';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(45);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(45);
                    end;
                }
                field(Field46; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12] + 'Encumbered';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(46);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(46);
                    end;
                }
                field(Field47; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12] + 'Balance';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(47);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(47);
                    end;
                }
                field(Field48; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 11;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12] + 'Funds Available';
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(48);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(48);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action(GLAccBalanceBudget)
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Account Balance/Bud&get';
                    Image = Period;
                    ToolTip = 'Open a summary of the debit and credit balances for the current budget.';

                    trigger OnAction()
                    begin
                        GLAccountBalanceBudget;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        NameIndent := 0;
        for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        Rec.Amount := MatrixMgt.RoundAmount(CalcAmount(false), RoundingFactor);
        FormatLine;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(FindRec(LineDimType, Rec, Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(NextRec(LineDimType, Rec, Steps));
    end;

    trigger OnOpenPage()
    begin
        if GLAccBudgetBuf.GetFilter("Global Dimension 1 Filter") <> '' then
            GlobalDim1Filter := GLAccBudgetBuf.GetFilter("Global Dimension 1 Filter");
        if GLAccBudgetBuf.GetFilter("Global Dimension 2 Filter") <> '' then
            GlobalDim2Filter := GLAccBudgetBuf.GetFilter("Global Dimension 2 Filter");

        GLSetup.Get();
    end;

    var
        Text001: Label 'Period';
        Text002: Label 'You may only edit column 1 to %1.';
        GLSetup: Record "General Ledger Setup";
        GLAccBudgetBuf: Record "G/L Acc. Budget Buffer";
        GLBudgetName: Record "G/L Budget Name";
        MatrixRecords: array[12] of Record "Dimension Code Buffer";
        MATRIX_MatrixRecord: Record "Dimension Code Buffer";
        MatrixMgt: Codeunit "Matrix Management";
        BudgetName: Code[10];
        LineDimType: Enum "G/L Budget Matrix Dimensions";
        ColumnDimType: Enum "G/L Budget Matrix Dimensions";
        LineDimCode: Text[30];
        PeriodType: Enum "Analysis Period Type";
        RoundingFactor: Enum "Analysis Rounding Factor";
        DateFilter: Text[30];
        InternalDateFilter: Text[30];
        BusUnitFilter: Code[250];
        GLAccFilter: Code[250];
        IncomeBalanceGLAccFilter: Enum "G/L Account Income/Balance";
        GLAccCategoryFilter: Enum "G/L Account Category";
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Code[250];
        //neha
        BudgetDim5Filter: Code[250];
        BudgetDim6Filter: Code[250];
        BudgetDim7Filter: Code[250];
        BudgetDim8Filter: Code[250];
        PeriodInitialized: Boolean;
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[12] of Decimal;
        MATRIX_CaptionSet: array[12] of Text[80];
        MATRIX_EncumCellData: array[12] of Decimal;
        MATRIX_BalanceCellData: array[12] of Decimal;
        MATRIX_FundsCellData: array[12] of Decimal;
        RoundingFactorFormatString: Text;
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure DimCodeToOption(DimCode: Text[30]): Integer
    var
        BusUnit: Record "Business Unit";
        GLAcc: Record "G/L Account";
    begin
        case DimCode of
            '':
                exit(-1);
            GLAcc.TableCaption:
                exit(0);
            Text001:
                exit(1);
            BusUnit.TableCaption:
                exit(2);
            GLSetup."Global Dimension 1 Code":
                exit(3);
            GLSetup."Global Dimension 2 Code":
                exit(4);
            GLBudgetName."Budget Dimension 1 Code":
                exit(5);
            GLBudgetName."Budget Dimension 2 Code":
                exit(6);
            GLBudgetName."Budget Dimension 3 Code":
                exit(7);
            GLBudgetName."Budget Dimension 4 Code":
                exit(8);
            else
                exit(-1);
        end;
    end;

    local procedure FindRec(DimType: Enum "G/L Budget Matrix Dimensions"; var DimCodeBuf: Record "Dimension Code Buffer"; Which: Text[250]) Found: Boolean
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodPageMgt: Codeunit PeriodPageManagement;
    begin
        case DimType of
            DimType::"G/L Account":
                begin
                    GLAcc."No." := DimCodeBuf.Code;
                    if GLAccFilter <> '' then
                        GLAcc.SetFilter("No.", GLAccFilter);
                    SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
                    if GLAccCategoryFilter <> GLAccCategoryFilter::" " then
                        GLAcc.SetRange("Account Category", GLAccCategoryFilter);
                    Found := GLAcc.Find(Which);
                    if Found then
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                end;
            DimType::Period:
                begin
                    if not PeriodInitialized then
                        DateFilter := '';
                    PeriodInitialized := true;
                    Period."Period Start" := DimCodeBuf."Period Start";
                    if DateFilter <> '' then
                        Period.SetFilter("Period Start", DateFilter)
                    else
                        if not PeriodInitialized and (InternalDateFilter <> '') then
                            Period.SetFilter("Period Start", InternalDateFilter);
                    Found := PeriodPageMgt.FindDate(Which, Period, PeriodType);
                    if Found then
                        CopyPeriodToBuf(Period, DimCodeBuf);
                end;
            DimType::"Business Unit":
                begin
                    BusUnit.Code := DimCodeBuf.Code;
                    if BusUnitFilter <> '' then
                        BusUnit.SetFilter(Code, BusUnitFilter);
                    Found := BusUnit.Find(Which);
                    if Found then
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                end;
            DimType::"Global Dimension 1":
                begin
                    SetDimensionValueFilters(DimVal, GlobalDim1Filter, GLSetup."Global Dimension 1 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Global Dimension 2":
                begin
                    SetDimensionValueFilters(DimVal, GlobalDim2Filter, GLSetup."Global Dimension 2 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 1":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim1Filter, GLBudgetName."Budget Dimension 1 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 2":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim2Filter, GLBudgetName."Budget Dimension 2 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 3":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim3Filter, GLBudgetName."Budget Dimension 3 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 4":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim4Filter, GLBudgetName."Budget Dimension 4 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 5":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim5Filter, GLBudgetName."Budget Dimension 5 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 6":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim6Filter, GLBudgetName."Budget Dimension 6 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 7":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim7Filter, GLBudgetName."Budget Dimension 7 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 8":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim8Filter, GLBudgetName."Budget Dimension 8 Code", DimCodeBuf);
                    Found := DimVal.Find(Which);
                    if Found then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
        end;
        OnAfterFindRec(DimType, Which, DimCodeBuf, Found);
    end;

    local procedure NextRec(DimType: Enum "G/L Budget Matrix Dimensions"; var DimCodeBuf: Record "Dimension Code Buffer"; Steps: Integer) ResultSteps: Integer
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        Period: Record Date;
        DimVal: Record "Dimension Value";
        PeriodPageMgt: Codeunit PeriodPageManagement;
    begin
        case DimType of
            DimType::"G/L Account":
                begin
                    GLAcc."No." := DimCodeBuf.Code;
                    if GLAccFilter <> '' then
                        GLAcc.SetFilter("No.", GLAccFilter);
                    SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
                    if GLAccCategoryFilter <> GLAccCategoryFilter::" " then
                        GLAcc.SetRange("Account Category", GLAccCategoryFilter);
                    ResultSteps := GLAcc.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                end;
            DimType::Period:
                begin
                    if DateFilter <> '' then
                        Period.SetFilter("Period Start", DateFilter);
                    Period."Period Start" := DimCodeBuf."Period Start";
                    ResultSteps := PeriodPageMgt.NextDate(Steps, Period, PeriodType);
                    if ResultSteps <> 0 then
                        CopyPeriodToBuf(Period, DimCodeBuf);
                end;
            DimType::"Business Unit":
                begin
                    BusUnit.Code := DimCodeBuf.Code;
                    if BusUnitFilter <> '' then
                        BusUnit.SetFilter(Code, BusUnitFilter);
                    ResultSteps := BusUnit.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                end;
            DimType::"Global Dimension 1":
                begin
                    SetDimensionValueFilters(DimVal, GlobalDim1Filter, GLSetup."Global Dimension 1 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Global Dimension 2":
                begin
                    SetDimensionValueFilters(DimVal, GlobalDim2Filter, GLSetup."Global Dimension 2 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 1":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim1Filter, GLBudgetName."Budget Dimension 1 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 2":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim2Filter, GLBudgetName."Budget Dimension 2 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 3":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim3Filter, GLBudgetName."Budget Dimension 3 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 4":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim4Filter, GLBudgetName."Budget Dimension 4 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 5":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim5Filter, GLBudgetName."Budget Dimension 5 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 6":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim6Filter, GLBudgetName."Budget Dimension 6 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 7":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim7Filter, GLBudgetName."Budget Dimension 7 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
            DimType::"Budget Dimension 8":
                begin
                    SetDimensionValueFilters(DimVal, BudgetDim8Filter, GLBudgetName."Budget Dimension 8 Code", DimCodeBuf);
                    ResultSteps := DimVal.Next(Steps);
                    if ResultSteps <> 0 then
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                end;
        end;
        OnAfterNextRec(DimType, Steps, DimCodeBuf, ResultSteps);
    end;

    local procedure SetDimensionValueFilters(var DimensionValue: Record "Dimension Value"; CodeFilter: Code[250]; SetupDimensionCode: Code[20]; DimensionCodeBuffer: Record "Dimension Code Buffer")
    begin
        if CodeFilter <> '' then
            DimensionValue.SetFilter(Code, CodeFilter);
        DimensionValue."Dimension Code" := SetupDimensionCode;
        DimensionValue.SetRange("Dimension Code", DimensionValue."Dimension Code");
        DimensionValue.Code := DimensionCodeBuffer.Code;

        OnAfterSetDimensionValueFilters(DimensionValue);
    end;

    local procedure CopyGLAccToBuf(var TheGLAcc: Record "G/L Account"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheGLAcc."No.";
            Name := TheGLAcc.Name;
            Totaling := TheGLAcc.Totaling;
            Indentation := TheGLAcc.Indentation;
            "Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
        end;
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record Date; var TheDimCodeBuf: Record "Dimension Code Buffer")
    var
        Period2: Record Date;
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := Format(ThePeriod."Period Start");
            "Period Start" := ThePeriod."Period Start";
            "Period End" := ThePeriod."Period End";
            if DateFilter <> '' then begin
                Period2.SetFilter("Period End", DateFilter);
                if Period2.GetRangeMax("Period End") < "Period End" then
                    "Period End" := Period2.GetRangeMax("Period End");
            end;
            Name := ThePeriod."Period Name";
        end;
    end;

    local procedure CopyBusUnitToBuf(var TheBusUnit: Record "Business Unit"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheBusUnit.Code;
            if TheBusUnit.Name <> '' then
                Name := TheBusUnit.Name
            else
                Name := TheBusUnit."Company Name";
        end;
    end;

    local procedure CopyDimValToBuf(var TheDimVal: Record "Dimension Value"; var TheDimCodeBuf: Record "Dimension Code Buffer")
    begin
        with TheDimCodeBuf do begin
            Init;
            Code := TheDimVal.Code;
            Name := TheDimVal.Name;
            Totaling := TheDimVal.Totaling;
            Indentation := TheDimVal.Indentation;
            "Show in Bold" :=
              TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
        end;
    end;

    local procedure LookUpCode(DimType: Enum "G/L Budget Matrix Dimensions"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        DimVal: Record "Dimension Value";
    begin
        case DimType of
            DimType::"G/L Account":
                begin
                    GLAcc.Get(Code);
                    PAGE.RunModal(PAGE::"G/L Account List", GLAcc);
                end;
            DimType::Period:
                ;
            DimType::"Business Unit":
                begin
                    BusUnit.Get(Code);
                    PAGE.RunModal(PAGE::"Business Unit List", BusUnit);
                end;
            DimType::"Global Dimension 1", DimType::"Global Dimension 2",
            DimType::"Budget Dimension 1", DimType::"Budget Dimension 2",
            DimType::"Budget Dimension 3", DimType::"Budget Dimension 4":
                begin
                    DimVal.SetRange("Dimension Code", DimCode);
                    DimVal.Get(DimCode, Code);

                    PAGE.RunModal(PAGE::"Dimension Value List", DimVal);
                end;
        end;
        OnAfterLookUpCode(DimType, DimCode, Code);
    end;

    local procedure SetCommonFilters(var TheGLAccBudgetBuf: Record "G/L Acc. Budget Buffer")
    begin
        with TheGLAccBudgetBuf do begin
            Reset;
            SetRange("Budget Filter", GLBudgetName.Name);
            if BusUnitFilter <> '' then
                SetFilter("Business Unit Filter", BusUnitFilter);
            if GLAccFilter <> '' then
                SetFilter("G/L Account Filter", GLAccFilter);
            if IncomeBalanceGLAccFilter <> IncomeBalanceGLAccFilter::" " then
                SetRange("Income/Balance", IncomeBalanceGLAccFilter);
            if DateFilter <> '' then
                SetFilter("Date Filter", DateFilter);
            if GlobalDim1Filter <> '' then
                SetFilter("Global Dimension 1 Filter", GlobalDim1Filter);
            if GlobalDim2Filter <> '' then
                SetFilter("Global Dimension 2 Filter", GlobalDim2Filter);
            if BudgetDim1Filter <> '' then
                SetFilter("Budget Dimension 1 Filter", BudgetDim1Filter);
            if BudgetDim2Filter <> '' then
                SetFilter("Budget Dimension 2 Filter", BudgetDim2Filter);
            if BudgetDim3Filter <> '' then
                SetFilter("Budget Dimension 3 Filter", BudgetDim3Filter);
            if BudgetDim4Filter <> '' then
                SetFilter("Budget Dimension 4 Filter", BudgetDim4Filter);
        end;
        OnAfterSetCommonFilters(GLAccBudgetBuf);
    end;

    local procedure SetDimFilters(var TheGLAccBudgetBuf: Record "G/L Acc. Budget Buffer"; LineOrColumn: Option Line,Column)
    var
        DimCodeBuf: Record "Dimension Code Buffer";
        DimType: Enum "G/L Budget Matrix Dimensions";
    begin
        if LineOrColumn = LineOrColumn::Line then begin
            DimCodeBuf := Rec;
            DimType := LineDimType;
        end else begin
            DimCodeBuf := MATRIX_MatrixRecord;
            DimType := ColumnDimType;
        end;

        with TheGLAccBudgetBuf do
            case DimType of
                DimType::"G/L Account":
                    if DimCodeBuf.Totaling <> '' then
                        GLAccBudgetBuf.SetFilter("G/L Account Filter", DimCodeBuf.Totaling)
                    else
                        GLAccBudgetBuf.SetRange("G/L Account Filter", DimCodeBuf.Code);
                DimType::Period:
                    SetRange("Date Filter", DimCodeBuf."Period Start", DimCodeBuf."Period End");
                DimType::"Business Unit":
                    SetRange("Business Unit Filter", DimCodeBuf.Code);
                DimType::"Global Dimension 1":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Global Dimension 1 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Global Dimension 1 Filter", DimCodeBuf.Code);
                DimType::"Global Dimension 2":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Global Dimension 2 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Global Dimension 2 Filter", DimCodeBuf.Code);
                DimType::"Budget Dimension 1":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Budget Dimension 1 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Budget Dimension 1 Filter", DimCodeBuf.Code);
                DimType::"Budget Dimension 2":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Budget Dimension 2 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Budget Dimension 2 Filter", DimCodeBuf.Code);
                DimType::"Budget Dimension 3":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Budget Dimension 3 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Budget Dimension 3 Filter", DimCodeBuf.Code);
                DimType::"Budget Dimension 4":
                    if DimCodeBuf.Totaling <> '' then
                        SetFilter("Budget Dimension 4 Filter", DimCodeBuf.Totaling)
                    else
                        SetRange("Budget Dimension 4 Filter", DimCodeBuf.Code);
            end;
        OnAfterSetDimFilters(TheGLAccBudgetBuf, DimType, DimCodeBuf);
    end;

    local procedure BudgetDrillDown()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetEntry.SetRange("Budget Name", GLBudgetName.Name);
        if GLAccBudgetBuf.GetFilter("G/L Account Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("G/L Account Filter", GLBudgetEntry."G/L Account No.");
        if GLAccBudgetBuf.GetFilter("Business Unit Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Business Unit Filter", GLBudgetEntry."Business Unit Code");
        if GLAccBudgetBuf.GetFilter("Global Dimension 1 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Global Dimension 1 Filter", GLBudgetEntry."Global Dimension 1 Code");
        if GLAccBudgetBuf.GetFilter("Global Dimension 2 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Global Dimension 2 Filter", GLBudgetEntry."Global Dimension 2 Code");
        if GLAccBudgetBuf.GetFilter("Budget Dimension 1 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Budget Dimension 1 Filter", GLBudgetEntry."Budget Dimension 1 Code");
        if GLAccBudgetBuf.GetFilter("Budget Dimension 2 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Budget Dimension 2 Filter", GLBudgetEntry."Budget Dimension 2 Code");
        if GLAccBudgetBuf.GetFilter("Budget Dimension 3 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Budget Dimension 3 Filter", GLBudgetEntry."Budget Dimension 3 Code");
        if GLAccBudgetBuf.GetFilter("Budget Dimension 4 Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Budget Dimension 4 Filter", GLBudgetEntry."Budget Dimension 4 Code");
        if GLAccBudgetBuf.GetFilter("Date Filter") <> '' then
            GLAccBudgetBuf.CopyFilter("Date Filter", GLBudgetEntry.Date)
        else
            GLBudgetEntry.SetRange(Date, 0D, DMY2Date(31, 12, 9999));
        with GLBudgetEntry do
            if (GetFilter("Global Dimension 1 Code") <> '') or (GetFilter("Global Dimension 2 Code") <> '') or
               (GetFilter("Business Unit Code") <> '')
            then
                SetCurrentKey("Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code")
            else
                SetCurrentKey("Budget Name", "G/L Account No.", Date);
        OnBudgetDrillDownOnBeforePageRun(GLAccBudgetBuf, GLBudgetEntry);
        PAGE.Run(0, GLBudgetEntry);
    end;

    local procedure CalcAmount(SetColumnFilter: Boolean): Decimal
    begin
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        if SetColumnFilter then
            SetDimFilters(GLAccBudgetBuf, 1);
        exit(CalcFieldsAndGetBudgetedAmount(GLAccBudgetBuf));
    end;

    local procedure CalcFieldsAndGetBudgetedAmount(var GLAccBudgetBuf: Record "G/L Acc. Budget Buffer") Result: Decimal
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalcFieldsAndGetBudgetedAmount(GLAccBudgetBuf, Result, IsHandled);
        if IsHandled then
            exit(Result);

        GLAccBudgetBuf.CalcFields("Budgeted Amount");
        exit(GLAccBudgetBuf."Budgeted Amount");
    end;

    local procedure FromRoundedValue(OrgAmount: Decimal): Decimal
    var
        NewAmount: Decimal;
    begin
        NewAmount := OrgAmount;
        case RoundingFactor of
            RoundingFactor::"1000":
                NewAmount := OrgAmount * 1000;
            RoundingFactor::"1000000":
                NewAmount := OrgAmount * 1000000;
        end;
        exit(NewAmount);
    end;

#if not CLEAN19
    [Obsolete('Replaced by LoadMatrix().', '19.0')]
    procedure Load(MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[12] of Record "Dimension Code Buffer"; CurrentNoOfMatrixColumns: Integer; NewLineDimCode: Text[30]; NewLineDimOption: Integer; NewColumnDimOption: Integer; NewGlobalDim1Filter: Code[250]; NewGlobalDim2Filter: Code[250]; NewBudgetDim1Filter: Code[250]; NewBudgetDim2Filter: Code[250]; NewBudgetDim3Filter: Code[250]; NewBudgetDim4Filter: Code[250]; var NewGLBudgetName: Record "G/L Budget Name"; NewDateFilter: Text[30]; NewGLAccFilter: Code[250]; NewIncomeBalanceGLAccFilter: Option; NewGLAccCategoryFilter: Enum "G/L Account Category"; NewRoundingFactor: Integer; NewPeriodType: Enum "Analysis Period Type")
    begin
        LoadMatrix(
            MatrixColumns1, MatrixRecords1, CurrentNoOfMatrixColumns, NewLineDimCode,
            "G/L Budget Matrix Dimensions".FromInteger(NewLineDimOption),
            "G/L Budget Matrix Dimensions".FromInteger(NewColumnDimOption),
            NewGlobalDim1Filter, NewGlobalDim2Filter, NewBudgetDim1Filter, NewBudgetDim2Filter,
            NewBudgetDim3Filter, NewBudgetDim4Filter, NewGLBudgetName, NewDateFilter, NewGLAccFilter,
            "G/L Account Income/Balance".FromInteger(NewIncomeBalanceGLAccFilter), NewGLAccCategoryFilter,
            "Analysis Rounding Factor".FromInteger(NewRoundingFactor), NewPeriodType);
    end;
#endif

    procedure LoadMatrix(NewMatrixColumns: array[32] of Text[80]; var NewMatrixRecords: array[12] of Record "Dimension Code Buffer"; CurrentNoOfMatrixColumns: Integer; NewLineDimCode: Text[30]; NewLineDimType: Enum "G/L Budget Matrix Dimensions"; NewColumnDimType: Enum "G/L Budget Matrix Dimensions"; NewGlobalDim1Filter: Code[250]; NewGlobalDim2Filter: Code[250]; NewBudgetDim1Filter: Code[250]; NewBudgetDim2Filter: Code[250]; NewBudgetDim3Filter: Code[250]; NewBudgetDim4Filter: Code[250]; var NewGLBudgetName: Record "G/L Budget Name"; NewDateFilter: Text[30]; NewGLAccFilter: Code[250]; NewIncomeBalanceGLAccFilter: Enum "G/L Account Income/Balance"; NewGLAccCategoryFilter: Enum "G/L Account Category"; NewRoundingFactor: Enum "Analysis Rounding Factor"; NewPeriodType: Enum "Analysis Period Type")
    var
        i: Integer;
    begin
        for i := 1 to 12 do
            MATRIX_CellData[i] := 0;

        for i := 1 to 12 do begin
            if NewMatrixColumns[i] = '' then
                MATRIX_CaptionSet[i] := ' '
            else
                MATRIX_CaptionSet[i] := NewMatrixColumns[i];
            MatrixRecords[i] := NewMatrixRecords[i];
        end;
        if CurrentNoOfMatrixColumns > ArrayLen(MATRIX_CellData) then
            MATRIX_CurrentNoOfMatrixColumn := ArrayLen(MATRIX_CellData)
        else
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        LineDimCode := NewLineDimCode;
        LineDimType := NewLineDimType;
        ColumnDimType := NewColumnDimType;
        GlobalDim1Filter := NewGlobalDim1Filter;
        GlobalDim2Filter := NewGlobalDim2Filter;
        BudgetDim1Filter := NewBudgetDim1Filter;
        BudgetDim2Filter := NewBudgetDim2Filter;
        BudgetDim3Filter := NewBudgetDim3Filter;
        BudgetDim4Filter := NewBudgetDim4Filter;
        GLBudgetName := NewGLBudgetName;
        DateFilter := NewDateFilter;
        GLAccFilter := NewGLAccFilter;
        IncomeBalanceGLAccFilter := NewIncomeBalanceGLAccFilter;
        GLAccCategoryFilter := NewGLAccCategoryFilter;
        RoundingFactor := NewRoundingFactor;
        PeriodType := NewPeriodType;
        RoundingFactorFormatString := MatrixMgt.FormatRoundingFactor(RoundingFactor, false);
        InternalDateFilter := '';
    end;

    local procedure MATRIX_OnDrillDown(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        SetDimFilters(GLAccBudgetBuf, 1);
        BudgetDrillDown;
    end;

    local procedure MATRIX_OnAfterGetRecord(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundAmount(CalcAmount(true), RoundingFactor);
    end;

    local procedure UpdateAmount1(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
    begin
        Message('%1', DateFilter);
        //   CurrPage.Update();
    end;

    local procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
    begin
        if MATRIX_ColumnOrdinal > MATRIX_CurrentNoOfMatrixColumn then
            Error(Text002, MATRIX_CurrentNoOfMatrixColumn);
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        NewAmount := FromRoundedValue(MATRIX_CellData[MATRIX_ColumnOrdinal]);
        if CalcAmount(true) = 0 then; // To set filters correctly
        CalcFieldsAndSetNewBudgetedAmount(GLAccBudgetBuf, NewAmount);
        Rec.Amount := MatrixMgt.RoundAmount(CalcAmount(false), RoundingFactor);
        CurrPage.Update();
    end;

    local procedure CalcFieldsAndSetNewBudgetedAmount(var GLAccBudgetBuf: Record "G/L Acc. Budget Buffer"; NewAmount: Decimal)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalcFieldsAndSetNewBudgetedAmount(GLAccBudgetBuf, NewAmount, IsHandled);
        if IsHandled then
            exit;

        GLAccBudgetBuf.CalcFields("Budgeted Amount");
        GLAccBudgetBuf.Validate("Budgeted Amount", NewAmount);
    end;

    local procedure GLAccountBalanceBudget()
    var
        GLAcc: Record "G/L Account";
    begin
        if DimCodeToOption(LineDimCode) = 0 then
            GLAcc.Get(Rec.Code)
        else begin
            if GLAccFilter <> '' then
                GLAcc.SetFilter("No.", GLAccFilter);
            SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
            if GLAccCategoryFilter <> GLAccCategoryFilter::" " then
                GLAcc.SetRange("Account Category", GLAccCategoryFilter);
            GLAcc.FindFirst();
            GLAcc.Reset();
        end;
        with GLAcc do begin
            SetRange("Budget Filter", GLBudgetName.Name);
            if DateFilter <> '' then
                SetFilter("Date Filter", DateFilter);
            if BusUnitFilter <> '' then
                SetFilter("Business Unit Filter", BusUnitFilter);
            if GLAccFilter <> '' then
                SetFilter("No.", GLAccFilter);
            SetIncomeBalanceGLAccFilterOnGLAcc(GLAcc);
            if GLAccCategoryFilter <> GLAccCategoryFilter::" " then
                SetRange("Account Category", GLAccCategoryFilter);
            if GlobalDim1Filter <> '' then
                SetFilter("Global Dimension 1 Filter", GlobalDim1Filter);
            if GlobalDim2Filter <> '' then
                SetFilter("Global Dimension 2 Filter", GlobalDim2Filter);
        end;
        PAGE.Run(PAGE::"G/L Account Balance/Budget", GLAcc);
    end;

    local procedure FormatLine()
    begin
        Emphasize := Rec."Show in Bold";
        NameIndent := Rec.Indentation;
    end;

    local procedure FormatStr(): Text
    begin
        exit(RoundingFactorFormatString);
    end;

    local procedure SetIncomeBalanceGLAccFilterOnGLAcc(var GLAccount: Record "G/L Account")
    begin
        case IncomeBalanceGLAccFilter of
            IncomeBalanceGLAccFilter::"Balance Sheet":
                GLAccount.SetRange("Income/Balance", GLAccount."Income/Balance"::"Balance Sheet");
            IncomeBalanceGLAccFilter::"Income Statement":
                GLAccount.SetRange("Income/Balance", GLAccount."Income/Balance"::"Income Statement");
        end;

        OnAfterSetIncomeBalanceGLAccFilterOnGLAcc(GLAccount);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFindRec(DimType: Enum "G/L Budget Matrix Dimensions"; Which: Text[250]; var DimensionCodeBuffer: Record "Dimension Code Buffer"; var Found: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookUpCode(DimType: Enum "G/L Budget Matrix Dimensions"; DimCode: Text[30]; FieldCode: Text[30])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterNextRec(DimType: Enum "G/L Budget Matrix Dimensions"; Steps: Integer; var DimensionCodeBuffer: Record "Dimension Code Buffer"; var ResultSteps: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetCommonFilters(var TheGLAccBudgetBuffer: Record "G/L Acc. Budget Buffer")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetDimFilters(var TheGLAccBudgetBuffer: Record "G/L Acc. Budget Buffer"; DimType: Enum "G/L Budget Matrix Dimensions"; DimCodeBuf: Record "Dimension Code Buffer")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetIncomeBalanceGLAccFilterOnGLAcc(var GLAccount: Record "G/L Account")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetDimensionValueFilters(var DimensionValue: Record "Dimension Value")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcFieldsAndGetBudgetedAmount(var GLAccBudgetBuffer: Record "G/L Acc. Budget Buffer"; var Result: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcFieldsAndSetNewBudgetedAmount(var GLAccBudgetBuf: Record "G/L Acc. Budget Buffer"; NewAmount: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBudgetDrillDownOnBeforePageRun(var GLAccBudgetBuffer: Record "G/L Acc. Budget Buffer"; var GLBudgetEntry: Record "G/L Budget Entry")
    begin
    end;
}

