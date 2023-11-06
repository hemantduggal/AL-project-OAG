pageextension 50103 postedSalesCrmemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("No. Printed")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}