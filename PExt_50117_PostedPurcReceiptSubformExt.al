pageextension 50117 PostedPurchRcptSubform extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("ShortcutDimCode[8]")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
            {
            }
            field("WHT Absorb Base"; Rec."WHT Absorb Base")
            {
            }
        }
    }
}