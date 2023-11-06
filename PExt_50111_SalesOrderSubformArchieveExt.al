pageextension 50111 SaleLinearchive extends "Sales Line Archive List"
{
    layout
    {
        addafter("No.")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = All;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = All;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                ApplicationArea = All;
            }
        }
    }
}