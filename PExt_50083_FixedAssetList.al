pageextension 50083 FixedAssetListExt extends 5601
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(CalculateDepreciation)
        {
            action(DeleteAll)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    fa: Record "Fixed Asset";
                begin
                    fa.DeleteAll();
                end;
            }
        }
        // Add changes to page actions here
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Fixed Asset');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Fixed Asset Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.AccessFixedAssetsMaster, '%1', UserSetup.AccessFixedAssetsMaster::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}