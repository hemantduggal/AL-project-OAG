pageextension 50064 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT product Posting Group"; Rec."WHT product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Setup"; Rec."WHT Setup")
            {
                ApplicationArea = all;
            }
        }
        addafter("User ID")
        {
            field(delegate; Rec.delegate)
            {
                Caption = 'delegated user';
                ApplicationArea = all;
            }
            field("Access Requisition Document"; rec."Access Requisition Document")
            {
                ApplicationArea = all;
            }//
            field("Access Purchase Quote"; Rec."Access Purchase Quote")
            {
                ApplicationArea = All;

            }
            field(BlanketPurchaseOrder; rec.BlanketPurchaseOrder)
            {
                ApplicationArea = all;
            }//
            field("Access Purchase Order"; Rec."Access Purchase Order")
            {
                ApplicationArea = All;

            }
            field("Access Purchase Invoice"; Rec."Access Purchase Invoice")
            {
                ApplicationArea = All;

            }
            field("Access Purchase Return Order"; Rec."Access Purchase Return Order")
            {
                ApplicationArea = All;

            }
            field("Access Purchase Credit Memo"; Rec."Access Purchase Credit Memo")
            {
                ApplicationArea = All;

            }
            field("Access Sales Order"; Rec."Access Sales Order")
            {
                ApplicationArea = All;

            }
            field("Access Sales Invoice"; Rec."Access Sales Invoice")
            {
                ApplicationArea = All;

            }
            field("Access Sales Credit Memo"; Rec."Access Sales Credit Memo")
            {
                ApplicationArea = All;

            }
            field("Access Item Journal"; Rec."Access Item Journal")
            {
                ApplicationArea = All;

            }
            field("Access Transfer Order"; Rec."Access Transfer Order")
            {
                ApplicationArea = All;

            }
            field("Access Item Reclass"; Rec."Access Item Reclass")
            {
                ApplicationArea = All;

            }
            field("Phys.Inventory Journals"; rec."Phys.Inventory Journals")
            {
                ApplicationArea = all;
            }
            field("Access Item Master"; Rec."Access Item Master")
            {
                ApplicationArea = All;

            }
            field("Access Customer Master"; Rec."Access Customer Master")
            {
                ApplicationArea = All;

            }
            field("Access Vendor Master"; Rec."Access Vendor Master")
            {
                ApplicationArea = All;

            }
            field("Access Location Master"; Rec."Access Location Master")
            {
                ApplicationArea = All;

            }
            field("Bank Master"; rec."Bank Master")
            {
                ApplicationArea = all;
            }//
            field("Employee Master"; rec."Employee Master")
            {
                ApplicationArea = all;
            }
            field(AccessFixedAssetsMaster; rec.AccessFixedAssetsMaster)
            {
                ApplicationArea = all;
            }
            field(DepreciationCalandPosting; rec.DepreciationCalandPosting)
            {
                ApplicationArea = all;
            }
            field("Disposal Posting"; rec."Disposal Posting")
            {
                ApplicationArea = all;
            }
            field("AccessPOTerms&ConditionMaster"; rec."AccessPOTerms&ConditionMaster")
            {
                ApplicationArea = all;
            }//
            field("Chart of Account"; Rec."Chart of Account")
            {
                ApplicationArea = All;

            }
            field("Dimension Values"; Rec."Dimension Values")
            {
                ApplicationArea = All;

            }
            field(Budget; rec.Budget)
            {
                ApplicationArea = all;
            }///
            field("VAT Setup"; rec."VAT Setup")
            {
                ApplicationArea = all;
            }
            /*  field("WHT Setup"; rec."WHT Setup")
              {
                  ApplicationArea = all;
              }*/
            field(Currencies; rec.Currencies)
            {
                ApplicationArea = all;
            }
            field("Adjust Exchange Rates"; rec."Adjust Exchange Rates")
            {
                ApplicationArea = all;
            }
            field("YearEndBooking Closing"; rec."YearEndBooking Closing")
            {
                ApplicationArea = all;
            }
            field("Accounting Periods"; rec."Accounting Periods")
            {
                ApplicationArea = all;
            }//

            field("Access General Journals"; Rec."Access General Journals")
            {
                ApplicationArea = All;

            }
            field("Access Bank Receipt Voucher"; Rec."Access Bank Receipt Voucher")
            {
                ApplicationArea = All;

            }
            field("Access Bank Payment Voucher"; Rec."Access Bank Payment Voucher")
            {
                ApplicationArea = All;

            }
            field("Access FA Journals"; Rec."Access FA Journals")
            {
                ApplicationArea = All;

            }

            field("Access Bank Rec."; Rec."Access Bank Rec.")
            {
                ApplicationArea = All;

            }
            field("Access User Setup"; Rec."Access User Setup")
            {
                ApplicationArea = All;

            }
            field("AccessNo.Series"; rec."AccessNo.Series")
            {
                ApplicationArea = all;
            }//
            field("G/L Register"; Rec."G/L Register")
            {
                ApplicationArea = all;
            }
            field("Item Ledger Entry"; Rec."Item Ledger Entry")
            {
                ApplicationArea = all;
            }
            field("Vendor Ledger Entry"; Rec."Vendor Ledger Entry")
            {
                ApplicationArea = all;
            }
            field("Customer Ledger Entry"; Rec."Customer Ledger Entry")
            {
                ApplicationArea = all;
            }
            field("EMP.Ledger Entry"; Rec."EMP.Ledger Entry")
            {
                ApplicationArea = all;
            }
            field("Bank Ledger Entry"; Rec."Bank Ledger Entry")
            {
                ApplicationArea = all;
            }///
            field("Access FA G/L Journals"; Rec."Access FA G/L Journals")
            {
                ApplicationArea = All;

            }
            field("Access G\L Account"; Rec."Access G\L Account")
            {
                ApplicationArea = All;

            }
            field("Access Payment Journal"; Rec."Access Payment Journal")///////can add
            {
                ApplicationArea = all;
            }
            ////short close neha
            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = all;
            }
            field("Access GL Setup"; Rec."Access GL Setup")
            {
                ApplicationArea = All;
            }
            field(storeuser; Rec.storeuser)
            {
                Caption = 'Store User';
                ApplicationArea = all;
            }
            field(accountuser; Rec.accountuser)
            {
                Caption = 'FICO User';
                ApplicationArea = all;
            }
            field(faclass; Rec.faclass)
            {
                Caption = 'FA Class Handler';
                ApplicationArea = all;
            }
            field(ChangeCurrency; Rec.ChangeCurrency)
            {
                ApplicationArea = all;
            }
            field(payrollnotification; Rec.payrollnotification)
            {
                ApplicationArea = all;
            }

            /*field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Allow Indent Line Approval"; Rec."Allow Indent Line Approval")
            {
                ApplicationArea = All;

            }
            field("Allow Indent Line Re-open"; Rec."Allow Indent Line Re-open")
            {
                ApplicationArea = All;

            }
            field("Store Locations"; Rec."Store Locations")
            {
                ApplicationArea = All;

            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;

            }
            field("Allow Calculate Bag Weight"; Rec."Allow Calculate Bag Weight")
            {
                ApplicationArea = All;

            }
            field("Allow Prod. BOM Usage"; Rec."Allow Prod. BOM Usage")
            {
                ApplicationArea = All;

            }
            field("HO Users"; Rec."HO Users")
            {
                ApplicationArea = All;

            }
            field("Short Close on Prod. Order"; Rec."Short Close on Prod. Order")
            {
                ApplicationArea = All;

            }
            field("Salesperson User"; Rec."Salesperson User")
            {
                ApplicationArea = All;

            }
            field("Access FA Reclass. Journals"; Rec."Access FA Reclass. Journals")
            {
                ApplicationArea = All;

            }
            field("Access GRN"; Rec."Access GRN")
            {
                ApplicationArea = All;

            }*/


            /*   field("Access Sales Order"; Rec."Access Sales Order")
               {
                   ApplicationArea = All;

               }
               field("Access Sales Return Order"; Rec."Access Sales Return Order")
               {
                   ApplicationArea = All;

               }*/


            /* field("Access Cash Receipt Journal"; Rec."Access Cash Receipt Journal")
             {
                 ApplicationArea = All;

             }*/


            /*   field("Imprest Permission"; Rec."Imprest Permission")
               {
                   ApplicationArea = All;

               }
            field("Tax Details Permission"; Rec."Tax Details Permission")
            {
                ApplicationArea = All;

            }*/

            /*  field("Service Tax Setup"; Rec."Service Tax Setup")
              {
                  ApplicationArea = All;

              }
              field("TDS NOD/NOC Setup"; Rec."TDS NOD/NOC Setup")
              {
                  ApplicationArea = All;

              }
              field("Sales Tax Setup"; Rec."Sales Tax Setup")
              {
                  ApplicationArea = All;

              }*/

            /*  field("Acccess GST Group Code"; Rec."Acccess GST Group Code")
              {
                  ApplicationArea = All;

              }
            field("Acccess HSN/SAC Code"; Rec."Acccess HSN/SAC Code")
            {
                ApplicationArea = All;

            }
            //....
            field("Acccess GST Configuration"; Rec."Acccess GST Configuration")
            {
                ApplicationArea = All;

            }
            field("Acccess GST Setup"; Rec."Acccess GST Setup")
            {
                ApplicationArea = All;

            }
            field("Access Purchase Journal"; Rec."Access Purchase Journal")
            {
                ApplicationArea = All;

            }
            field("Access Sales Journal"; Rec."Access Sales Journal")
            {
                ApplicationArea = All;

            }
            field("Access Cash Receipt Voucher"; Rec."Access Cash Receipt Voucher")
            {
                ApplicationArea = All;

            }
            field("Access Cash Payment Voucher"; Rec."Access Cash Payment Voucher")
            {
                ApplicationArea = All;

            }*/


            /*  field("Access Journal Voucher"; Rec."Access Journal Voucher")
              {
                  ApplicationArea = All;

              }
            field("Access Contra Voucher"; Rec."Access Contra Voucher")
            {
                ApplicationArea = All;

            }
            field("Access Ship to Address"; Rec."Access Ship to Address")
            {
                ApplicationArea = All;

            }
            field("Access Breed Master"; Rec."Access Breed Master")
            {
                ApplicationArea = All;

            }
            field("Access Data Entry Sheet"; Rec."Access Data Entry Sheet")
            {
                ApplicationArea = All;

            }
            field("Access Hatchry Entry Sheet"; Rec."Access Hatchry Entry Sheet")
            {
                ApplicationArea = All;

            }
            field("Access Parameter List"; Rec."Access Parameter List")
            {
                ApplicationArea = All;

            }
            field("Access Template Master"; Rec."Access Template Master")
            {
                ApplicationArea = All;

            }*/


            /* field("Access Gate In & Gate Out"; Rec."Access Gate In & Gate Out")
             {
                 ApplicationArea = All;

             }
            field("Access Indent"; Rec."Access Indent")
            {
                ApplicationArea = All;

            }
            field("Access Normal GC Statement"; Rec."Access Normal GC Statement")
            {
                ApplicationArea = All;

            }
            field("Access EC GC Statement"; Rec."Access EC GC Statement")
            {
                ApplicationArea = All;

            }
            field("Access RGP"; Rec."Access RGP")
            {
                ApplicationArea = All;

            }
            field("Access NRGP"; Rec."Access NRGP")
            {
                ApplicationArea = All;

            }*/
            //....

            /*  field("Access Prod. BOM"; Rec."Access Prod. BOM")
              {
                  ApplicationArea = All;

              }
              field("Access R Prod. Order"; Rec."Access R Prod. Order")
              {
                  ApplicationArea = All;

              }
              field("Access Work Center"; Rec."Access Work Center")
              {
                  ApplicationArea = All;

              }
              field("Access Machine Center"; Rec."Access Machine Center")
              {
                  ApplicationArea = All;

              }
              field("Access Routing"; Rec."Access Routing")
              {
                  ApplicationArea = All;

              }
            field("Access Bank Account"; Rec."Access Bank Account")
            {
                ApplicationArea = All;

            }
            field("Access Payment Journal"; Rec."Access Payment Journal")///////can add
            {
                ApplicationArea = all;
            }
            field("Access GL Setup"; Rec."Access GL Setup")
            {
                ApplicationArea = All;

            }*/

            /*  field("Access User"; Rec."Access User")
              {
                  ApplicationArea = All;

              }*/


            /*  field("TO Post With Prod.Order"; Rec."TO Post With Prod.Order")
              {
                  ApplicationArea = All;

              }
              field("Liquidation Date"; Rec."Liquidation Date")
              {
                  ApplicationArea = All;

              }
              field("Edit Flock No. ILE"; Rec."Edit Flock No. ILE")
              {
                  ApplicationArea = All;

              }
              field("Reverse Transaction"; Rec."Reverse Transaction")
              {
                  ApplicationArea = All;

              }
            field(Department; Rec.Department)
            {
                ApplicationArea = All;

            }
           
            field("User Permission"; Rec."User Permission")
            {
                ApplicationArea = All;

            }
            field("Date Freeze"; Rec."Date Freeze")
            {
                ApplicationArea = All;

            }
            field("Day Aceess"; Rec."Day Aceess")
            {
                ApplicationArea = All;

            }
            field("CBF Line No."; Rec."CBF Line No.")
            {
                ApplicationArea = All;

            }*/
        }
    }

    /* delete this for work process
        trigger OnDeleteRecord(): Boolean
        begin
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not delete the User Setup');

        end;

        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        begin
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
            //  ERROR('You do not have Permission to Change Purchase Quote Details');
        end;

        trigger OnModifyRecord(): Boolean
        begin
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
            //    ERROR('You do not have Permission to Change Purchase Quote Details');
            //PRU_DD 1.10
        end;

        trigger OnNewRecord(BelowxRec: Boolean)
        begin
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);


            //   ERROR('You do not have Permission to add new Purchase Quote Details');
            //PRU_DD 1.10
        end;

        trigger OnAfterGetRecord()
        begin
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
        end;

        trigger OnOpenPage()
        begin

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::" ");
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have permission to open User Setup');

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access User Setup", '%1', UserSetup."Access User Setup"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
        end;

    */
    var
        UserSetup: Record 91;
        myInt: Integer;
}