tableextension 50016 VendorExt extends Vendor
{
    fields
    {
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors,Staff';
            OptionMembers = " ","Advance Vendors","Normal Vendors","Staff";
        }
        field(50030; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";

            trigger OnValidate()
            var
                user: Record "User Setup";
            begin
                checkstoreuser();
            end;
        }
        field(50008; "WHT Payable Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry".Amount WHERE("Bill-to/Pay-to No." = FIELD("No."),
                                                                               "Transaction Type" = CONST(Purchase)));
            Caption = 'WHT Payable Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50009; "WHT Registration ID"; Text[20])
        {
            Caption = 'WHT Registration ID';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            trigger OnValidate()
            var
                user: Record "User Setup";
            begin
                checkstoreuser();
            end;
        }
        field(50011; "WHT Exempt Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            trigger OnValidate()
            var
                user: Record "User Setup";
            begin
                checkstoreuser();
            end;
        }
        field(50012; status; Option)
        {
            OptionMembers = Pending,Approved;
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new vendor');
        //PRU_DD 1.10
    end;

    // trigger OnAfterModify()
    // begin
    //     rec.status := Rec.status::Pending;
    //     Rec.Modify();
    // end;

    // trigger OnModify()
    // begin
    //     rec.status := Rec.status::Pending;
    //     Rec.Modify();
    // end;

    // trigger OnAfterInsert()
    // begin
    //     rec.status := Rec.status::Pending;
    // end;
    procedure checkstoreuser()
    var
        user: Record "User Setup";
    begin
        if user.get(UserId) then
            if user.storeuser <> true then
                Error('You can not edit this field');
    end;
}