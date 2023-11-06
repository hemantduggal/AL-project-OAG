pageextension 50004 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    layout
    {
        addbefore(Description)
        {
            field("EFT/Document No."; Rec."EFT/Document No.")
            {
                ApplicationArea = all;
            }
        }
    }



    trigger OnOpenPage()
    begin

        UserSetup.GET(USERID);
        IF NOT UserSetup."HO Users" THEN BEGIN
            Rec.FILTERGROUP(2);
            //    Rec.SETFILTER("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            //    Rec.SETFILTER("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            //SETFILTER("Shortcut Dimension 3 Code",UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Reverse Transaction", TRUE);
        IF UserSetup.FINDFIRST THEN
            ReverseTransVisible := TRUE
        ELSE
            ReverseTransVisible := FALSE;
    end;

    var
        myInt: Integer;
        ReverseTransVisible: Boolean;
        UserSetup: Record 91;
}