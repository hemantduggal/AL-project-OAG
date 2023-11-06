pageextension 50114 SalesQuote extends "Sales Quote"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }

}