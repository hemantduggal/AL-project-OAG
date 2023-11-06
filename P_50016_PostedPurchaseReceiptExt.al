pageextension 50016 PostedPurchaseReceiptExt extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Responsibility Center")
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
                Editable = false;
            }
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addafter(Invoicing)
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
    }

    /*  trigger OnOpenPage()
      begin

          //<<PRU_RC
          UserSetup.GET(USERID);
          Rec.FILTERGROUP(2);
          Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
          Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
          IF NOT UserSetup."HO Users" THEN
              Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
          Rec.FILTERGROUP(0);
      end;
  */
    var
        UserSetup: Record 91;
}