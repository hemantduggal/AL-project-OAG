pageextension 50049 ReleasedProductionOrdersExt extends "Released Production Orders"
{
    layout
    {
        addafter(Description)
        {

        }
    }



    trigger OnOpenPage()
    begin
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        //  Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        //  Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            //  Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        //>>RPU_RC
    end;



    var
        myInt: Integer;
        UserSetup: Record 91;
}