pageextension 50020 PostedPurchaseReceiptsExt extends "Posted Purchase Receipts"
{
    Caption = 'Goods Receipt Note';
    layout
    {
        addafter("No.")
        {

        }
    }
    /*   trigger OnOpenPage()
       begin
           Rec.SetSecurityFilterOnRespCenter;   //<<PRU_RC
           UserSetup.GET(USERID);
           Rec.FILTERGROUP(2);
           Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
           Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
           IF NOT UserSetup."HO Users" THEN
               //  Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
               Rec.FILTERGROUP(0);
       end;
   */
    var
        UserSetup: Record 91;

}