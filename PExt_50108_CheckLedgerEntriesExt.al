pageextension 50108 CheckLedgerEntry extends "Check Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("WHT Amount"; rec."WHT Amount")
            {
                ApplicationArea = all;
            }
            field("Interest Amount"; rec."Interest Amount")
            {
                ApplicationArea = all;
            }
        }
    }
}