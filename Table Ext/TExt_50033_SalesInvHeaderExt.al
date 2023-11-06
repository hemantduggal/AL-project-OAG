tableextension 50033 salesinvHeadExt extends "Sales Invoice Header"
{
    fields
    {

        field(50009; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50010; "Rem. WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Remaining Unrealized Amount" WHERE("Document Type" = CONST(Invoice),
                                                                               "Document No." = FIELD("No.")));
            Caption = 'Rem. WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50011; "Paid WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry".Amount WHERE("Document Type" = CONST(Payment),
                                                        "Document No." = FIELD("No.")));
            Caption = 'Paid WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50012; "Total WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Unrealized Amount" WHERE("Document Type" = CONST(Invoice),
                                                                     "Document No." = FIELD("No.")));
            Caption = 'Total WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }

    }

}