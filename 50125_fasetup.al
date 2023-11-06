pageextension 50127 fasetup extends "Fixed Asset Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Approval User Groups")
            {
                field("Reclassification User Group"; Rec."Reclassification User Group")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    var
        por: page "Purchase Invoices";
}