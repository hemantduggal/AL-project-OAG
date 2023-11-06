pageextension 50106 Resource extends "Resource Card"
{
    layout
    {
        addafter(Address)
        {
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}