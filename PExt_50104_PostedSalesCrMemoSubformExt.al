pageextension 50104 SalesCrMemoLine extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("ShortcutDimCode[8]")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                ApplicationArea = all;
            }

        }
    }
}