tableextension 50043 SalesRecvblSetup extends "Sales & Receivables Setup"
{

    fields
    {
        field(50000; "Print WHT on Credit Memo"; Boolean)
        {
            Caption = 'Print WHT on Credit Memo';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50001; "Print Dialog"; Boolean)
        {
            Caption = 'Print Dialog';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }

}