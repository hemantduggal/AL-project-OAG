pageextension 50069 PostedPurcInvoiceExt extends "Posted Purchase Invoice"
{
    layout
    {

        addafter(Corrective)
        {
            field("Purchase Type"; Rec."Purchase Type")
            {
                ApplicationArea = all;
            }
            field("Requisition Slip No."; Rec."Requisition Slip No.")
            {
                ApplicationArea = all;

            }
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Invoice Details")
        {
            group("Terms and Conditions")
            {
                field("Details T&C (Attach)"; Rec."Details T&C (Attach)")
                {
                    ApplicationArea = all;
                }
                field("General T&C"; Rec."General T&C")
                {
                    ApplicationArea = all;
                }
                field("Special T&C "; Rec."Special T&C ")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Terms and Conditions")
        {
            group("Visual Inspection Details")
            {
                field("Store Admin Comment"; Rec."Store Admin Comment")
                {
                    ApplicationArea = all;
                }
                field("Store_Visual Date"; Rec."Store_Visual Date")
                {
                    ApplicationArea = all;
                }
                field(Store_Accepted; Rec.Store_Accepted)
                {
                    ApplicationArea = all;
                }
                field(Store_Rejected; Rec.Store_Rejected)
                {
                    ApplicationArea = all;
                }
                field("Store_File Attachment Link"; Rec."Store_File Attachment Link")
                {
                    ApplicationArea = all;
                }
                field("Contract Admin Comment"; Rec."Contract Admin Comment")
                {
                    ApplicationArea = all;
                }
                field("Contract_Visual Date"; Rec."Contract_Visual Date")
                {
                    ApplicationArea = all;
                }
                field(Contract_Accepted; Rec.Contract_Accepted)
                {
                    ApplicationArea = all;
                }
                field(Contract_Rejected; Rec.Contract_Rejected)
                {
                    ApplicationArea = all;
                }
                field("Contract_File Attachment Link"; Rec."Contract_File Attachment Link")
                {
                    ApplicationArea = all;
                }

                field("Internal Admin Comment"; Rec."Internal Admin Comment")
                {
                    ApplicationArea = all;
                }
                field("Internal_Visual Date"; Rec."Internal_Visual Date")
                {
                    ApplicationArea = all;
                }
                field(Internal_Accepted; Rec.Internal_Accepted)
                {
                    ApplicationArea = all;
                }
                field(Internal_Rejected; Rec.Internal_Rejected)
                {
                    ApplicationArea = all;
                }
                field("Internal_File Attachment Link"; Rec."Internal_File Attachment Link")
                {
                    ApplicationArea = all;
                }
            }

        }
        addafter("Creditor No.")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            /*   field("Actual Vendor No."; Rec."Actual Vendor No.")
               {
                   ApplicationArea = all;
               }*/
        }
    }
}