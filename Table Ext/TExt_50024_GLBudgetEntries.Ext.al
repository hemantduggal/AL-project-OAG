tableextension 50024 GLBudgetEntries extends "G/L Budget Entry"
{
    fields
    {
        field(50000; "Budget Type"; Option)
        {
            OptionMembers = ,"Annual Budged","Supplementry Budget";
        }
        field(50001; "Budget Status"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Budget Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        /*
        field(50003; "Budget Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        */
        /*
        field(50002; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,1,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin

            end;
        }
        field(50003; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,1,4';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin

            end;
        }

        */
    }


    var
        GetGLSetup: Record "General Ledger Setup";
}