pageextension 50107 SourceCodeSetup extends "Source Code Setup"
{
    layout
    {
        addafter("Adjust Add. Reporting Currency")
        {
            field("WHT Settlement"; rec."WHT Settlement")
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