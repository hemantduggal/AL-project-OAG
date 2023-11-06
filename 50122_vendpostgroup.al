pageextension 50122 Vendorposting extends "Vendor Posting Group Card"
{
    layout
    {
        addafter("Payables Account")
        {
            field("WHT VAT"; Rec."WHT VAT")
            {
                ApplicationArea = all;
            }
        }
    }
}