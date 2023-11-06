tableextension 50021 CustomerExt extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50006; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50007; "WHT Payable Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Rem Unrealized Amount (LCY)" WHERE("Bill-to/Pay-to No." = FIELD("No."),
                                                                               "Transaction Type" = CONST(Sale)));
            Caption = 'WHT Payable Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new customer');
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
}






