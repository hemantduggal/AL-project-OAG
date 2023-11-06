/*pageextension 50100 InvoicePostBuffer extends "Job Invoices"
{

    layout
    {
        addafter("Document Type")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
*/