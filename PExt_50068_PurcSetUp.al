pageextension 50068 PurcSetUpExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("Purch. Requisition"; rec."Purch. Requisition")
            {
                ApplicationArea = all;
            }
            field("Archie Requisition No."; Rec."Archie Requisition No.")
            {
                ApplicationArea = all;
            }
            field("Material Requisition"; Rec."Material Requisition")
            {
                ApplicationArea = all;
            }
            field("Catering Requisition"; Rec."Catering Requisition")
            {
                ApplicationArea = all;
            }
        }
        addafter("Number Series")
        {
            group("Visual Inspection Setup")
            {
                field("Visual Inspection Mandatory"; Rec."Visual Inspection Mandatory")
                {
                    ApplicationArea = all;
                }
                field("Store User Mandatory"; Rec."Store User Mandatory")
                {
                    ApplicationArea = all;
                }
                field("Internal Auditor Mandatory"; Rec."Internal Auditor Mandatory")
                {
                    ApplicationArea = all;
                }
                field("Contract Manager Mandatory"; Rec."Contract Manager Mandatory")
                {
                    ApplicationArea = all;
                }
            }
            group(WHT)
            {
                Caption = 'WHT';
                field("WHT Certificate No. Series"; rec."WHT Certificate No. Series")
                {
                    ApplicationArea = all;
                }
                field("Print Dialog"; rec."Print Dialog")
                {
                    ApplicationArea = all;
                }
                field("Print WHT Docs. on Pay. Post"; rec."Print WHT Docs. on Pay. Post")
                {
                    ApplicationArea = all;
                }
                field("Print WHT Docs. on Credit Memo"; rec."Print WHT Docs. on Credit Memo")
                {
                    ApplicationArea = all;
                }
            }
            group("Vendor Bank Approver")
            {
                field("Approver 1"; Rec.vendorbankapprover1)
                {
                    Caption = 'Approver 1';
                    ApplicationArea = all;
                }
                field("Approver 2"; Rec.vendorbankapprover2)
                {
                    Caption = 'Approver 2';
                    ApplicationArea = all;
                }
                field("Approver 3"; Rec.vendorbankapprover3)
                {
                    Caption = 'Approver 3';
                    ApplicationArea = all;
                }
            }
        }
    }



    var
        myInt: Integer;
}