pageextension 50021 PostedPurchaseInvoicesExt extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {

        }
    }

    /*   trigger OnOpenPage()
   begin

          //<<PRU_RC
          UserSetup.GET(USERID);
          //FILTERGROUP(2);
          Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
          Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
          Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
          //// IF NOT UserSetup."HO Users" THEN
          //// Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
          //FILTERGROUP(0);
      end;
  */
    var
        UserSetup: Record 91;
}