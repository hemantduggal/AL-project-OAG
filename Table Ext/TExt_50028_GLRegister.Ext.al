tableextension 50028 GLRegisterExt extends "G/L Register"
{
    fields
    {

        field(50000; "From WHT Entry No."; Integer)
        {
            Caption = 'From WHT Entry No.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50001; "To WHT Entry No."; Integer)
        {
            Caption = 'To WHT Entry No.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
    }

}

