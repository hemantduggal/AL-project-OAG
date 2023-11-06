tableextension 50011 GLBudgetNameExt extends "G/L Budget Name"
{
    fields
    {
        field(50000; "Budget Type"; Option)
        {
            Caption = 'Budget Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Annual Budget,Supplementry Budget';
            OptionMembers = " ","Annual Budget","Supplementry Budget";
        }
        field(50001; "Budget Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Status';
            OptionCaption = ' ,Initial Budget, Revised Budget, Approval Pending, Final Budget';
            OptionMembers = " ","Initial Budget","Revised Budget","Approval Pending","Final Budget";
        }
        field(50002; Status; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Budget Dimension 5 Code"; Code[20])
        {
            Caption = 'Budget Dimension 5 Code';
            TableRelation = Dimension;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Budget Dimension 5 Code" <> xRec."Budget Dimension 5 Code" then
                    if Dim.CheckIfDimUsed("Budget Dimension 5 Code", 13, Name, '', 0) then
                        Error(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(50004; "Budget Dimension 6 Code"; Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            TableRelation = Dimension;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Budget Dimension 6 Code" <> xRec."Budget Dimension 6 Code" then
                    if Dim.CheckIfDimUsed("Budget Dimension 6 Code", 14, Name, '', 0) then
                        Error(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(50005; "Financial Year"; Text[50])//Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecAccPeriod: Record 50;
                date1: date;
                date2: date;
            begin
                /*
                RecAccPeriod.RESET;
                RecAccPeriod.SETRANGE("New Fiscal Year", TRUE);
                RecAccPeriod."Starting Date" := WORKDATE;
                if RecAccPeriod.Find('=<') then //First() then
                    Date1 := RecAccPeriod."Starting Date";
                IF RecAccPeriod.NEXT = 0 THEN
                    Date2 := 99991231D//12319999D
                ELSE
                    Date2 := RecAccPeriod."Starting Date" - 1;
                // "Financial Year" := RecAccPeriod."Code Type";
                */
            end;
        }
        field(50006; "Budget Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Budget Dimension 7 Code"; Code[20])
        {
            Caption = 'Budget Dimension 7 Code';
            TableRelation = Dimension;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Budget Dimension 7 Code" <> xRec."Budget Dimension 7 Code" then
                    if Dim.CheckIfDimUsed("Budget Dimension 7 Code", 14, Name, '', 0) then
                        Error(Text000, Dim.GetCheckDimErr);
            end;
        }
        field(50008; "Budget Dimension 8 Code"; Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            TableRelation = Dimension;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Budget Dimension 8 Code" <> xRec."Budget Dimension 8 Code" then
                    if Dim.CheckIfDimUsed("Budget Dimension 8 Code", 15, Name, '', 0) then
                        Error(Text000, Dim.GetCheckDimErr);
            end;
        }
    }
    var
        Text000: Label '%1\You cannot use the same dimension twice in the same budget.';
        Dim: Record Dimension;
}