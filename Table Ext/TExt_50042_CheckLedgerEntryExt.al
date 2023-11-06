tableextension 50042 checkledentry extends "Check Ledger Entry"
{

    fields
    {
        field(50005; "WHT Amount"; Decimal)
        {
            Caption = 'WHT Amount';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50006; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
}