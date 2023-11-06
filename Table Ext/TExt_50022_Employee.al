tableextension 50022 empExt extends Employee
{
    fields
    {
        field(50000; type; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        // Add changes to table fields here
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Employee Master", '%1', UserSetup."Employee Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new Employee');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}