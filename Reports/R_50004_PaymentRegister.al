report 50004 Payment_Register
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Payment Register';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PaymentRegister.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            // RequestFilterFields = "No.";
            column(BankName; Name)
            {

            }
            column(BankBranch; "Bank Branch No.")
            {

            }
            column(AccountName; "Name 2")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(Bank_Account_No_; "Bank Account No.")
            {

            }
            column(EFTDoc; EFTDoc)
            {

            }
            column(PostingDate; PostingDate)
            {

            }
            column(VendName; VendName)
            {

            }
            column(Amt; Amt)
            {

            }

            column(FromDate; FromDate)
            {

            }
            column(ToDate; ToDate)
            {

            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Bal. Account No." = field("No.");
                column(Document_No_; "EFT/Document No.")
                {

                }

                column(Posting_Date; "Posting Date")
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
                column(Amount__LCY_; "Amount (LCY)")
                {

                }
                column(Vendor_Name; "Vendor Name")
                {

                }
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", FromDate, ToDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    RecVendBankAcc.Reset();
                    RecVendBankAcc.SetRange("Vendor No.", "Vendor No.");
                    if RecVendBankAcc.FindFirst() then begin
                        PayeeAccNo := RecVendBankAcc."Bank Account No.";
                        PayeeBank := RecVendBankAcc.Name;
                        PayeeBranch := RecVendBankAcc."Address 2";
                    end;
                end;
            }
            trigger OnPreDataItem()
            var
            begin
                // SetRange("Posting Date", FromDate, ToDate);
                SetRange("No.", acc);
            end;

            // trigger OnAfterGetRecord()
            // begin
            //     Clear(EFTDoc);
            //     Clear(PostingDate);
            //     Clear(VendName);
            //     Clear(Amt);
            //     Clear(PayeeAccNo);
            //     Clear(PayeeBank);
            //     Clear(PayeeBranch);

            //     RecVendLedger.Reset();
            //     RecVendLedger.SetRange("Posting Date", FromDate, ToDate);
            //     RecVendLedger.SetFilter("Document Type", '%1', RecVendLedger."Document Type"::Payment);
            //     //RecVendLedger.SetFilter("Bal. Account Type", '%1', RecVendLedger."Bal. Account Type"::"Bank Account");
            //     RecVendLedger.SetFilter("Currency Code", '..%1', "Currency Code");
            //     RecVendLedger.SetRange("Bal. Account No.", acc);
            //     if RecVendLedger.FindFirst() then begin
            //         EFTDoc := RecVendLedger."EFT/Document No.";
            //         PostingDate := RecVendLedger."Posting Date";
            //         VendName := RecVendLedger."Vendor Name";
            //         Amt := RecVendLedger."Amount (LCY)";

            //         RecVendBankAcc.Reset();
            //         // RecVendLedger.SetRange("Posting Date", FromDate, ToDate);
            //         RecVendBankAcc.SetRange("Vendor No.", RecVendLedger."Vendor No.");
            //         if RecVendBankAcc.FindFirst() then begin
            //             PayeeAccNo := RecVendBankAcc."Bank Account No.";
            //             PayeeBank := RecVendBankAcc.Name;
            //             PayeeBranch := RecVendBankAcc."Address 2";
            //         end;
            //     end;
            // end;
        }
    }
    requestpage
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
                    field(acc; acc)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'bank account';
                        TableRelation = "Bank Account";
                    }
                }
            }
        }
    }
    var
        acc: code[20];
        RecBankAccLed: Record "Bank Account Ledger Entry";
        EFTDoc: code[20];
        PostingDate: date;
        RecVendLedger: Record "Vendor Ledger Entry";
        VendName: text[30];
        Amt: Decimal;
        RecVendBankAcc: Record "Vendor Bank Account";
        PayeeAccNo: Text[30];
        PayeeBank: Text[100];
        PayeeBranch: Text[20];
        FromDate: Date;
        ToDate: Date;
}