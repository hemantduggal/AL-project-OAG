tableextension 50054 compinfoExt extends "Company Information"
{
    fields
    {
        field(50000; "WHT Registration ID"; Text[30])
        {
            Caption = 'WHT Registration ID';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
}