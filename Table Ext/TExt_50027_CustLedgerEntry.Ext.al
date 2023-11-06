tableextension 50027 custLedEntryExt extends "Cust. Ledger Entry"
{

    fields
    {

        field(50002; "Rem. Amt for WHT"; Decimal)
        {
            Caption = 'Rem. Amt for WHT';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50003; "Rem. Amt"; Decimal)
        {
            Caption = 'Rem. Amt';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50004; "WHT Amount"; Decimal)
        {
            CalcFormula = Sum("WHT Entry".Amount WHERE("Bill-to/Pay-to No." = FIELD("Customer No."),
                                                        "Transaction No." = FIELD("Transaction No.")));
            Caption = 'WHT Amount';
            Description = 'PRU_RPG WHT_0.1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "WHT Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Amount (LCY)" WHERE("Bill-to/Pay-to No." = FIELD("Customer No."),
                                                                "Transaction No." = FIELD("Transaction No.")));
            Caption = 'WHT Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "WHT Payment"; Boolean)
        {
            Caption = 'WHT Payment';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
    procedure CopyFromGenJnlLine(GenJnlLine: Record 81)
    begin
        "WHT Payment" := GenJnlLine."WHT Payment";  //PRU_RPG WHT_0.1
    end;
}