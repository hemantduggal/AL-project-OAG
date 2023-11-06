pageextension 50073 BlanketPOSubformEx1 extends "Blanket Purchase Order Subform"
{
    layout
    {
        addbefore("Qty. to Receive")
        {
            field("Amount Inc VAT"; Rec."Amount Inc VAT")
            {
                ApplicationArea = all;
            }
        }
    }
}