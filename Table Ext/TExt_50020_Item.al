tableextension 50020 ItemExt extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50013; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50014; "WHT Exempt Product"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50015; RequistionItem; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Minimum Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeInsert()
    var
        usersetup: Record "User Setup";
    begin
        usersetup.RESET;
        usersetup.SETRANGE("User ID", USERID);
        usersetup.SETFILTER(usersetup."Access Item Master", '%1', usersetup."Access Item Master"::View);
        IF usersetup.FINDFIRST THEN
            ERROR('You can not create new Item');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}