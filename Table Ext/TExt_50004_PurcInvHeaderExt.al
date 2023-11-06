tableextension 50004 PurcInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Type';
            OptionCaption = ' ,Micro,Macro';
            OptionMembers = " ",Micro,Macro;

        }
        field(50001; "Requisition Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition No.';
            TableRelation = "Requisition Header";
        }
        field(50002; "Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference No.';
        }
        field(50003; "Details T&C (Attach)"; text[2047])
        {
            DataClassification = ToBeClassified;
            Caption = 'Details T&C (Attach)';
        }
        field(50004; "General T&C"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'General T&C';
        }
        field(50005; "Special T&C "; text[2047])
        {
            DataClassification = ToBeClassified;
            Caption = 'Special T&C ';
        }
        field(50006; "Store Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store Admin Comment';
        }
        field(50007; "Store_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50008; Store_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
        }
        field(50009; Store_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
        }
        field(50010; "Store_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }
        field(50013; "Contract Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Comment';
        }
        field(50014; "Contract_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50015; Contract_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
        }
        field(50016; Contract_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
        }
        field(50017; "Contract_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }

        field(50018; "Internal Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Internal Comment';
        }
        field(50019; "Internal_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50020; Internal_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
        }
        field(50021; Internal_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
        }
        field(50022; "Internal_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors';
            OptionMembers = " ","Advance Vendors","Normal Vendors";
        }
        field(50030; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50031; "Rem. WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Remaining Unrealized Amount" WHERE("Document Type" = CONST("Invoice"),
                                                                               "Document No." = FIELD("No.")));
            Caption = 'Rem. WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50032; "Paid WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry".Amount WHERE("Document Type" = CONST(Payment),
                                                        "Document No." = FIELD("No.")));
            Caption = 'Paid WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50033; "Total WHT Prepaid Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("WHT Entry"."Unrealized Amount" WHERE("Document Type" = CONST("Invoice"),
                                                                     "Document No." = FIELD("No.")));
            Caption = 'Total WHT Prepaid Amount (LCY)';
            Description = 'PRU_RPG WHT_0.1';
            FieldClass = FlowField;
        }
        field(50040; "approver's comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; StoreApprover; CODE[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; ContractorApprover; Code[20])

        {
            DataClassification = ToBeClassified;
        }
        field(50044; InternalApprover; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var

}