pageextension 50028 FixedAssetGLJournalExt extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter("Document Type")
        {

        }
    }


    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR(' You can not delete the Fixed Asset G/L Journal');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR(' You can not modify the Fixed Asset G/L Journal');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Fixed Asset G/L Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;



    var
        myInt: Integer;
        UserSetup: Record 91;

}