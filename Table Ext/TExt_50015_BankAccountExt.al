tableextension 50015 bankaccountEXT extends "Bank Account"
{
    fields
    {
        field(50000; Status; Option)
        {
            // Editable = false;
            OptionCaption = ' ,Released,Open,Rejected,"Pending For Approval"';
            OptionMembers = " ",Released,Open,Rejected,"Pending For Approval";
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new bank');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}