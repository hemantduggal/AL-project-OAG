table 50004 "Terms and  Condition"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[2047])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        usersetup: Record "User Setup";
    begin
        usersetup.RESET;
        usersetup.SETRANGE("User ID", USERID);
        usersetup.SETFILTER(usersetup."AccessPOTerms&ConditionMaster", '%1', usersetup."AccessPOTerms&ConditionMaster"::View);
        IF usersetup.FINDFIRST THEN
            ERROR('You can not create new PO Terms & Condition Master');
        //PRU_DD 1.10
    end;
}