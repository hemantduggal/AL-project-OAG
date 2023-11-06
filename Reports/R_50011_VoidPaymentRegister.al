report 50011 "Void Payment Register"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Void Payment Register';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\VoidPaymentRegister.rdl';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            column(Document_No_; "Document No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Vendor_Name; "Vendor Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(PayeeAccNo; PayeeAccNo)
            {

            }
            column(PayeeBank; PayeeBank)
            {

            }
            column(PayeeBranch; PayeeBranch)
            {

            }
            column(FromDate; FromDate)
            {

            }
            column(ToDate; ToDate)
            {

            }
            trigger OnPreDataItem()
            var
            begin
                SetRange("Posting Date", FromDate, ToDate);
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(PayeeAccNo);
                Clear(PayeeBank);
                Clear(PayeeBranch);

                RecVendBankAcc.Reset();
                RecVendBankAcc.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                if RecVendBankAcc.FindFirst() then begin
                    PayeeAccNo := RecVendBankAcc."Bank Account No.";
                    PayeeBank := RecVendBankAcc.Name;
                    PayeeBranch := RecVendBankAcc."Bank Branch No.";
                end;
            end;
        }
    }
    /* requestpage
     {
         SaveValues = true;

         layout
         {
             area(content)
             {
                 group("Date Filter")
                 {
                     Caption = 'Date Filter';
                     field(FromDate; FromDate)
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'From Date';
                         Visible = false;
                         trigger OnValidate()
                         begin
                             //if ToDate = 0D then
                             //  Error('Enter Date');
                         end;
                     }
                     field(ToDate; ToDate)
                     {
                         ApplicationArea = Basic, Suite;
                         Caption = 'To Date';
                         trigger OnValidate()
                         begin

                         end;
                     }
                 }
             }
         }
     }
     */
    var
        RecVendBankAcc: Record "Vendor Bank Account";
        PayeeAccNo: Text[30];
        PayeeBank: Text[100];
        PayeeBranch: Text[20];
        FromDate: Date;
        ToDate: Date;
}