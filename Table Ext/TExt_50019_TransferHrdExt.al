tableextension 50019 TransferHdrExt extends "Transfer Header"
{
    fields
    {
        // Add changes to table fields here
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Transfer Order", '%1', UserSetup."Access Transfer Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Transfer Order');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}