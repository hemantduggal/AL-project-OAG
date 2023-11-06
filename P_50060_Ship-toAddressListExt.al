pageextension 50060 "Ship to Address List" extends "Ship-to Address List"
{
    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Ship to Address", '%1', UserSetup."Access Ship to Address"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to change Ship-to-Address Details');
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}