report 50020 FixedAsset

{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\FixedAsset.rdl';
    ApplicationArea = All;
    Caption = 'Oag Fixed Asset Register';
    UsageCategory = Administration;
    dataset
    {

        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            column(FA_Posting_Group; "FA Posting Group")
            {

            }
            column(CmpName; CompanyInfo.Name)
            {

            }
            column(Cost_Control_Center; "Cost/Control Center")
            {

            }
            column(Description; Description)
            {

            }
            column(Serial_No_; "Serial No.")
            {

            }
            column(FA_Location_Code; "FA Location Code")
            {

            }
            column(Condition; Condition)
            {

            }
            column(Date_of_Purchase; "Date of Purchase")
            {

            }
            column(FACost; FACost)
            {

            }

            trigger OnPreDataItem()
            var
            begin


            end;

            trigger OnAfterGetRecord()
            var
                FALedgerEntry: Record "FA Ledger Entry";
            Begin
                Clear(FACost);
                FALedgerEntry.Reset();
                FALedgerEntry.SetRange("FA No./Budgeted FA No.", "No.");
                //FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                if FALedgerEntry.FindFirst() then
                    FACost += FALedgerEntry.Amount;
            end;
        }
    }

    trigger OnPreReport()
    var
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    trigger OnPostReport()
    var
    begin

    end;

    var
        CompanyInfo: Record "Company Information";
        FACost: Decimal;

}
