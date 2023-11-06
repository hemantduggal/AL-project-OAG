tableextension 50008 VLEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "EFT/Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT/Document No.';
        }
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors';
            OptionMembers = " ","Advance Vendors","Normal Vendors";
        }
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
            CalcFormula = Sum("WHT Entry".Amount WHERE("Bill-to/Pay-to No." = FIELD("Vendor No."),
                                                        "Original Document No." = FIELD("Document No.")));
            Caption = 'WHT Amount';
            Description = 'PRU_RPG WHT_0.1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "WHT Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Amount (LCY)" WHERE("Bill-to/Pay-to No." = FIELD("Vendor No."),
                                                                "Original Document No." = FIELD("Document No.")));
            Caption = 'WHT Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}