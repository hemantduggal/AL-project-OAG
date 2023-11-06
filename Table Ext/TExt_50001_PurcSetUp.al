tableextension 50001 PurcSetUp extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purch. Requisition"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Archie Requisition No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Visual Inspection Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Store User Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Internal Auditor Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Contract Manager Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "WHT Certificate No. Series"; Code[20])//Pru Neha
        {
            Caption = 'WHT Certificate No. Series';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "No. Series";
        }
        field(50007; "Print Dialog"; Boolean)
        {
            Caption = 'Print Dialog';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50008; "Print WHT Docs. on Pay. Post"; Boolean)//Pru Neha
        {
            Caption = 'Print WHT Docs. on Pay. Post';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50009; "Print WHT Docs. on Credit Memo"; Boolean)//Pru Neha
        {
            Caption = 'Print WHT Docs. on Credit Memo';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50010; vendorbankapprover1; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                if (vendorbankapprover1 = vendorbankapprover2) or (vendorbankapprover1 = vendorbankapprover3) then
                    Error('Already exists');
            end;
        }
        field(50011; vendorbankapprover2; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            begin
                if (vendorbankapprover1 = vendorbankapprover2) or (vendorbankapprover2 = vendorbankapprover3) then
                    Error('Already exists');
            end;
        }
        field(50012; vendorbankapprover3; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            begin
                if (vendorbankapprover1 = vendorbankapprover3) or (vendorbankapprover2 = vendorbankapprover3) then
                    Error('Already exists');
            end;
        }
        field(50013; "Material Requisition"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50014; "Catering Requisition"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}